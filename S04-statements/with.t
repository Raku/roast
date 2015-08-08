use v6;

use Test;

plan 13;

for
       0,  1,0
    ,  1,  0,1
    ,Int,  0,0
#    ,Int,Str,2    # enable when todo is fixed

-> $with, $orwith, $expected {

    my $foo = 42;
    with $with {
        $foo = $_;
    }
    orwith $orwith {
        $foo = $_;
    }
    else {
        $foo = 2;
    }
#?rakudo todo '$_ not yet set in with/without block'
    is $foo, $expected, "\$_: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
       0,  1,0
    ,  1,  0,1
    ,Int,  0,0
    ,Int,Str,2

-> $with, $orwith, $expected {

    my $foo = 42;
    with $with -> $pos {
        $foo = $pos;
    }
    orwith $orwith -> $pos {
        $foo = $pos;
    }
    else {
        $foo = 2;
    }
    is $foo, $expected, "\$pos: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
       0,  0
    ,  1,  1
    ,Int, 42

-> $with, $expected {

    my $foo = 42;
    $foo = $_ with $with;
    is $foo, $expected, "postfix with on { $with // $with.^name }";
}

for
       0, 42
    ,  1, 42
    ,Int,Int

-> $without, $expected {

    my $foo = 42;
    $foo = $_ without $without;
    is $foo, $expected, "postfix without on { $without // $without.^name }";
}

# vim: ft=perl6
