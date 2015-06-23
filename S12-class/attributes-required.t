use v6;

use Test;

plan 3;

class fish {
    has $.x is required;
}

throws-like { fish.new() }, X::Attribute::Required, "required attributes unset die";
lives-ok { fish.new(:x(3)) }, "Passing in a value, no exception";

class lemur {
    has $.x;
}

lives-ok { lemur.new() }, "Non-required attributes aren't";

