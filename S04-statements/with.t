use v6;

use Test;

plan 81;

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
    Int,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with {
        $_;
    }
    ok $foo ~~ $expected, "\$_: with on { $with // $with.^name }";
}

## had to factor this out of the above for loop, in order to fudge for JVM
## TODO re-integrate test in above for loop once it passes on JVM
#?rakudo.jvm todo '$foo is not "$()", but Failure; RT #130775'
for oops,Slip -> $with, $expected {
    my $foo is default(Nil) = do with $with {
        $_;
    }
    ok $foo ~~ $expected, "\$_ with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$pos: with on { $with // $with.^name }";
}

## had to factor this out of the above for loop, in order to fudge for JVM
## TODO re-integrate test in above for loop once it passes on JVM
#?rakudo.jvm todo '$foo is not "$()", but Failure; RT #130775'
for oops,Slip -> $with, $expected {
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
    Int,Int

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without {
        $_;
    }
    ok $foo ~~ $expected, "\$_: without on { $without // $without.^name }";
}

## had to factor this out of the above for loop, in order to fudge for JVM
## TODO re-integrate test in above for loop once it passes on JVM
#?rakudo.jvm todo '$foo is not a Failure, but "$()"; RT #130775'
for oops,Failure -> $without, $expected {
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
    Int,Int

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$pos: without on { $without // $without.^name }";
}

## had to factor this out of the above for loop, in order to fudge for JVM
## TODO re-integrate test in above for loop once it passes on JVM
#?rakudo.jvm todo '$foo is not a Failure, but "$()"; RT #130775'
for oops,Failure -> $without, $expected {
    my $foo is default(Nil) = do
    without $without -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$pos: without on { $without // $without.^name }";
}

throws-like 'without 1 {...} else {...}', X::Comp, "else is not valid on without";
throws-like 'without 1 {...} orwith 2 {...}', X::Comp, "orwith is not valid on without";
throws-like 'without 1 {...} elsif 2 {...}', X::Comp, "elsif is not valid on without";

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,43,
    Int,  1,1,
    Int,Str,43,
    Int,Nil,43,
    Nil,Int,43,
    Int,oops,43

-> $with, $elsif, $expected {

    $_ = 43;
    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    elsif $elsif {
        $foo = $elsif;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: with on { $with // $with.^name }, elsif on { $elsif // $elsif.^name }";
}

for
      0,  1,1,
      1,  0,1,
     (),  3,3,
      0, (),(),
      0,  0,0,
      0,  1,1,
      0,Str,Str,
      0,Nil,Nil,
      0,Int,Int

-> $if, $orwith, $expected {

    $_ = 43;
    my $foo is default(Nil) = 42;
    if $if {
        $foo = $if;
    }
    orwith $orwith {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: if on { $if // $if.^name }, orwith on { $orwith // $orwith.^name }";
}

## had to factor this out of the above for loop, in order to fudge for JVM
## TODO re-integrate test in above for loop once it passes on JVM
#?rakudo.jvm skip 'Failure from oops is thrown; RT #130775'
{
    for
          0,oops,Failure

    -> $if, $orwith, $expected {

        $_ = 43;
        my $foo is default(Nil) = 42;
        if $if {
            $foo = $if;
        }
        orwith $orwith {
            $foo = $_;
        }
        else {
            $foo = $_;
        }
        ok $foo ~~ $expected, "\$_: if on { $if // $if.^name }, orwith on { $orwith // $orwith.^name }";
    }
}

# RT #130279
subtest '`else` and kin with `without` errors out' => {
    plan 3;
    throws-like 'without 1 {} else     {}', X::Syntax::WithoutElse,
        keyword => 'else',   'using `else`';
    throws-like 'without 1 {} elsif 1  {}', X::Syntax::WithoutElse,
        keyword => 'elsif',  'using `elsif`';
    throws-like 'without 1 {} orwith 1 {}', X::Syntax::WithoutElse,
        keyword => 'orwith', 'using `orwith`';
}

# vim: ft=perl6
