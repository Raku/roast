use v6;

use Example2::D;
use Example2::P;

class Example2::N does Example2::D does Example2::P {
    method perl() {
        "" # XXX if you remove this, it works?!
    }
}
