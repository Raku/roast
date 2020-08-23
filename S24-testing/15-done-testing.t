#!/usr/bin/env raku
use Test;
use Test::Util;

# done-testing() to return True on passing, False for dubious or failing

plan 3;

constant PASS    = 0;
constant FAIL    = 1;
constant DUBIOUS = 255;

my @test =
    {   description => 'wrong count, all pass',
        expected => {
            out => sub { 'False' eq ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => DUBIOUS, },
        program => Q{
            use Test;
            my $status = True;

            plan 1;
            ok True, "Passes";
            ok True, "Passes extra test";
            say $status = done-testing;
        }
    },
    {   description => 'correct count, all pass',
        expected => {
            out => sub { 'True' eq ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => PASS, },
        program => Q{
            use Test;
            my $status = False;

            plan 2;
            ok True, "Passes";
            ok True, "Passes";
            say $status = done-testing;
        },

    },
    {   description => 'correct count, one fails',
        expected => {
            out => sub { 'False' ~~ ( $^a ~~ rx/ \w+ \s+ $ / ).trim; },
            status => FAIL, },
        program => Q{
            use Test;
            my $status = True;

            plan 3;
            ok True, "Passes";
            ok True, "Passes";
            ok False, "Fails";
            say $status = done-testing;
        },
    };

for @test  -> %h {
    is_run( %h<program>, %h<expected>, %h<description>);
}

done-testing;

