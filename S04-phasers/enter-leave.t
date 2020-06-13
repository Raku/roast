use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 33;

# L<S04/Phasers/ENTER "at every block entry time">
# L<S04/Phasers/LEAVE "at every block exit time">

{
    my $str;
    my sub foo ($x, $y) {
        ENTER { $str ~= "(" }
        LEAVE { $str ~= ")" }
        $str ~= "$x,$y";
    }
    foo(3,4);
    is $str, '(3,4)';
    foo(-1,2);
    is $str, '(3,4)(-1,2)';
}

# reversed order
{
    my $str;
    my sub foo ($x, $y) {
        $str ~= "$x,$y";
        LEAVE { $str ~= ")" }
        ENTER { $str ~= "(" }
    }
    foo(7,-8);
    is $str, '(7,-8)';
    foo(5,0);
    is $str, '(7,-8)(5,0)';
}

# multiple ENTER and LEAVE blocks
{
    my $str;
    {
        ENTER { $str ~= '[' }
        LEAVE { $str ~= ']' }

        $str ~= 21;

        ENTER { $str ~= '(' }
        LEAVE { $str ~= ')' }

        ENTER { $str ~= '{' }
        LEAVE { $str ~= '}' }
    }
    is $str, '[({21})]', 'multiple ENTER/LEAVE worked';
}

# L<S04/Phasers/ENTER "repeats on loop blocks">
{
    my $str;
    for 1..2 -> $x {
        $str ~= ',';
        ENTER { $str ~= "E$x" }
        LEAVE { $str ~= "L$x " }
    }
    is $str, 'E1,L1 E2,L2 ', 'ENTER/LEAVE repeats on loop blocks';
}

# L<S04/Phasers/LEAVE "at every block exit time">

# named sub:
{
    my $str;
    my sub is_even ($x) {
        return 1 if $x % 2 == 0;
        return 0;
        LEAVE { $str ~= $x }
    }
    is is_even(3), 0, 'basic sanity check (1)';
    is $str, '3', 'LEAVE executed at the 1st explicit return';
    is is_even(2), 1, 'basic sanity check (2)';
    is $str, '32', 'LEAVE executed at the 2nd explicit return';
}

# normal closure:
# https://github.com/Raku/old-issue-tracker/issues/4112
#?rakudo skip 'leave NYI RT #124960'
{
    is EVAL(q{
        my $a;
        {
            leave;
            $a = 100;
            LEAVE { $a++ }
        }
        $a;
    }), 1, 'leave triggers LEAVE {}';
}

{
    my $str;
    try {
        ENTER { $str ~= '(' }
        LEAVE { $str ~= ')' }
        $str ~= 'x';
        die 'foo';
    }
    is $str, '(x)', 'die calls LEAVE blocks';
}

{
    my $str;
    try {
        LEAVE { $str ~= $! // '<undef>' }
        die 'foo';
    }
    ok $str ~~ /foo/, '$! set in LEAVE if exception thrown';
}

{
    my $str;
    {
        LEAVE { $str ~= (defined($!) ?? 'yes' !! 'no') }
        try { die 'foo' }
        $str ~= (defined($!) ?? 'aye' !! 'nay');
    }
    #?rakudo todo 'is this spec? why would LEAVE not see outer $!? fossil?'
    is $str, 'ayeno', '$! not set in LEAVE if exception not thrown';
}

{
    my $str;
    try {
        $str ~= '(';
        try {
            ENTER { die 'foo' }
            $str ~= 'x';
        }
        $str ~= ')';
    }
    is $str, '()', 'die in ENTER caught by try';
}

{
    my $str;
    try {
        $str ~= '(';
        try {
            LEAVE { die 'foo' }
            $str ~= 'x';
        }
        $str ~= ')';
    }
    #?rakudo.jvm todo "nigh"
    is $str, '(x)', 'die in LEAVE caught by try';
}

{
    my $str;
    try {
        $str ~= '(';
        try {
            ENTER { $str ~= '['; die 'foo' }
            LEAVE { $str ~= ']' }
            $str ~= 'x';
        }
        $str ~= ')';
    }
    is $str, '([])', 'die in ENTER calls LEAVE';
}

{
    my $str;
    try {
        ENTER { $str ~= '1'; die 'foo' }
        ENTER { $str ~= '2' }
    }
    is $str, '1', 'die aborts ENTER queue';
}

# https://github.com/Raku/old-issue-tracker/issues/3363
{
    my $str;
    try {
        LEAVE { $str ~= '1' }
        LEAVE { $str ~= '2'; die 'foo' }
    }
    is $str, '21', 'die doesn\'t abort LEAVE queue';
    #?rakudo.jvm todo 'RT #121530'
    is $!.message, 'foo', 'single exception from LEAVE is rethrown after running LEAVEs';
}

# https://github.com/Raku/old-issue-tracker/issues/2785
{
    my $a = 0;
    my $b = 0;
    multi sub rt113548() { $a = 1; LEAVE $b = 2; }; rt113548;
    ok($a == 1 && $b == 2, "LEAVE fires in a multi sub");
}

# https://github.com/Raku/old-issue-tracker/issues/2988
{
    my $x = 0;
    for 1..10 { LEAVE { $x++ }; next }
    is $x, 10, "next triggers LEAVE";
}

# https://github.com/Raku/old-issue-tracker/issues/3022
{
    my $str='';
    for 1..2 {
        ENTER { $str ~= $_ for <foo bar> };
        $str ~= $_;
    }
    is $str, 'foobar1foobar2', 'can run for loop in phaser in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/3160
{
    is_run( q[sub foo { LEAVE { say 'OK' }; die 'foobar' }; foo()],
        {
            out    => "OK\n",
            err    => /foobar/,
        },
        'LEAVE fires after die in sub' );
}

# https://github.com/Raku/old-issue-tracker/issues/2806
{
    my $rt113950_last = "hello!";
    loop {
        last;
        LEAVE $rt113950_last ~= " bye!";
    }
    is $rt113950_last, "hello! bye!",
        '"last" triggers LEAVE phaser in loop';

    my $rt113950_next = "hello!";
    for ^3 {
        next;
        LEAVE $rt113950_next ~= " yay!";
    }
    is $rt113950_next, "hello! yay! yay! yay!",
        '"next" triggers LEAVE phaser in "for" loop';
}

# https://github.com/Raku/old-issue-tracker/issues/2999
{
    is ENTER { 42 }, 42, 'ENTER works as an r-value (mainline)';
    sub enter-test() { ENTER 'SANDMAN' }
    is enter-test(), 'SANDMAN', 'ENTER works as an r-value (sub)';
}

# https://github.com/Raku/old-issue-tracker/issues/4346
{
    sub doit() {
        if True {
            LEAVE 1;
            return 'ls';
        }
    }
    is doit(), 'ls', 'return in nested block with LEAVE works';
}

{
    sub foo() {
        LEAVE die 'wtf';
        LEAVE die 'omg';
    }
    throws-like { foo() }, X::PhaserExceptions,
        exceptions => sub (@ex) { @ex>>.message ~~ <omg wtf> };
}

{ # https://github.com/rakudo/rakudo/issues/1455
    my $res;
    -> { LEAVE $res := now - ENTER now }();
    isa-ok $res, Duration, 'using ENTER inside LEAVE does not crash';
}

# https://colabti.org/irclogger/irclogger_log/perl6?date=2019-04-26#l196
# When a block has no local variables, the ENTER phaser would not success-
# fully decont a variable out of a surrounding scope. Didn't have a ticket,
# was fixed in Rakudo as a side-effect of 541a4f1628.
{
     my $set;
     # Run at most 20 iterations
     my @v = ^20;
     my $i = 0;
     loop {
         $set ∪= @v[$i++];
         last if $i == @v;
         # Should be true in the 2nd iteration, but is always (Set) in
         # a buggy rakudo version.
         last if ENTER $set<>;
     }
     is $set.elems, 2, 'decont in ENTER works without locals';
}

# https://github.com/rakudo/rakudo/issues/3411
{
    my $entered;
    class A {
        method a() {
            ENTER ++$entered;
        }
    }
    A.a;
    is $entered, 1, 'Did ENTER only run once';
}

# vim: expandtab shiftwidth=4
