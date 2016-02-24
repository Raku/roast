use v6.c;

use Example2::D;
use Example2::P;

class Example2::S does Example2::D does Example2::P {
    method new() {
        "" # removing this fixes the problem
    }
}
