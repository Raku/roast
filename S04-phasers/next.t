use v6;

use Test;

plan 13;

# L<S04/Phasers/NEXT executes "only if" 
#   "end of the loop block" or "explicit next">
{
    my $str = '';
    for 1..5 {
        NEXT { $str ~= ':' }
        next if $_ % 2 == 1;
        $str ~= $_;
    }
    is $str, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is positioned at the bottom:
{
    my $str = '';
    for 1..5 {
        next if $_ % 2 == 1;
        $str ~= $_;
        NEXT { $str ~= ':' }
    }
    is $str, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is positioned in the middle:
{
    my $str = '';
    for 1..5 {
        next if $_ % 2 == 1;
        NEXT { $str ~= ':' }
        $str ~= $_;
    }
    is $str, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is evaluated even at the last iteration
{
    my $str = '';
    for 1..2 {
        NEXT { $str ~= 'n'; }
        LAST { $str ~= 'l'; }
    }
    #?pugs todo
    #?rakudo.parrot todo 'NEXT is evaluated even at the last iteration'
    is $str, 'nnl', 'NEXT are LAST blocks may not be exclusive';
}

# L<S04/Phasers/NEXT "not executed" if exited
#   "via any exception other than" next>

{
    my $str = '';
    try {
        for 1..5 {
            NEXT { $str ~= $_ }
            die if $_ > 3;
        }
        0;
    }
    is $str, '123', "die didn't trigger NEXT \{}";
}

#?rakudo skip 'leave NYI'
{
    my $str = '';
    try {
        for 1..5 {
            NEXT { $str ~= $_ }
            leave if $_ > 3;
        }
        0;
    }
    #?pugs todo
    is $str, '123', "leave didn't trigger NEXT \{}";
}

{
    my $str = '';
    my sub foo {
        for 1..5 {
            NEXT { $str ~= $_ }
            return if $_ > 3;
        }
        0;
    }
    foo();
    is $str, '123', "return didn't trigger NEXT \{}";
}

# L<S04/Phasers/last bypasses evaluation of NEXT phasers>
{
    my $str = '';
    for 1..5 {
        NEXT { $str ~= $_; }
        last if $_ > 3;
    }
    is $str, '123', "last bypass NEXT \{}";
}

# L<S04/Phasers/NEXT "before any LEAVE">

#?rakudo todo 'NEXT/LEAVE ordering'
{
    my $str = '';
    for 1..2 {
        NEXT { $str ~= 'n' }
        LEAVE { $str ~= 'l' }
    }
    #?pugs todo
    is $str, 'nlnl', 'NEXT {} ran before LEAVE {} (1)';
}

# reversed order
#?rakudo todo 'NEXT/LEAVE ordering'
{
    my $str = '';
    for 1..2 {
        LEAVE { $str ~= 'l' }
        NEXT { $str ~= 'n' }
    }
    #?pugs todo
    is $str, 'nlnl', 'NEXT {} ran before LEAVE {} (2)';
}

# L<S04/Phasers/NEXT "at loop continuation time">

# L<http://groups.google.com/group/perl.perl6.language/msg/07370316d32890dd>

{
    my $str = '';
    my $n = 0;
    my $i;
    while $n < 5 {
        NEXT { ++$n }       # this gets run second (LIFO)
        NEXT { $str ~= $n } # this gets run first (LIFO)
        last if $i++ > 100; # recursion prevension
    }
    #?pugs todo
    is $str, '01234', 'NEXT {} ran in reversed order';
}

{
    my $str = '';
    loop (my $n = 0; $n < 5; ++$n) {
       NEXT { $str ~= $n }
    }
    is $str, '01234', 'NEXT {} works in loop (;;) {}';
}

{
    my @x = 0..4;
    my $str = '';
    for @x {
        NEXT { $str ~= $_; }
    }

    #?pugs todo
    is($str, '01234', 'NEXT {} works in for loop');
}

# vim: ft=perl6
