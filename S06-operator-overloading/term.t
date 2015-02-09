use v6;
use Test;
plan 7;

{
    package Foo {
        constant \term:<∞> = Inf;
        is ∞, Inf, "Can define \\term:<∞> as a constant";
    }
    dies_ok { EVAL "∞" }, "my \\term:<∞> really is lexical";
    is Foo::term:<∞>, Inf, "Constant available from package";
}

{
    {
        my \term:<∞> = Inf;
        is ∞, Inf, "Can define \\term:<∞> as lexical";
    }
    dies_ok { EVAL "∞" }, "my \\term:<∞> really is lexical";
}

{
    my $a = 0;
    my &term:<•> = { $a++ };
    is •, 0, "Can define &term:<•> as lexical";
    is •, 1, "&term:<•> evaluated each time";
}

