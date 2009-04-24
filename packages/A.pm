use v6;

BEGIN { @*INC.push('t/spec/packages') };
use B;
class A {
    has B $.x;
}
