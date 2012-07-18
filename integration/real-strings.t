use v6;
use Test;
plan 21;

# Rakudo had a regression that
# string returned from regexes were Parrot strings, not Perl 6 strings.
# Basic stuff like interpolation and .uc, .lc still worked, but other things
# did not. We test it here by calling .trans on the string, which dies
# because parrot's .trans has a different calling syntax

{
    my $x = 'a';
    is $x.trans(['a'] => ['b']), 'b', 
       'basic sanity: .trans works with native Perl 6 strings';
}

{
    my $x = 'abc'.split(/b/).[0];
    lives_ok {$x.trans(['a'] => ['b']) }, 
       'Still works with strings returned from split() (lives)';
    #?pugs todo
    is $x.trans(['a'] => ['b']), 'b',
       'Still works with strings returned from split() (result)';
    $x = 'abc'.split('b').[0];
    is $x.trans(['a'] => ['b']), 'b', 'same for split(Str)';
}

dies_ok { for "a b c".split(/\s/) -> $foo { $foo = $foo; } }, 'variables returned from split and passed to pointy block are still ro';

# used to be RT #55962

#?niecza todo 'Suspect test'
{
    my @foo = 'AB'.split('');
    @foo[0]++;
    is ~@foo, 'B B', 'Str.split(Str) works with postfix:<++>';
}

#?pugs todo 'Str'
ok 1.Str ~~ / ^ 1 $ /, 'RT 66366; 1.Str is a "good" Str';

#?pugs 2 skip 'flip'
is "helo".flip().trans("aeiou" => "AEIOU"), 'OlEh', '.flip.trans (RT 66300)';
is "helo".flip.trans(("aeiou" => "AEIOU")), 'OlEh', '.flip.trans (RT 66300)';
is "helo".lc.trans(("aeiou" => "AEIOU")),   'hElO', '.flip.trans (RT 66300)';
is <h e l o>.join.trans, 'helo', 'join returns P6 strings (RT 76564, RT 71088)';
is "helo".substr(0,3).trans, 'hel', 'substr returns P6 strings (RT 76564, RT 71088)';


# http://rt.perl.org/rt3/Ticket/Display.html?id=66596
# .subst within a multi sub didn't work
#?pugs todo
{
    multi substtest (Str $d) {
        $d.subst(/o/, 'a')
    }
    is substtest("mop"), "map", '.subst works in a multi';
}

# not a "real string', but a "real hash" bug found in Rakudo:

{
    my $x = 0;
    for $*VM.kv -> $k, $v { $x++};
    is $x, +$*VM.keys, '$*VM.kv is self-consistent';
}

# RT #67852
{
    lives_ok { 'normal'.trans() }, 'can .trans() on normal string';
    #?niecza todo 'Buffer bitops NYI' 
    lives_ok { ('bit' ~& 'wise').trans() }, 'can .trans() on bitwise result';
}

# RT #75456 hilarity
#?pugs todo
{
    ok ('1 ' ~~ /.+/) && $/ eq '1 ', 'matching sanity';
    ok +$/ == 1, 'numification of match objects with trailing whitespaces';

}

{
    my $x = 'this is a test'.chomp;
    lives_ok {$x.trans(['t'] => ['T']) }, 
       'Still works with strings returned from chomp() (lives)';
    is $x.trans(['t'] => ['T']), 'This is a TesT',
       'Still works with strings returned from chomp() (result)';
}

{
    my $contents = slurp 't/spec/integration/real-strings.t';
    lives_ok {$contents.trans(['t'] => ['T']) }, 
       'Still works with strings returned from slurp() (lives)';
}

done;

# vim: ft=perl6
