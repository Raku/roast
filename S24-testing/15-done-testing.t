#!/usr/bin/env raku
use Test;
use Test::Util;

# done-testing() to return True on passing, False for dubious or failing

plan 3;

constant PASS    = 0;
constant FAIL    = 1;
constant DUBIOUS = 255;

my @program;

@program[0] = Q:to/END_PROG_0/;
    use Test;
    my $status = True;

    plan 1;
    ok True, "Passes";
    ok True, "Passes extra test";
    say $status = done-testing;
END_PROG_0

@program[1] = Q:to/END_PROG_1/;
    use Test;
    my $status = False;

    plan 2;
    ok True, "Passes";
    ok True, "Passes";
    say $status = done-testing;
END_PROG_1

@program[2] = Q:to/END_PROG_2/;
    use Test;
    my $status = True;

    plan 3;
    ok True, "Passes";
    ok True, "Passes";
    ok False, "Fails";
    say $status = done-testing;
END_PROG_2

my @test =
    {   description => 'wrong count, all pass',
        expected => {
            out => sub { 'False' eq ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => DUBIOUS, },
    },
    {   description => 'correct count, all pass',
        expected => {
            out => sub { 'True' eq ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => PASS, },
    },
    {   description => 'correct count, one fails',
        expected => {
            out => sub { 'False' ~~ ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => FAIL, },
    };

for 0,1,2  -> $i {
    my %h = @test[$i];
    is_run( @program[$i], %h<expected>, %h<description>);
}

done-testing;
