use v6;

BEGIN { @*INC.push('t/spec/packages') };

use B::Grammar;

class B { 
    method foo { 'method foo' }
}

