use v6.c;

use Example2::D;
use Example2::P;

class Example2::H does Example2::D does Example2::P {
    multi method new() {
        "" # XXX if you remove this, it works?!
    }
}
