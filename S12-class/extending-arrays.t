use v6;

use MONKEY-TYPING;

use Test;

plan 11;

augment class Array { method test_method  { 1 }; };
augment class Hash { method test_method  { 1 }; };

my @named_array;

ok @named_array.test_method, "Uninitialized array";

@named_array = (1,2,3);

ok @named_array.test_method, "Populated array";

ok try { [].test_method }, "Bare arrayitem";


my $arrayitem = [];

$arrayitem = [];

ok $arrayitem.test_method, "arrayitem in a variable";

my %named_hash;

ok %named_hash.test_method, "Uninitialized hash";
%named_hash = (Foo => "bar");

ok %named_hash.test_method, "Populated hash";

ok try { ~{foo => "bar"}.test_method }, "Bare hash item";


my $hashitem = {foo => "bar"};

ok $hashitem.test_method, "Named hashitem";

# Now for pairs.

is(try { (:key<value>).value; }, 'value', "method on a bare pair");

my $pair = :key<value>;

is $pair.value, 'value', "method on a named pair";

{
    augment class List {
        method twice {
            gather {
                take $_ * 2 for self.list;
            }
        }
    }

    is (1, 2, 3).twice.join('|'), "2|4|6", 'can extend class List';
}

# vim: expandtab shiftwidth=4
