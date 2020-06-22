use v6;

use Test;

plan 23;

{
    my $a;

    $_ = 42;
    { $_ := 43 };
    is $_, 42, 'bare block aliases $_';

    $_ = 42;
    if 1 { $_ := 43 };
    is $_, 42, 'conditional block (if) aliases $_';

    $_ = 42;
    if 0 { }
    else { $_ := 43 };
    is $_, 42, 'conditional block (else) aliases $_';

    $_ = 42;
    if 0 { }
    elsif 1 { $_ := 43 };
    is $_, 42, 'conditional block (elsif) aliases $_';

    $_ = 42; $a = 1;
    while $a-- { $_ := 43 };
    is $_, 42, 'conditional loop block (while) aliases $_';

    $_ = 42; $a = 0;
    until $a++ { $_ := 43 };
    is $_, 42, 'conditional loop block (while) aliases $_';

    my $c = 43;
    my $d = 42;

    $_ := $d;
    if $_ := $c { };
    is $_, 43, 'condition of conditional block (if) does not alias $_';

    $_ := $d;
    if 0 { }
    elsif $_ := $c { };
    is $_, 43, 'condition of conditional block (elsif) does not alias $_';

    $_ := $d; $a = 0;
    while ($_ := $c) + $a++ < 44 { };
    is $_, 43, 'condition of loop block (while) does not alias $_';

    $_ := $d; $a = 0;
    until ($_ := $c) + $a++ > 43 { };
    is $_, 43, 'condition of loop block (until) does not alias $_';

    $_ := $d; $a = 0;
    while $_++ < 44 { my $b = 44; $_ := $b; $a++ };
    is $a, 2, 'no interaction between $_s from conditional and body in loop (while)';

    $d = 42;
    $_ := $d; $a = 0;
    until $_++ >= 44 { my $b = 44; $_ := $b; $a++ };
    is $a, 2, 'no interaction between $_s from conditional and body in loop (until)';
}


# Tests for a bug uncovered when Jesse Vincent was testing
# functionality for Patrick Michaud

my @list = ('a');


# Do pointy subs send along a declared param?

for @list -> $letter { is( $letter , 'a', 'can bind to variable in pointy') }

{
    # -> { ... } introduces a sig of (), so this code dies with "Too many positionals passed"
    throws-like { EVAL q[for @list -> { return 1 unless $_ eq 'a' }] }, Exception,
        '$_ does not get set implicitly if a pointy is given';
}

# Hm. PIL2JS currently dies here (&statement_control:<for> passes one argument
# to the block, but the block doesn't expect any arguments). Is PIL2JS correct?

# Do pointy subs send along an implicit param even when a param is declared? No!
for @list -> $letter {
    isnt( $_ ,'a', '$_ does not get set implicitly if a pointy is given')
}

{
    my $a := $_; $_ = 30;
    for 1 .. 3 { $a++ };
    is $a, 33, 'outer $_ increments' ;
}

{
    my @mutable_array = 1..3;
    lives-ok { for @mutable_array { $_++ } }, 'default topic is rw by default';
}

# https://github.com/Raku/old-issue-tracker/issues/2804
{
    $_ = 1;
    my $tracker = '';

    for 11,12 -> $a {
        if $_ == 1 { $tracker ~= "1 : $_|"; $_ = 2; }
        else {       $tracker ~= "* : $_" }
    }

    is $tracker, '1 : 1|* : 2',
        'Two iterations of a loop share the same $_ if it is not a formal parameter';

    # https://github.com/Raku/old-issue-tracker/issues/2804
    ## also from RT #113904
    lives-ok { $_ = 42; for 1 -> $p { if 1 { "$_" } } },
        'no Null PMC access error when outer $_ is used in block of for loop';
    lives-ok { $_ = 1; for 12 -> $a { if 1 { $_.WHAT } } },
        '$_ in block of for loop is a SixModelObject';
}

{
     # Inner subs get a new $_, not the OUTER::<$_>
     $_ = 1;
     sub foo {
         ok !defined($_), '$_ starts undefined';
         $_ = 2;
         is $_, 2,  'now $_ is 2';
     }
     foo();
     is $_, 1, 'outer $_ is unchanged'
}

# vim: expandtab shiftwidth=4
