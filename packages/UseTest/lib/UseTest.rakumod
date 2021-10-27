use v6;
class Stupid::Class {
    has $.attrib is rw;
    method setter($x) { $.attrib = $x; }
    method getter { $.attrib };
}

# vim: expandtab shiftwidth=4
