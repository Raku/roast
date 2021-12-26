use v6.c;

role VerRole is export { }

class Cv6c is export { }

enum Enum-v6c is export <ca cb cc>;

role R6c_1 is export {
    submethod r6c { }
}

role R6c_2[@stages] {
    submethod BUILD {
        @stages.push: $?ROLE.^name ~ ".BUILD";
    }
    submethod TWEAK {
        @stages.push: $?ROLE.^name ~ ".TWEAK";
    }
}

# vim: expandtab shiftwidth=4
