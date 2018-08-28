use v6;
use lib $?FILE.IO.parent(2).add: 'packages';
use Test;
use Test::Util;

plan 95;

=begin pod

This file attempts to cover all the possible variants in regexes that use the
<...> syntax. They are listed in the same order as they are defined in S05.

Other files may have more comprehensive tests for a specific form (such as the
character classes), and those are referenced at the correct spot.

=end pod

# L<S05/Extensible metasyntax (C<< <...> >>)/>

# tests for the simpler parts of <...> syntax in regexes

# the first character is whitespace
{
    is('aaaaa' ~~ /< a aa aaaa >/, 'aaaa', 'leading whitespace quotes words (space)');
    is('aaaaa' ~~ /<	a aa aaaa >/, 'aaaa', 'leading whitespace quotes words (tab)');

    throws-like '"aaaa" ~~ /<a aa>/', X::Method::NotFound, '<...> without whitespace calls a method (not quote words)';

    is('hello' ~~ /< hello >/, 'hello', 'degenerate case of quote list');
}

# A leading alphabetic character means it's a capturing grammatical assertion
{
    is('moose'  ~~ /<alpha>/, 'm', 'capturing grammatical assertion (1)');
    is('1a2b3c' ~~ /<alpha>/, 'a', 'capturing grammatical assertion (2)');
}

{
    my regex with-dash { '-' }
    ok '-'  ~~ /<with-dash>/, 'can call regexes which dashes (positive)';
    ok '|' !~~ /<with-dash>/, 'can call regexes which dashes (negative)';

    my regex with'hyphen { a }
    ok 'a'  ~~ /<with'hyphen>/, 'can call regex with hypen (positive)';
    ok 'b' !~~ /<with'hyphen>/, 'can call regex with hypen (negative)';
}

# so if the first character is a left parenthesis, it really is a call
#?rakudo skip '<test()> NYI RT #124519'
{
    my $pass = 0;
    my sub test (Int $a = 1) {$pass += $a}
    '3.14' ~~ /3 <test()>/;
    ok($pass, 'function call (no arguments)');
}

#?rakudo skip '<test()> NYI RT #124520'
{
    my $pass = 0;
    my sub test (Int $a) {$pass += $a}
    '3.14' ~~ /3 <test(2)>/;
    ok($pass, 'function call (with arguments)');
}

# If the first character after the identifier is an =,
# then the identifier is taken as an alias for what follows
{
    ok 'foo' ~~ /<foo=alpha>/, 'basic <foo=bar> aliasing';
    is $<foo>, 'f', 'alias works';
    is $<alpha>, 'f', 'alias does not throw away original name';
}

{
    ok 'foo' ~~ /<foo=.alpha>/, 'basic <foo=.bar> aliasing';
    is $<foo>, 'f', 'alias works';
    ok !defined($<alpha>), 'alias does throw away original name';
}

{
    ok '123gb' ~~ / <foo=.alpha> /, '<foo=.bar>';
    is $<foo>, 'g', '=. renaming worked';
    nok $<alpha>.defined, '=. removed the old capture name';
}

{
    ok 'foobar' ~~ / <foo=[bao]>+ /, '<foo=[bao]>';
    is $<foo>, < o o b a >, '=[...] renaming worked';

    ok 'foobar' ~~ / <bar=-[bao]>+ /, '<bar=-[bao]>';
    is $<bar>, 'f', '=[...] renaming worked';
}

{
    ok 'a.' ~~ / <foo=:Letter> /, '<foo=:Letter>';
    is $<foo>, 'a', '=:UniProp renaming worked';

    ok 'a.' ~~ / <bar=:!Letter> /, '<bar=:!Letter>';
    is $<bar>, '.', '=:!UniProp renaming worked';

    ok 'a.' ~~ / <baz=-:Letter> /, '<baz=-:Letter>';
    is $<baz>, '.', '=-:UniProp renaming worked';
}

# If the first character after the identifier is whitespace, the subsequent
# text (following any whitespace) is passed as a regex
#?rakudo skip 'angle quotes in regexes RT #124521'
{
    my $is_regex = 0;
    my sub test ($a) {$is_regex++ if $a ~~ Regex}

    'whatever' ~~ /w < test hat >/;
    ok($is_regex, 'text passed as a regex (1)');

    $is_regex = 0;
    'whatever' ~~ /w <test complicated . regex '<goes here>'>/;
    ok($is_regex, 'more complicated text passed as a regex (2)');
}

# If the first character is a colon followed by whitespace the
# rest of the text is taken as a list of arguments to the method
#?rakudo skip 'colon arguments NYI RT #124522'
{
    my $called_ok = 0;
    my sub test ($a, $b) {$called_ok++ if $a && $b}

    'some text' ~~ /some <test: 3, 5>/;
    ok($called_ok, 'method call syntax in <...>');
}

# No other characters are allowed after the initial identifier.
{
    throws-like '"foo" ~~ /<test*>/', Exception, 'no other characters are allowed (*)';
    throws-like '"foo" ~~ /<test|>/', Exception, 'no other characters are allowed (|)';
    throws-like '"foo" ~~ /<test&>/', Exception, 'no other characters are allowed (&)';
    # TODO currently fails with "Method 'test' not found for invocant of class 'Cursor'"
    throws-like '"foo" ~~ /<test:>/', Exception, 'no other characters are allowed (:)';
}

# L<S05/Extensible metasyntax (C<< <...> >>)/explicitly calls a method as a subrule>
{
    is('blorg' ~~ /<.alpha>/, 'b', 'leading . prevents capturing');
}

# If the dot is not followed by an identifier, it is parsed as
# a "dotty" postfix of some type, such as an indirect method call
{
    # placeholder test for <.$foo>
    lives-ok({
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

    is('abar' ~~ /a<$rule>/, 'abar', '<$whatever> subrule (Regex, 2)');
    is('qwer' ~~ /<$str>r/, 'qwer', '<$whatever> subrule (String, 2)');
}

# A leading :: indicates a symbolic indirect subrule
{
    my $name = 'alpha';
    is('..abcdef--' ~~ /<::($name)>+/, 'abcdef', '<::($name)> symbolic indirect subrule');
}

# A leading @ matches like a bare array except that each element is
# treated as a subrule (string or Regex object) rather than as a literal
{
    my @first = <a b c .**4>;
    ok('dddd' ~~ /<@first>/, 'strings are treated as a subrule in <@foo>');

    my @second = rx/\.**2/, rx/'.**2'/;
    ok('abc.**2def' ~~ /<@second>/, 'Regexes are left alone in <@foo> subrule');
}

#?v6.0.0+ skip 'The use of a hash as an assertion is reserved.'
{
    my %first = '<alpha>' => '', 'b' => '', 'c' => '';
    ok('aeiou' ~~ /<%first>/, 'strings are treated as a subrule in <%foo>');

    my %second = rx/\.**2/ => '', rx/'.**2'/ => '';
    ok('abc.**2def' ~~ /<%second>/, 'Regexes are left alone in <%foo> subrule');
}

# A leading { indicates code that produces a regex to be
# interpolated into the pattern at that point as a subrule:
{
    ok('abcdef' ~~ /<{'<al' ~ 'pha>'}>/, 'code interpolation');
}

# A leading & interpolates the return value of a subroutine call as a regex.
#?rakudo skip '<&foo()> NYI RT #124523'
{
    my sub foo {return '<alpha>'}
    ok('abcdef' ~~ /<&foo()>/, 'subroutine call interpolation');
}

# If it is a string, the compiled form is cached with the string so that
# it is not recompiled next time you use it unless the string changes.
{
    my $counter = 0;
    my $subrule = '{$counter++; \'<alpha>\'}';

    'abc' ~~ /<$subrule>/;
    is($counter, 1, 'code inside string was executed');

    'def' ~~ /<$subrule>/;
    #?rakudo todo '<$subrule> NYI RT #124524'
    is($counter, 1, 'string value was cached');
}

# A leading ?{ or !{ indicates a code assertion
{
    ok('192' ~~ /(\d**3) <?{$0 < 256}>/, '<?{...}> works');
    ok(!('992' ~~ /(\d**3) <?{$0 < 256}>/), '<?{...}> works');
    ok(!('192' ~~ /(\d**3) <!{$0 < 256}>/), '<!{...}> works');
    ok('992' ~~ /(\d**3) <!{$0 < 256}>/, '<!{...}> works');
}

{
    my $*x = 0;
    nok '' ~~ /<?{$*x}>/, 'Can use contextuals with <?{...}>';
}

# A leading [ indicates an enumerated character class
# A leading - indicates a complemented character class
# A leading + may also be supplied
# see charset.t

# The special assertion <.>
# see combchar.t

# L<S05/Extensible metasyntax (C<< <...> >>)/A leading ! indicates a negated meaning (always a zero-width assertion)>
{
    ok('1./:"{}=-' ~~ /^[<!alpha> .]+$/, '<!alpha> matches non-letter characters');
    ok(!('abcdef'   ~~ /<!alpha>./), '<!alpha> does not match letter characters');
    is(+('.2 1' ~~ /<!before 2> \d/), 1, '<!before>');
    is +$/.caps, 0, '<!before 2> does not capture';
}

# A leading ? indicates a positive zero-width assertion
{
    is(~('123abc456def' ~~ /(.+? <?alpha>)/), '123', 'positive zero-width assertion');
}

# The <...>, <???>, and <!!!> special tokens have the same "not-defined-yet"
# meanings within regexes that the bare elipses have in ordinary code
{
    throws-like '"foo" ~~ /<...>/', Exception, '<...> dies in regex match';
    # XXX: Should be warns_ok, but we don't have that yet
    lives-ok({'foo' ~~ /<???>/}, '<???> lives in regex match');
    #?rakudo todo '!!! in regexes'
    throws-like '"foo" ~~ /<!!!>/', Exception, '<!!!> dies in regex match';
}

# A leading * indicates that the following pattern allows a partial match.
# It always succeeds after matching as many characters as possible.
#?rakudo skip '<*literal> RT #124525'
{
    is(''    ~~ /^ <*xyz> $ /, '',    'partial match (0)');
    is('x'   ~~ /^ <*xyz> $ /, 'x',   'partial match (1a)');
    is('xz'  ~~ /^ <*xyz> $ /, 'x',   'partial match (1b)');
    is('yzx' ~~ /^ <*xyz> $ /, 'x',   'partial match (1c)');
    is('xy'  ~~ /^ <*xyz> $ /, 'xy',  'partial match (2a)');
    is('xyx' ~~ /^ <*xyz> $ /, 'xy',  'partial match (2a)');
    is('xyz' ~~ /^ <*xyz> $ /, 'xyz', 'partial match (3)');

    is('abc'   ~~ / ^ <*ab+c> $ /,   'abc',   'partial match with quantifier (1)');
    is('abbbc' ~~ / ^ <*ab+c> $ /,   'abbbc', 'partial match with quantifier (2)');
    is('ababc' ~~ / ^ <*'ab'+c> $ /, 'ababc', 'partial match with quantifier (3)');
    is('aba'   ~~ / ^ <*'ab'+c> $ /, 'ababc', 'partial match with quantifier (4)');
}

# A leading ~~ indicates a recursive call back into some or all of the
# current rule. An optional argument indicates which subpattern to re-use
{
    ok('1.2.' ~~ /\d+\. <~~> | <?>/, 'recursive regex using whole pattern');
    #?rakudo skip '<~~ ... >'
    ok('foodbard' ~~ /(foo|bar) d <~~0>/, 'recursive regex with partial pattern');
}

# The following tokens include angles but are not required to balance

# A <( token indicates the start of a result capture,
# while the corresponding )> token indicates its endpoint
{
    is('foo123bar' ~~ /foo <(\d+)> bar/, 123, '<(...)> pair');
    is('foo456bar' ~~ /foo <(\d+ bar/, '456bar', '<( match');
    is('foo789bar' ~~ /foo \d+)> bar/, 'foo789', ')> match');
    ok(!('foo123' ~~ /foo <(\d+)> bar/), 'non-matching <(...)>');

    is('foo123bar' ~~ /foo <( bar || ....../, 'foo123', '<( in backtracking');
    is('foo123bar' ~~ /foo <( 123 <( bar/, 'bar', 'multiple <(');
    is('foo123bar' ~~ /foo <( 123 [ <( xyz ]?/, '123', 'multiple <( backtracking');
}

# RT #129969
{
    is-eqv 'abc xbc'.comb(/a<(bc)>/), 'bc'.Seq,
        '.comb works well with <( )> (1)';
    is-eqv 'abc def abc'.comb(/a<(bc)>/), <bc bc>.Seq,
        '.comb works well with <( )> (2)';
    is-deeply 'abc'.match(/a<(bc)>/, :as(Str)), 'bc',
        '.match :as(Str) works with <( )>';
}

# A « or << token indicates a left word boundary.
# A » or >> token indicates a right word boundary.
{
   is('abc'   ~~ /<<abc/,   'abc', 'left word boundary (string beginning)');
   is('!abc'  ~~ /<<abc/,   'abc', 'left word boundary (\W character)');
   is('abc'   ~~ /abc>>/,   'abc', 'right word boundary (string end)');
   is('abc!'  ~~ /abc>>/,   'abc', 'right word boundary (\W character)');
   is('!abc!' ~~ /<<abc>>/, 'abc', 'both word boundaries (\W character)');
}

# RT #131187
{
    grammar Parser {
        token TOP { <matcher>+ }
        proto token matcher { * }
        token matcher:sym<[]> { '[' <( <-[\]]>+ )> ']' }
        token matcher:sym<lit> { <-[/*?[]>+ }
    }
    class RuleCompiler {
        # Empty action was needed to trigger the bug.
        method matcher:sym<[]>($/) { }
    }
    is Parser.parse('[AB].txt', :actions(RuleCompiler))<matcher>[1], '.txt',
        'Interaction of quantifier, <(, )>, and action method ok';
}

# vim: ft=perl6
