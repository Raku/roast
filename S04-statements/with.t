use v6;

use Test;

plan 61;

sub oops { fail "oops" }

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,oops,Failure

-> $with, $orwith, $expected {

    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    orwith $orwith {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,oops,Failure

-> $with, $orwith, $expected {

    my $foo is default(Nil) = 42;
    with $with -> $pos {
        $foo = $pos;
    }
    orwith $orwith -> $pos {
        $foo = $pos;
    }
    else -> $pos {
        $foo = $pos;
    }
    ok $foo ~~ $expected, "\$pos: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $with, $expected {

    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $with, $expected {

    my $foo is default(Nil) = 42;
    with $with -> $pos {
        $foo = $pos;
    }
    else -> $pos {
        $foo = $pos;
    }
    ok $foo ~~ $expected, "\$pos: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    oops,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with {
        $_;
    }
    ok $foo ~~ $expected, "\$_: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    oops,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$pos: with on { $with // $with.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without {
        $_;
    }
    ok $foo ~~ $expected, "\$_: without on { $without // $without.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$pos: without on { $without // $without.^name }";
}

throws-like 'without 1 {...} else {...}', X::Comp, "else is not valid on without";
throws-like 'without 1 {...} orwith 2 {...}', X::Comp, "orwith is not valid on without";
throws-like 'without 1 {...} elsif 2 {...}', X::Comp, "elsif is not valid on without";

# vim: ft=perl6
