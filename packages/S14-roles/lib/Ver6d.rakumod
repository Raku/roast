use v6.d;
use Ver6c;

role VerRole[::T] is export { }

class Cv6d is export { }

enum Enum-v6d is export <da db dc>;

role R6d_1 is export {
    submethod r6d { }
}

role R6d_2[@stages] {
    submethod BUILD {
        @stages.push: $?ROLE.^name ~ ".BUILD";
    }
    submethod TWEAK {
        @stages.push: $?ROLE.^name ~ ".TWEAK";
    }
}

# vim: expandtab shiftwidth=4
