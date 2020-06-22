use v6;

use Test;

plan 8;

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

# vim: expandtab shiftwidth=4
