use v6;

use Test;

plan 11;

class Array is also { method test_method  { 1 }; };
class Hash is also { method test_method  { 1 }; };

my @named_array;

ok @named_array.test_method, "Uninitialized array";

@named_array = (1,2,3);

ok @named_array.test_method, "Populated array";

ok try({ [].test_method }), "Bare arrayref";


my $arrayref = [];

$arrayref = [];

ok $arrayref.test_method, "arrayref in a variable";

my %named_hash;

ok %named_hash.test_method, "Uninitialized hash";
%named_hash = (Foo => "bar");

ok %named_hash.test_method, "Populated hash";

ok try({ ~{foo => "bar"}.test_method }), "Bare hashref";


my $hashref = {foo => "bar"};

ok $hashref.test_method, "Named hashref";

# Now for pairs.

#?rakudo skip "No applicable candidates found to dispatch to for 'is'"
is(try({ (:key<value>).value; }), 'value', "method on a bare pair");

my $pair = :key<value>;

is $pair.value, 'value', "method on a named pair";

{
    class List is also {
        method twice {
            gather {
                take $_ * 2 for self;
            }
        }
    }

    is (1, 2, 3).twice.join('|'), "2|4|6", 'can extend class List';
}
