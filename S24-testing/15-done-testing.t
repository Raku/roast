use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# done-testing() to return True on passing, False for dubious or failing

plan 3;

constant PASS    = 0;
constant FAIL    = 1;
constant DUBIOUS = 255;

my @test =
    {   description => 'wrong count, all pass',
        expected => {
            out => "1..1\nok 1 - Passes\n"
                 ~ "ok 2 - Passes extra test\nFalse\n",
            status => DUBIOUS, 
        },
        program => Q{
            use Test;
            plan 1;
            ok True, "Passes";
            ok True, "Passes extra test";
            say done-testing;
        },
    },
    {   description => 'correct count, all pass',
        expected => {
            out => "1..2\nok 1 - Passes\nok 2 - Passes\nTrue\n",
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
            out => "1..2\nok 1 - Passes\nnot ok 2 - Fails\nFalse\n",
            status => FAIL, },
        program => Q{
            use Test;
            plan 2;
            ok True, "Passes";
            ok False, "Fails";
            say done-testing;
        },
    };

for @test -> %h {
    is_run( %h<program>, %h<expected>, %h<description>);
}

done-testing;
