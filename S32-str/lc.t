use v6;

use Test;

plan 12;

# L<S32::Str/Str/lc>

is(lc("hello world"), "hello world", "lowercasing string which is already lowercase");
is(lc("Hello World"), "hello world", "simple lc test");
is(lc(""), "", "empty string");
is(lc("ÅÄÖ"), "åäö", "some finnish non-ascii chars");
is(lc("ÄÖÜ"), "äöü", "lc of German Umlauts");
is(lc("ÓÒÚÙ"), "óòúù", "accented chars");
#?niecza skip 'Range stringification'
#?rakudo todo 'Range stringification'
is(lc('A'..'C'), "a b c", "lowercasing char-range");

{
    $_ = "Hello World";
    my $x = .lc;
    is($x, "hello world", 'lc uses $_ as default');
}

{ # test invocant syntax for lc
    my $x = "Hello World";
    is($x.lc, "hello world", '$x.lc works');
    is($x, 'Hello World', 'Invocant unchanged');
    is("Hello World".lc, "hello world", '"Hello World".lc works');
}

is("ÁÉÍÖÜÓŰŐÚ".lc, "áéíöüóűőú", ".lc on Hungarian vowels");

# vim: ft=perl6
