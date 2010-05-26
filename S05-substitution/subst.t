use v6;

use Test;

plan *;

# L<S05/Substitution/>

my $str = 'hello';

is $str.subst(/h/,'f'),       'fello', 'We can use subst';
is $str,                      'hello', '.. withouth side effect';
#?rakudo skip "adverbs on rx// NYI"
is $str.subst(rx:g:i/L/,'p'), 'heppo', '.. with multiple adverbs';

is $str.subst('h','f'),       'fello', '.. or using Str as pattern';
is $str.subst('.','f'),       'hello', '.. with literal string matching';

my $i=0;
is $str.subst(/l/,{$i++}),    'he0lo', 'We can have a closure as replacement';
#?rakudo skip "adverbs on rx// NYI"
is $str.subst(rx:g/l/,{$i++}),'he12o', '.. which act like closure and can be called more then once';
is $str.=subst(/l/,'i'),      'heilo', '.. and with the .= modifier';
is $str,                      'heilo', '.. it changes the receiver';

# not sure about this. Maybe '$1$0' should work.

#?rakudo 3 skip '$/ not involved in .subst yet (unspecced?)'
is 'a'.subst(/(.)/,"$1$0"), '',       '.. and it can not access captures from strings';
is 'a'.subst(/(.)/,{$0~$0}),'aa',     '.. you must wrap it in a closure';
is '12'.subst(/(.)(.)/,{$()*2}),'24', '.. and do nifty things in closures';

{
    is 'a b c d'.subst(/\w/, 'x', :g),      'x x x x', '.subst and :g';
    is 'a b c d'.subst(/\w/, 'x', :global), 'x x x x', '.subst and :global';
    is 'a b c d'.subst(/\w/, 'x', :x(0)),   'a b c d', '.subst and :x(0)';
    is 'a b c d'.subst(/\w/, 'x', :x(1)),   'x b c d', '.subst and :x(1)';
    is 'a b c d'.subst(/\w/, 'x', :x(2)),   'x x c d', '.subst and :x(2)';
    is 'a b c d'.subst(/\w/, 'x', :x(3)),   'x x x d', '.subst and :x(3)';
    is 'a b c d'.subst(/\w/, 'x', :x(4)),   'x x x x', '.subst and :x(4)';
    is 'a b c d'.subst(/\w/, 'x', :x(5)),   'a b c d', '.subst and :x(5)';
    #?rakudo skip ':x(*)'
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
    #?rakudo skip ':x(*)'
    is 'a a a a'.subst('a', 'x', :x(*)),   'x x x x', '.subst (str pattern) and :x(*)';

    is 'a a a a'.subst('a', 'x', :x(0..1)), 'x a a a', '.subst (str pattern) and :x(0..1)';
    is 'a a a a'.subst('a', 'x', :x(1..3)), 'x x x a', '.subst (str pattern) and :x(0..3)';
    is 'a a a a'.subst('a', 'x', :x(3..5)), 'x x x x', '.subst (str pattern) and :x(3..5)';
    is 'a a a a'.subst('a', 'x', :x(5..6)), 'a a a a', '.subst (str pattern) and :x(5..6)';
    is 'a a a a'.subst('a', 'x', :x(3..2)), 'a a a a', '.subst (str pattern) and :x(3..2)';
}


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

{
    # combining :g and :nth:
    #?rakudo 2 todo 'RT #61130 -- are these tests actually wrong?'
    is 'a b c d'.subst(/\w/, 'x', :nth(1), :g), 'x x x x', '.subst and :g, :nth(1)';
    is 'a b c d'.subst(/\w/, 'x', :nth(2), :g), 'a x c x', '.subst and :g, :nth(2)';
    is 'a b c d'.subst(/\w/, 'x', :nth(3), :g), 'a b x d', '.subst and :g, :nth(3)';
}

{
    # combining :nth with :x
    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(1|2|3|4), :x(3)),
       'x x x d e f g h',
       '.subst with :nth(1) and :x(3)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth(2|4|6|8), :x(2)),
       'a x c x e f g h',
       '.subst with :nth(2) and :x(2)';

    is 'a b c d e f g h'.subst(/\w/, 'x', :nth({$_ !% 2}), :x(3)),
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
    is 'a b c d e f g h'.subst(/\w/, 'x', :p(0), :g),
       'x x x x x x x x',
       '.subst with :p(0) and :g';

    is 'a b c d e f g h'.subst(/\w/, 'x', :p(1), :g),
       'a b c d e f g h',
       '.subst with :p(1) and :g';

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

#?rakudo skip 's:global/.../../ NYI'
{
    my $s = "ZBC";
    my @a = ("A", 'ZBC');

    $_ = q{Now I know my abc's};

    s:global/Now/Wow/;
    is($_, q{Wow I know my abc's}, 'Constant substitution');

    s:global/abc/$s/;
    is($_, q{Wow I know my ZBC's}, 'Scalar substitution');

    s:g/BC/@a[]/;
    is($_, q{Wow I know my ZA ZBC's}, 'List substitution');

    dies_ok { 'abc' ~~ s/b/g/ },
            "can't modify string literal (only variables)";
}

# L<S05/Modifiers/The :s modifier is considered sufficiently important>
#?rakudo skip 'ss/.../.../'
{
    given "a\nb\tc d" {
        ok ss/a b c d/w x y z/, 'successful substitution returns True';
        is $_, "w\nx\ty z", 'ss/.../.../ preserves whitespace';
    }

    ok !("abc" ~~ ss/a b c/ x y z/), 'ss/// implies :s (-)';
}

#L<S05/Substitution/As with Perl 5, a bracketing form is also supported>
{
    my $a = 'abc';
    ok $a ~~ s[b] = 'de', 's[...] = ... returns true on success';
    is $a, 'adec', 'substitution worked';

    $a = 'abc';
    #?rakudo todo 's[...] seems to always return true?'
    nok $a ~~ s[d] = 'de', 's[...] = ... returns false on failure';
    is $a, 'abc', 'failed substitutions leaves string unchanged';
}

#?rakudo skip '$_ and s[...] do not work together yet'
{
    given 'abc' {
        ok (s[b] = 'de'), 's[...] = ... returns true on success';
        is $_, 'adec', 'substitution worked';
    }

    given 'abc' {
        s[d] = 'foo';
        is $_, 'abc', 'failed substitutions leaves string unchanged';
    }
}

#?rakudo skip "s:g[] and s[] with $/ NYI"
{
    my $x = 'foobar';
    ok ($x ~~ s:g[o] = 'u'), 's:g[..] = returns True';
    is $x, 'fuubar', 'and the substition worked';

    given 'a b c' {
        s[\w] = uc($/);
        is $_, 'A b c', 'can use $/ on the RHS';
    }
    given 'a b c' {
        s[(\w)] = uc($0);
        is $_, 'A b c', 'can use $0 on the RHS';
    }

    given 'a b c' {
        s:g[ (\w) ] = $0 x 2;
        is $_, 'aa bb cc', 's:g[...] and captures work together well';
    }
}

#L<S05/Substitution/Any scalar assignment operator may be used>
#?rakudo skip 's[...] op= RHS'
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
    #?rakudo skip 'RT 69044'
    ok s,foo,bar, , 'bare s is always substititution';
    is s(), 'sub s', 'can call sub s as "s()"';
    #?rakudo skip 's () = RHS'
    $_ = "foo";
    ok s (foo) = 'bar', 'bare s is substitution before whitespace then parens';
}

done_testing;

# vim: ft=perl6
