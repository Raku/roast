use v6;
use Test;

plan 25;

=begin pod

This file attempts to cover all the possible variants in regexes that use the
<...> syntax. They are listed in the same order as they are defined in S05.

Other files may have more comprehensive tests for a specific form (such as the
character classes), and those are referenced at the correct spot.

=end pod

# L<S05/Extensible metasyntax (<...>)>

# tests for the simpler parts of <...> syntax in regexes

# the first character is whitespace
{
    is('aaaaa' ~~ /< a aa aaaa >/, 'aaaa', 'leading whitespace quotes words (space)');
    is('aaaaa' ~~ /<	a aa aaaa >/, 'aaaa', 'leading whitespace quotes words (tab)');

    eval_dies_ok('"aaaa" ~~ /<a aa>/', '<...> without whitespace calls a function (not quote words)');
}

# A leading alphabetic character means it's a capturing grammatical assertion
{
    is('moose'  ~~ /<alpha>/, 'm', 'capturing grammatical assertion (1)');
    is('1a2b3c' ~~ /<alpha>/, 'a', 'capturing grammatical assertion (2)');
}

# so if the first character is a left parenthesis, it really is a call
{
    my $pass = 0;
    my sub test (Int $a = 1) {$pass += $a}
    '3.14' ~~ /3 <test()>/;
    ok($pass, 'function call (no arguments)');
}

{
    my $pass = 0;
    my sub test (Int $a) {$pass += $a}
    '3.14' ~~ /3 <test(2)>/;
    ok($pass, 'function call (with arguments)');
}

# If the first character after the identifier is an =,
# then the identifier is taken as an alias for what follows
{
    # placeholder test for <foo=bar>
    lives_ok({'foo' ~~ /<foo=alpha>/}, 'placeholder test for <foo=bar>');
}

# If the first character after the identifier is whitespace, the subsequent
# text (following any whitespace) is passed as a regex
{
    my $is_regex = 0;
    my sub test ($a) {$is_regex++ if $a ~~ Regex}

    'whatever' ~~ /w <test hat>/;
    ok($is_regex, 'text passed as a regex (1)');

    $is_regex = 0;
    'whatever' ~~ /w <test complicated . regex '<goes here>'>/;
    ok($is_regex, 'more complicated text passed as a regex (2)');
}

# If the first character is a colon followed by whitespace the
# rest of the text is taken as a list of arguments to the method
{
    my $called_ok = 0;
    my sub test ($a, $b) {$called_ok++ if $a && $b}

    'some text' ~~ /some <test: 3, 5>/;
    ok($called_ok, 'method call syntax in <...>');
}

# No other characters are allowed after the initial identifier.
{
    eval_dies_ok('"foo" ~~ /<test*>/', 'no other characters are allowed (*)');
    eval_dies_ok('"foo" ~~ /<test|>/', 'no other characters are allowed (|)');
    eval_dies_ok('"foo" ~~ /<test&>/', 'no other characters are allowed (&)');
    eval_dies_ok('"foo" ~~ /<test:>/', 'no other characters are allowed (:)');
}

# L<S05/Extensible metasyntax (<...>)/A leading . causes a named assertion not to capture what it matches
{
    is('blorg' ~~ /<.alpha>/, '', 'leading . prevents capturing');
}

# If the dot is not followed by an identifier, it is parsed as
# a "dotty" postfix of some type, such as an indirect method call
{
    # placeholder test for <.$foo>
    lives_ok({
        my $method = 'WHAT';
        'foo bar baz' ~~ /foo <.$method>/;
    }, '<.$foo> syntax placeholder');
}

# A leading $ indicates an indirect subrule. The variable must contain
# either a Regex object, or a string to be compiled as the regex.
{
    my $rule = rx/bar/;
    my $str  = 'qwe';
    ok('bar' ~~ /<$rule>/, '<$whatever> subrule (Regex, 1)');
    ok('qwer' ~~ /<$str>/, '<$whatever> subrule (String, 1)');

    # The assertion is not captured.
    is('abar' ~~ /a<$rule>/, 'a', '<$whatever> subrule (Regex, 2)');
    is('qwer' ~~ /<$str>r/, 'r', '<$whatever> subrule (String, 2)');
}

# A leading :: indicates a symbolic indirect subrule
{
    my $name = 'alpha';
    ok('abcdef' ~~ /<::($name)>/, '<::($name)> symbollic indirect subrule');
}

# A leading @ matches like a bare array except that each element is
# treated as a subrule (string or Regex object) rather than as a literal
{
    my @first = <a b c .**>;
    ok('dddd' ~~ /<@first>/, 'strings are treated as a subrule in <@foo>');

    my @second = rx/\.**/, rx/'.**'/;
    ok('abc.**def' ~~ /<@second>/, 'Regexes are left alone in <@foo> subrule');
}

# more to do yet.
