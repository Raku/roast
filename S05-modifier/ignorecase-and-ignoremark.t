use v6;
use Test;

plan 24;

=begin description

Testing the C<:m> or C<:ignoremark> regex modifier - more tests are always welcome

TODO: need some tests for chars with multiple markings.
TODO: need some tests for combined :ignoremark and :sigspace modifiers

=end description

#L<S05/Modifiers/"The :m (or :ignoremark) modifier">

ok(!'ä' ~~ m/a/,  'No :ignoremark: a doesnt match ä');
ok('A' ~~ m:m:i/ä/, 'A matches ä');
ok('a' ~~ m:m:i/Ä/, 'ä matches a');
ok('à' ~~ m:m:i/a/, 'a matches à');
ok('Á' ~~ m:m:i/à/, 'a matches á');
ok('â' ~~ m:m:i/a/, 'a matches â');
ok('å' ~~ m:m:i/a/, 'a matches å');
ok('ƌ' !~~ m:m:i/d/, 'd does not match ƌ, TOPBAR is not a mark');
ok('å' ~~ m:m:i/ä/, 'Both pattern and string may contain accents');
ok('a' ~~ m:m:i/ä/, 'Pattern may contain accents');
ok('ä' ~~ m:ignoremark:ignorecase/a/, 'spelling out :ignoremark:ignorecase also works');

is('fooäàAÁâåbar' ~~ m:m:i/A+ b/,    'äàAÁâåb',  'a+ b');
is('fooäàAÁâåbar' ~~ m:m:i/<[aB]>+/, 'äàAÁâåba', 'character class');
is('fooäàAÁâåbar' ~~ m:m:i/<-[A]>+/, 'foo',      'negated character class');

is('fooäàAÁâåbar' ~~ m:m:i/<[a..b]>+/, 'äàAÁâåba', 'range in character class');

# RT #126771
{
    $_ = "Bruce Gray";
    my $x = "Andrew Egeler";
    is m:i:m/$x/, Nil, "interpolation longer than topic doesn't blow up";
}

# RT #128875
{
    my @strings = "All hell is breaking loose", "Āll hell is breakinġ loose";
    for @strings {
        my $var = "All is fine, I am sure of it";
        is-deeply $_ ~~ m:i:m/"All is fine, I am sure of it"/, False, 'RT128875 :i:m combined matches whole string when a single character match is found';
        is-deeply $_ ~~ m:i:m/$var/, False, 'RT128875 :i:m combined matches whole string when a single character match is found';
        is-deeply ('word' ~ $_) ~~ m:i:m/"All is fine, I am sure of it"/, False, 'RT128875 :i:m combined matches whole string when a single character match is found';
        is-deeply ('word' ~ $_) ~~ m:i:m/$var/, False, 'RT128875 :i:m combined matches whole string when a single character match is found';
    }
}
# vim: syn=perl6 sw=4 ts=4 expandtab
