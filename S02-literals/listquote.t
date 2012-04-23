use v6;

use Test;

plan 23;

# L<S02/Quoting forms>

my $s = join 'a', <x y z>;
is($s, "xayaz", 'list context <list>');

#?rakudo skip 'meta operators'
#?niecza skip '|<<'
#?pugs todo '|<<'
{
my $s = join |<< <a x y z>;
is($s, "xayaz", 'listop |<< <list>');
}

#?niecza skip "Preceding context expects a term, but found infix , instead"
ok( [1,2,3].join<abc> ~~ Failure , '.join<abc> parses and fails');

my @y = try { ({:a<1>, :b(2)}<a b c>) };
#?rakudo todo 'unknown errors'
ok(@y eqv [1,2,Any], '{...}<a b c> is hash subscript');

eval_dies_ok '({:a<1>, :b(2)} <a b c>)', '{...} <...> parsefail';

ok( ?((1 | 3) < 3), '(...) < 3 no parsefail');

#?pugs todo 'parsing bug'
#?rakudo todo 'parsing'
eval_dies_ok '(1 | 3)<3', '()<3 parsefail';

# WRONG: should be parsed as print() < 3
# eval 'print < 3';
# ok($!, 'print < 3 parsefail');


eval_dies_ok ':foo <1 2 3>', ':foo <1 2 3> parsefail';

dies_ok { :foo <3 }, '<3 is comparison, but dies at run time';

my $p = eval ':foo<1 2 3>';
is($p, ~('foo' => (1,2,3)), ':foo<1 2 3> is pair of list');

# Lists may contain newline characters

{
    my %e = ("foo", "bar", "blah", "blah");

    my %foo = (
            "foo", "bar",
            "blah", "blah",
    );
    is(+%foo,      +%e,      "Hashes with embedded newlines in the list (1)");
    is(%foo<foo>,  %e<foo>,  "Hashes with embedded newlines in the list (2)");
    is(%foo<blah>, %e<blah>, "Hashes with embedded newlines in the list (3)");
}

# L<S02/Forcing item context/"The degenerate case <> is disallowed">

eval_dies_ok '<>', 'bare <> is disallowed';
eval_dies_ok '<STDIN>', '<STDIN> is disallowed';

# L<S02/Quoting forms/"is autopromoted into">
{
    my $c = <a b c>;
    isa_ok($c, Parcel, 'List in scalar context becomes a Capture');
    dies_ok {$c.push: 'd'}, '... which is immutable';
}

#?rakudo skip 'magic type of <...> contents'
{
    # L<S02/Forcing item context/For any item in the list that appears to be numeric>
    my @a = <foo 3 4.5 5.60 1.2e1>;
    is ~@a, 'foo 3 4.5 5.60 1.2e1',
       '<...> numeric literals stringify correctly';
    isa_ok @a[0], Str, '<foo ...> is a Str';
    isa_ok @a[1], Int, '< ... 3 ...> is an Int';
    isa_ok @a[2], Rat, '< ... 4.5 ...> is a Rat';
    isa_ok @a[4], Num, '< ... 1.2e1 ...> is a Num';
}

# probably doesn't really belong here, but I don't know where else to put it
# :(    --moritz

# RT #76452
{
    sub f($x) { $x[0] };
    is f(my @x = (1, 2, 3)), 1, 'function call with assignment to list';
}

done();

# vim: ft=perl6
