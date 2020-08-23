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
            out => rx/ False \s+ $ / ,
            status => DUBIOUS, },
        program => Q{
            use Test;
            plan 1;
            ok True, "Passes";
            ok True, "Passes extra test";
            say done-testing;
        }
    },
    {   description => 'correct count, all pass',
        expected => {
            out => rx/ True \s+ $ / ,
            status => PASS, },
        program => Q{
            use Test;
            plan 2;
            ok True, "Passes";
            ok True, "Passes";
            say done-testing;
        },
    },
    {   description => 'correct count, one fails',
        expected => {
            out => rx/ False \s+ $ / ,
            status => FAIL, },
        program => Q{
            use Test;
            plan 3;
            ok True, "Passes";
            ok True, "Passes";
            ok False, "Fails";
            say done-testing;
        },
    };

for @test  -> %h {
    is_run( %h<program>, %h<expected>, %h<description>);
}

done-testing;

