use Test;

plan 11;

class fish {
    has $.x is required;
}

throws-like { fish.new() },
  X::Attribute::Required,
  "required attributes unset die";
lives-ok { fish.new(:x(3)) },
  "Passing in a value, no exception";

class lemur {
    has $.x;
}

lives-ok { lemur.new() }, "Non-required attributes aren't";

class sloth {
    has Int:D $.x is required;
    has Int:D $.y = self.x;
}

throws-like { sloth.new() },
  X::Attribute::Required,
  "required attributes are checked before defaults run";
is sloth.new(:x(3)).y,3,"required attribute in default";

class fowl {
    has $.y is required("foo");
}
throws-like { fowl.new() },
  X::Attribute::Required,
  why => "foo",
  "required attributes unset dies with appropriate reason";

# R#2083
{
    class ABC {
        has $!thing is required;
        method foo { $!thing }
        submethod BUILD(:$!thing = 42) {}
    }
    is ABC.new.foo, 42, 'does the is required on private attributes work';

    class DEF {
        has $!thing is required;
    }
    dies-ok { DEF.new }, 'does the is required on private attributes work';
}

subtest 'is required with array attributes' => {
    my class C1 {
        has @.arr-b = 1,2,3;
        has @.arr-r is required;
    }
    throws-like { C1.new },
        X::Attribute::Required,
        'Unassigned Array attribute marked `is required` dies';
    lives-ok { C1.new(arr-r => (4,5,6)) },
        'Constructing with an array sets required parameter';
    lives-ok { C1.new(arr-r => ()) },
        'Constructing with an empty array is considered sufficient';
    is-deeply C1.new(arr-r => ()).arr-b, [1,2,3],
        'Default array value is used if no argument passed';
    is-deeply C1.new(arr-b => 4..6, arr-r => ()).arr-b, [4,5,6],
        'Default array value is not used if argument is passed';
}

subtest 'is required with hash attributes' => {
    my class C1 {
        has %.hash-b = a => 1, b => 2;
        has %.hash-r is required;
    }
    throws-like { C1.new },
        X::Attribute::Required,
        'Unassigned Hash attribute marked `is required` dies';
    lives-ok { C1.new(hash-r => { x => 1 }) },
        'Constructing with a hash sets required parameter';
    lives-ok { C1.new(hash-r => {}) },
        'Constructing with an empty hash is considered sufficient';
    is-deeply C1.new(hash-r => {}).hash-b, { a => 1, b => 2 },
        'Default hash value is used if no argument passed';
    is-deeply C1.new(hash-b => { x => 1 }, hash-r => {}).hash-b, { x => 1 },
        'Default hash value is not used if argument is passed';
}

# https://github.com/rakudo/rakudo/issues/4624
{
    my class Box {
        has Any:D $.value is required;
        submethod BUILD(::?CLASS:D:) {
            $!value
        }
    }
    throws-like { Box.new }, X::Attribute::Required, name => '$!value';
}

# vim: expandtab shiftwidth=4
