use Test;

plan 7;

isa_ok 10 div 0   , Failure, "10 div 0 softfails";
isa_ok 10 / 0     , Rat, "10 / 0 is a Rat.";
isa_ok 10 / 0.0   , Rat, "10 / 0.0 is a Rat";
isa_ok 10 / 0e0   , Failure, "10 / 0e0 softfails";
isa_ok (1/1) / 0e0, Failure, "(1/1) / 0e0 softfails";
isa_ok 1e0 / (0/1), Failure, "1e0 / (0/1) softfails";

# RT #112678
{
    is -8 div 3, -3, '$x div $y should give same result as floor($x/$y)';
}
