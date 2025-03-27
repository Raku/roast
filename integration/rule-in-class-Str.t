use MONKEY-TYPING;

use Test;

plan 3;

=begin kwid

Difficulty using a rule in a method of Str.

=end kwid

class C is Str {
    method meth1 () { }
}

lives-ok { C.new.meth1 }, "can call 'meth1' on subclass of Str";

augment class Str {
    method meth2 () { }
}

lives-ok { C.new.meth2 }, "can call 'meth2' on augmented Str";

augment class Str {
    method meth3 () { }
}

lives-ok { C.new.meth3 }, "can call 'meth3' on re-augmented Str";

# vim: expandtab shiftwidth=4
