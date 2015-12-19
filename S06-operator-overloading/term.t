use v6;
use Test;
plan 10;

{
    package Foo {
        constant \term:<א₀> = Inf;
        is א₀, Inf, "Can define \\term:<א₀> as a constant";
    }
    dies-ok { EVAL "א₀" }, "constant \\term:<א₀> really is scoped to package";
    is Foo::term:<א₀>, Inf, "Constant available from package";
}

{
    {
        my \term:<א₀> = Inf;
        is א₀, Inf, "Can define \\term:<א₀> as lexical variable";
        is EVAL('א₀'),Inf, "\\term:<א₀> works in EVAL";
    }
    dies-ok { EVAL "א₀" }, "my \\term:<א₀> really is lexical";
}

{
    my $a = 0;
    sub term:<•> { $a++ };
    is •, 0, "Can define &term:<•> as sub";
    is •, 1, "&term:<•> evaluated each time";
}

{
    my $a = 0;
    my &term:<•> = { $a++ };
    is •, 0, "Can define &term:<•> as lexical variable";
    is •, 1, "&term:<•> evaluated each time";
}

