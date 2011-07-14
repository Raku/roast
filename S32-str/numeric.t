use v6;
use Test;

#?DOES 2
sub check($str, $expected_type, $expected_number, $desc?) {
    my $result = +$str;
    my $description = $desc // $str;
    is $result.WHAT.gist, $expected_type.gist, "$description (type)";
    ok $result == $expected_number, "$description (value)"
        or diag(
              "got:      $result\n"
            ~ "expected: $expected_number"
        );
}

check '123',        Int,    123;
check '+123',       Int,    123;
check '-123',       Int,    -123;

check '123.',       Rat,    123;
check '123.0',      Rat,    123;
check '-123.0',     Rat,    123;
check '+123.0',     Rat,    123;

check '123e0',      Num,    123;
check '-123e0',     Num,   -123;
check '+123e0',     Num,    123;
check '123e-0',     Num,    123;
check '-123e+0',    Num,   -123;
check '123E0',      Num,    123;
check '-123E0',     Num,   -123;
check '+123E0',     Num,    123;
check '123E-0',     Num,    123;
check '-123E+0',    Num,   -123;


done;

# vim: ft=perl6 
