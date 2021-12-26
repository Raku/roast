use v6.e.PREVIEW;
use Ver6c;

role VerRole[::T] is export { }

class Cv6e is export { }

enum Enum-v6e is export <ea eb ec>;

role R6e_1 {
    submethod r6e { }
}

role R6e_2[@stages] {
    submethod BUILD {
        @stages.push: $?ROLE.^name ~ ".BUILD";
    }
    submethod TWEAK {
        @stages.push: $?ROLE.^name ~ ".TWEAK";
    }
}

# vim: expandtab shiftwidth=4
