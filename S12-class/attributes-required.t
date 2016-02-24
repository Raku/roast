use v6.c;

use Test;

plan 5;

class fish {
    has $.x is required;
}

throws-like { fish.new() }, X::Attribute::Required, "required attributes unset die";
lives-ok { fish.new(:x(3)) }, "Passing in a value, no exception";

class lemur {
    has $.x;
}

lives-ok { lemur.new() }, "Non-required attributes aren't";

class sloth {
    has Int:D $.x is required;
    has Int:D $.y = self.x;
}

throws-like { sloth.new() }, X::Attribute::Required,
    "required attributes are checked before defaults run";

is sloth.new(:x(3)).y,3,"required attribute in default";
