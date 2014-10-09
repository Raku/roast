use v6;

use Test;

use lib 't/spec/packages';
use Test::Util;

plan 23;

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
#?niecza skip 'leave'
#?rakudo skip 'leave NYI'
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

#?niecza 2 skip 'dubious: noauto'
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

#?niecza todo '@!'
#?rakudo.jvm skip 'unwind, RT #121530'
#?rakudo.moar skip 'unwind, RT #121530'
{
    my $str;
    try {
        LEAVE { $str ~= '1' }
        LEAVE { $str ~= '2'; die 'foo' }
    }
    is $str, '21', 'die doesn\'t abort LEAVE queue';
}

# RT #113548
{
    my $a = 0;
    my $b = 0;
    multi sub rt113548() { $a = 1; LEAVE $b = 2; }; rt113548;
    ok($a == 1 && $b == 2, "LEAVE fires in a multi sub");
}

# RT #115998
{
    my $x = 0;
    for 1..10 { LEAVE { $x++ }; next }
    is $x, 10, "next triggers LEAVE";
}

# RT #116314
{
    my $str='';
    for 1..2 {
        ENTER { $str ~= $_ for <foo bar> };
        $str ~= $_;
    }
    is $str, 'foobar1foobar2', 'can run for loop in phaser in for loop';
}

# RT #118387
#?rakudo.parrot skip "RT #118387"
{
    is_run( q[sub foo { LEAVE { say 'OK' }; die 'foobar' }; foo()],
        {
            out    => "OK\n",
            err    => /foobar/,
        },
        'LEAVE fires after die in sub' );
}

# vim: ft=perl6
