use v6;

use Test;

plan 142;

# L<S05/Substitution/>

my $str = 'hello';

is $str.subst(/h/,'f'),       'fello', 'We can use subst';
is $str,                      'hello', '.. withouth side effect';

is $str.subst('h','f'),       'fello', '.. or using Str as pattern';
is $str.subst('.','f'),       'hello', '.. with literal string matching';

my $i=0;
is $str.subst(/l/,{$i++}),    'he0lo', 'We can have a closure as replacement';
is $str.=subst(/l/,'i'),      'heilo', '.. and with the .= modifier';
is $str,                      'heilo', '.. it changes the receiver';

# not sure about this. Maybe '$1$0' should work.

is 'a'.subst(/(.)/,"$1$0"), '',       '.. and it can not access captures from strings';
is 'a'.subst(/(.)/,{$0~$0}),'aa',     '.. you must wrap it in a closure';
is '12'.subst(/(.)(.)/,{$()*2}),'24', '.. and do nifty things in closures';

# RT #116224
#?niecza skip "Cannot assign to \$/"
{
    $/ = '-';
    is 'a'.subst("a","b"), 'b', '"a".subst("a", "b") is "b"';
    is $/,                 '-', '$/ is left untouched';

    is 'a'.subst(/a/,"b"), 'b', '"a".subst(/a/, "b") is "b"';
    is $/,                 'a', '$/ matched "a"';

    is 'a'.subst(/x/,"y"), 'a', '"a".subst(/x/, "y") is "a"';
    nok $/,                     '$/ is a falsey';

    $_ = 'a';
    is ~s/a/b/,            'a', '$_ = "a"; s/a/b/ stringifies to "a"';
    is $_,                 'b', '$_ is "b"';
    is $/,                 'a', '$/ matched "a"';

    $_ = 'a';
    is ~s/x/y/,             '', '$_ = "a"; s/x/y/ stringifies to ""';
    nok $/,                     '$/ is a falsey';
}

{
    is 'a b c d'.subst(/\w/, 'x', :g),      'x x x x', '.subst and :g';
    is 'a b c d'.subst(/\w/, 'x', :global), 'x x x x', '.subst and :global';
    is 'a b c d'.subst(/\w/, 'x', :x(0)),   'a b c d', '.subst and :x(0)';
    is 'a b c d'.subst(/\w/, 'x', :x(1)),   'x b c d', '.subst and :x(1)';
    is 'a b c d'.subst(/\w/, 'x', :x(2)),   'x x c d', '.subst and :x(2)';
    is 'a b c d'.subst(/\w/, 'x', :x(3)),   'x x x d', '.subst and :x(3)';
    is 'a b c d'.subst(/\w/, 'x', :x(4)),   'x x x x', '.subst and :x(4)';
    is 'a b c d'.subst(/\w/, 'x', :x(5)),   'a b c d', '.subst and :x(5)';
    is 'a b c d'.subst(/\w/, 'x', :x(*)),   'x x x x', '.subst and :x(*)';

    is 'a b c d'.subst(/\w/, 'x', :x(0..1)), 'x b c d', '.subst and :x(0..1)';
    is 'a b c d'.subst(/\w/, 'x', :x(1..3)), 'x x x d', '.subst and :x(0..3)';
    is 'a b c d'.subst(/\w/, 'x', :x(3..5)), 'x x x x', '.subst and :x(3..5)';
    is 'a b c d'.subst(/\w/, 'x', :x(5..6)), 'a b c d', '.subst and :x(5..6)';
    is 'a b c d'.subst(/\w/, 'x', :x(3..2)), 'a b c d', '.subst and :x(3..2)';

    # string pattern versions
    is 'a a a a'.subst('a', 'x', :g),      'x x x x', '.subst (str pattern) and :g';
    is 'a a a a'.subst('a', 'x', :x(0)),   'a a a a', '.subst (str pattern) and :x(0)';
    is 'a a a a'.subst('a', 'x', :x(1)),   'x a a a', '.subst (str pattern) and :x(1)';
    is 'a a a a'.subst('a', 'x', :x(2)),   'x x a a', '.subst (str pattern) and :x(2)';
    is 'a a a a'.subst('a', 'x', :x(3)),   'x x x a', '.subst (str pattern) and :x(3)';
    is 'a a a a'.subst('a', 'x', :x(4)),   'x x x x', '.subst (str pattern) and :x(4)';
    is 'a a a a'.subst('a', 'x', :x(5)),   'a a a a', '.subst (str pattern) and :x(5)';
    is 'a a a a'.subst('a', 'x', :x(*)),   'x x x x', '.subst (str pattern) and :x(*)';

    is 'a a a a'.subst('a', 'x', :x(0..1)), 'x a a a', '.subst (str pattern) and :x(0..1)';
    is 'a a a a'.subst('a', 'x', :x(1..3)), 'x x x a', '.subst (str pattern) and :x(0..3)';
    is 'a a a a'.subst('a', 'x', :x(3..5)), 'x x x x', '.subst (str pattern) and :x(3..5)';
    is 'a a a a'.subst('a', 'x', :x(5..6)), 'a a a a', '.subst (str pattern) and :x(5..6)';
    is 'a a a a'.subst('a', 'x', :x(3..2)), 'a a a a', '.subst (str pattern) and :x(3..2)';
}


# :nth
{
    is 'a b c d'.subst(/\w/, 'x', :nth(0)), 'a b c d', '.subst and :nth(0)';
    is 'a b c d'.subst(/\w/, 'x', :nth(1)), 'x b c d', '.subst and :nth(1)';
    is 'a b c d'.subst(/\w/, 'x', :nth(2)), 'a x c d', '.subst and :nth(2)';
    is 'a b c d'.subst(/\w/, 'x', :nth(3)), 'a b x d', '.subst and :nth(3)';
    is 'a b c d'.subst(/\w/, 'x', :nth(4)), 'a b c x', '.subst and :nth(4)';
    is 'a b c d'.subst(/\w/, 'x', :nth(5)), 'a b c d', '.subst and :nth(5)';

    # string pattern versions
    is 'a a a a'.subst('a', 'x', :nth(0)), 'a a a a', '.subst (str pattern) and :nth(0)';
    is 'a a a a'.subst('a', 'x', :nth(1)), 'x a a a', '.subst (str pattern) and :nth(1)';
    is 'a a a a'.subst('a', 'x', :nth(2)), 'a x a a', '.subst (str pattern) and :nth(2)';
    is 'a a a a'.subst('a', 'x', :nth(3)), 'a a x a', '.subst (str pattern) and :nth(3)';
    is 'a a a a'.subst('a', 'x', :nth(4)), 'a a a x', '.subst (str pattern) and :nth(4)';
    is 'a a a a'.subst('a', 'x', :nth(5)), 'a a a a', '.subst (str pattern) and :nth(5)';
}

# combining :nth with :x
{
    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(1,2,3,4), :x(3)),
       'x x x d e f g h',
       '.subst with :nth(1,2,3,4)) and :x(3)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(2,4,6,8), :x(2)),
       'a x c x e f g h',
       '.subst with :nth(2,4,6,8) and :x(2)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(2, 4, 1, 6), :x(3)),
       'a x c x e x g h',
       '.subst with :nth(2) and :x(3)';
}

{
    # :p
    is 'a b c d e f g h'.subst(/\w/, 'x', :p(0)),
       'x b c d e f g h',
       '.subst with :p(0)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :p(1)),
       'a b c d e f g h',
       '.subst with :p(1)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :p(2)),
       'a x c d e f g h',
       '.subst with :p(2)';
       
    # :p and :g
    #?niecza todo 
    is 'a b c d e f g h'.subst(/\w/, 'x', :p(0), :g),
       'x x x x x x x x',
       '.subst with :p(0) and :g';

    is 'a b c d e f g h'.subst(/\w/, 'x', :p(1), :g),
       'a b c d e f g h',
       '.subst with :p(1) and :g';

    #?niecza todo 
    is 'a b c d e f g h'.subst(/\w/, 'x', :p(2), :g),
       'a x x x x x x x',
       '.subst with :p(2) and :g';
}

{
    # :c
    is 'a b c d e f g h'.subst(/\w/, 'x', :c(0)),
       'x b c d e f g h',
       '.subst with :c(0)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :c(1)),
       'a x c d e f g h',
       '.subst with :c(1)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :c(2)),
       'a x c d e f g h',
       '.subst with :c(2)';
       
    # :c and :g
    is 'a b c d e f g h'.subst(/\w/, 'x', :c(0), :g),
       'x x x x x x x x',
       '.subst with :c(0) and :g';

    is 'a b c d e f g h'.subst(/\w/, 'x', :c(1), :g),
       'a x x x x x x x',
       '.subst with :c(1) and :g';

    is 'a b c d e f g h'.subst(/\w/, 'x', :c(2), :g),
       'a x x x x x x x',
       '.subst with :c(2) and :g';

    # :c and :nth(3, 4)
    #?niecza 3 todo ":nth(3, 4) NYI"
    is 'a b c d e f g h'.subst(/\w/, 'x', :c(0), :nth(3, 4)),
       'a b x x e f g h',
       '.subst with :c(0) and :nth(3, 4)';
    
    is 'a b c d e f g h'.subst(/\w/, 'x', :c(1), :nth(3, 4)),
       'a b c x x f g h',
       '.subst with :c(1) and :nth(3, 4)';
    
    is 'a b c d e f g h'.subst(/\w/, 'x', :c(2), :nth(3, 4)),
       'a b c x x f g h',
       '.subst with :c(2) and :nth(3, 4)';
}

{
    my $s = "ZBC";
    my @a = ("A", 'ZBC');

    $_ = q{Now I know my abc's};

    s:global/Now/Wow/;
    is($_, q{Wow I know my abc's}, 'Constant substitution');

    s:global/abc/$s/;
    is($_, q{Wow I know my ZBC's}, 'Scalar substitution');

{
    s:g/BC/@a[]/;
    is($_, q{Wow I know my ZA ZBC's}, 'List substitution');
}

    dies_ok { 'abc' ~~ s/b/g/ },
            "can't modify string literal (only variables)";
}

# L<S05/Modifiers/The :s modifier is considered sufficiently important>
#?niecza skip "Action method quote:ss not yet implemented"
{
    $_ = "a\nb\tc d";
    ok ss/a b c d/w x y z/, 'successful substitution returns True';
    # RT #120526
    is $_, "w\nx\ty z", 'ss/.../.../ preserves whitespace';

    dies_ok {"abc" ~~ ss/a b c/ x y z/}, 'Cannot ss/// string literal';
}

#L<S05/Substitution/As with Perl 5, a bracketing form is also supported>
{
    my $a = 'abc';
    ok $a ~~ s[b] = 'de', 's[...] = ... returns true on success';
    is $a, 'adec', 'substitution worked';

    $a = 'abc';
    nok $a ~~ s[d] = 'de', 's[...] = ... returns false on failure';
    is $a, 'abc', 'failed substitutions leaves string unchanged';
}

{
    eval_dies_ok '$_ = "a"; s:unkonwn/a/b/', 's/// dies on unknown adverb';
    eval_dies_ok '$_ = "a"; s:overlap/a/b/', ':overlap does not make sense on s///';
}

# note that when a literal is passed to 'given', $_ is bound read-only
{
    given my $x = 'abc' {
        ok (s[b] = 'de'), 's[...] = ... returns true on success';
        is $_, 'adec', 'substitution worked';
    }

    given my $y = 'abc' {
        s[d] = 'foo';
        is $_, 'abc', 'failed substitutions leaves string unchanged';
    }
}

{
    my $x = 'foobar';
    ok ($x ~~ s:g[o] = 'u'), 's:g[..] = returns True';
    is $x, 'fuubar', 'and the substition worked';
}

{
    $_ = 'a b c';
    s[\w] = uc($/);
    is $_, 'A b c', 'can use $/ on the RHS';

    $_ = 'a b c';
    s[(\w)] = uc($0);
    is $_, 'A b c', 'can use $0 on the RHS';

    $_ = 'a b c';
    s:g[ (\w) ] = $0 x 2;
    is $_, 'aa bb cc', 's:g[...] and captures work together well';
}

{
    my $x = 'ABCD';
    $x ~~ s:x(2)/<.alpha>/x/;
    is $x, 'xxCD', 's:x(2)';
}

# s///
{
    my $x = 'ooooo';
    ok $x ~~ s:1st/./X/,    's:1st return value';
    is $x,  'Xoooo',        's:1st side effect';

    $x    = 'ooooo';
    ok $x ~~ s:2nd/./X/,    's:2nd return value';
    is $x,  'oXooo',        's:2nd side effect';

    $x    = 'ooooo';
    ok $x ~~ s:3rd/./X/,    's:3rd return value';
    is $x,  'ooXoo',        's:3rd side effect';

    $x    = 'ooooo';
    ok $x ~~ s:4th/./X/,    's:4th return value';
    is $x,  'oooXo',        's:4th side effect';

    $x    = 'ooooo';
    ok $x ~~ s:nth(5)/./X/, 's:nth(5) return value';
    is $x,  'ooooX',        's:nth(5) side effect';

    $x    = 'ooooo';
    nok $x ~~ s:nth(6)/./X/, 's:nth(6) return value';
    is $x,  'ooooo',        's:nth(6) no side effect';
}

# s///
{
    my $x = 'ooooo';
    $x ~~ s:x(2):nth(1,3)/o/A/;
    is $x,  'AoAoo', 's:x(2):nth(1,3) works in combination';

    $x = 'ooooo';
    $x ~~ s:2x:nth(1,3)/o/A/;
    is $x,  'AoAoo', 's:2x:nth(1,3) works in combination';
}

# RT #83484
# s// with other separators 
{
    my $x = 'abcde';
    $x ~~ s!bc!zz!;
    is $x, 'azzde', '! separator';
}

#L<S05/Substitution/Any scalar assignment operator may be used>
#?rakudo skip 's[...] op= RHS'
#?niecza skip 's[...] op= RHS'
{
    given 'a 2 3' {
        ok (s[\d] += 5), 's[...] += 5 returns True';
        is $_, 'a 7 3', 's[...] += 5 gave right result';
    }
    given 'a b c' {
        s:g[\w] x= 2;
        is $_, 'aa bb cc', 's:g[..] x= 2 worked';
    }
}

#?rakudo skip 's:g[...] ='
#?niecza skip 's:g[...] ='
{
    multi sub infix:<fromplus>(Match $a, Int $b) {
        $a.from + $b
    }

    given 'a b c' {
        ok (s:g[\w] fromplus= 3), 's:g[...] customop= returned True';
        is $_, '3 5 7', '... and got right result';
    }
}

# RT #69044
{
    sub s { 'sub s' }
    $_ = "foo";
    ok s,foo,bar, , 'bare s is always substititution';
    is s(), 'sub s', 'can call sub s as "s()"';
    $_ = "foo";
    ok s (foo) = 'bar', 'bare s is substitution before whitespace then parens';
}

# Test for :samecase
#?niecza skip ":samecase NYI"
{
    is 'The foo and the bar'.subst('the', 'that', :samecase), 'The foo and that bar', '.substr and :samecase (1)';
    is 'The foo and the bar'.subst('the', 'That', :samecase), 'The foo and that bar', '.substr and :samecase (2)';
    is 'The foo and the bar'.subst(/:i the/, 'that', :samecase), 'That foo and the bar', '.substr (string pattern) and :    samecase (1)';
    is 'The foo and the bar'.subst(/:i The/, 'That', :samecase), 'That foo and the bar', '.substr (string pattern) and :    samecase (2)';
    is 'The foo and the bar'.subst(/:i the/, 'that', :g, :samecase), 'That foo and that bar', '.substr (string pattern)     and :g and :samecase (1)';
    is 'The foo and the bar'.subst(/:i The/, 'That', :g, :samecase), 'That foo and that bar', '.substr (string pattern)     and :g and :samecase (2)';

    my $str = "that";
    is 'The foo and the bar'.subst(/:i the/, {++$str}, :samecase), 'Thau foo and the bar', '.substr and samecase, worked with block replacement';
    is 'The foo and the bar'.subst(/:i the/, {$str++}, :g, :samecase), 'Thau foo and thav bar', '.substr and :g and :samecase, worked with block replacement';
}

#?niecza skip "Regex modifiers ii and samecase NYI"
{
    $_ = 'foObar';
    s:ii/oo/au/;
    is $_, 'faUbar', ':ii implies :i';

    $_ = 'foObar';
    s:samecase/oo/au/;
    is $_, 'faUbar', ':samecase implies :i';

}

# RT #66816
#?niecza todo
{
    my $str = "a\nbc\nd";
    is $str.subst(/^^/, '# ', :g), "# a\n# bc\n# d",
        'Zero-width substitution does not make the GC recurse';
}

{
    #?niecza todo "Niecza works when it shouldn't?"
    eval_dies_ok q[ $_ = "abc"; my $i = 1; s:i($i)/a/b/ ],
        'Value of :i must be known at compile time';
    #?rakudo todo 'be smarter about constant detection'
    eval_lives_ok q[ $_ = "abc";s:i(1)/a/b/ ],
        ':i(1) is OK';
}

{
    $_ = 'foo';
    s/f(.)/b$0/;
    is $_, 'boo', 'can use $0 in RHS of s///';
}

# RT #76664
{
    class SubstInsideMethod {
        method ro($_ ) { s/c// }
    }
    
    dies_ok { SubstInsideMethod.new.ro('ccc') }, '(sanely) dies when trying to s/// a read-only variable';
}

# RT #83552
#?niecza skip 'Unable to resolve method postcircumfix:<( )> in type Any'
#?DOES 3
{
    $_ = "foo"; s[f] = 'bar';
    is $_, "baroo", 's[f] is parsed as a substitution op';
    throws_like q{$_ = "foo"; s[] = "bar";}, X::Syntax::Regex::NullRegex;
}

# RT #119201
{
    my $RT119201_s = 'abcdef';
    my $RT119201_m = '';
    $RT119201_s   .= subst(/(\w)/, { $RT119201_m = $/[0] });
    is($RT119201_m, 'a', 'get match variable in replacement of subst-mutator');
}

# RT #122349
{
    eval_lives_ok '$_ = "a";s/a$/b/;s|b$|c|;s!c$!d!;', '$ anchor directly at the end of the search pattern works';
}

done;

# vim: ft=perl6
