use v6;

use Test;

plan 11;

=begin pod

Testing named capture variables nested inside each other. This doesn't appear to be tested by the ported Perl6::Rules tests. That may be because it's not specified in the synopsis, but Autrijus is sure this how it ought to work.

=end pod

# At the time of writing, these fail under Win32 so they are marked as bugs
# I haven't yet run them under UNIX but I believe they will work

#L<S05/Nested subpattern captures>

{
  my regex fishy { (.*)shark };
  "whaleshark" ~~ m/<fishy>/;
  is($/<fishy>[0], "whale", "named rule ordinal capture");
  is($<fishy>[0], "whale", "named rule ordinal capture with abbreviated variable");
  is $/.orig, 'whaleshark', '$/.orig works';
};

#L<S05/Named scalar aliasing to subpatterns>

#?pugs todo 'named captures'
{
  my $not_really_a_mammal;
  my regex fishy2 { $<not_really_a_mammal> = (.*)shark };
  "whaleshark" ~~ m/<fishy2>/;
  is($/<fishy2><not_really_a_mammal>, "whale", "named rule named capture");
  is($<fishy2><not_really_a_mammal>, "whale", "named rule named capture with abbreviated variable");
};

#L<S05/Subrule captures>

#?rakudo skip 'assigning to match object'
{
  my regex number {
    [ $<numeral> = <&roman_numeral>  { $<notation> = 'roman' }
    | $<numeral> = <&arabic_numeral> { $<notation> = 'arabic' }
    ]
  };
  my regex roman_numeral  { I | II | III | IV };
  my regex arabic_numeral { 1 |  2 |  3  |  4 };
  2 ~~ m/<number>/;
  is($/<number><numeral>, '2', 'binding subrule to new alias');
  is($/<number><notation>, 'roman', 'binding to alias as side-effect');
}

# RT #111286
{
    my grammar G {
        token TOP { <a>? $<b>='b' }
        token a { a }
    }
    ok G.parse('ab'), 'grammar sanity';
    is $/.keys.map(~*).sort.join(', '), 'a, b', 'right keys in top level match';
    is $<b>.elems, 0, '$<b> has no captures';
}

# RT #107746
{
    grammar a {
        token x { a };
        token y { z };
        rule TOP { [ <x> ]? [c || b <y>] }
    };
    is ~a.parse('a b z')<x>, 'a', 'can capture inside a || alternation even if previous capture was quantified (RT 107746)';
}

# vim: ft=perl6
