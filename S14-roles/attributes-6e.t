use v6.e.PREVIEW;
use Test;

plan 1;

my role R0 {
    has $.foo;
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ $!foo;
    }
}
my role R1 does R0 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}
my role R2 does R0 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}
my role R3 does R1 does R2 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}

class C does R3 {
    submethod attr-val {
        $?CLASS.^name ~ ":" ~ self.foo
    }
}

is-deeply C.new(:foo(-42)).WALK('attr-val', :roles)().List, ('C:-42', 'R3:-42', 'R1:-42', 'R2:-42', 'R0:-42'),
            "same attribute is used across all roles";



# vim: expandtab shiftwidth=4
