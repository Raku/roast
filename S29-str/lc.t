use v6;

use Test;

plan 11;

# L<S29/Str/lc>

is(lc("hello world"), "hello world", "lowercasing string which is already lowercase");
is(lc("Hello World"), "hello world", "simple lc test");
is(lc(""), "", "empty string");
#?rakudo 3 skip 'unicode'
is(lc("ÅÄÖ"), "åäö", "some finnish non-ascii chars");
is(lc("ÄÖÜ"), "äöü", "lc of German Umlauts");
is(lc("ÓÒÚÙ"), "óòúù", "accented chars");
is(lc('A'..'C'), "a b c", "lowercasing char-range");

#?rakudo skip "can't parse"
{
    $_ = "Hello World"; 
    my $x = .lc;
    is($x, "hello world", 'lc uses $_ as default');
}

{ # test invocant syntax for lc
    my $x = "Hello World";
    is($x.lc, "hello world", '$x.lc works');
    is("Hello World".lc, "hello world", '"Hello World".lc works');
}

#?rakudo skip 'unicode'
is("ÁÉÍÖÜÓŰŐÚ".lc, "áéíöüóűőú", ".lc on Hungarian vowels");
