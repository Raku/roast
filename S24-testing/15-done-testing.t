#!/usr/bin/env raku
use Test;

plan 3;

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
    { expected => False, description => 'wrong count, all pass' },
    { expected => True,  description => 'correct count, all pass' },
    { expected => False, description => 'correct count, one fails' },;

for 0,1,2  -> $i {
    my %h = @test[$i];
    my $text = qqx{ raku -e '@program[$i]' 2>&1 };
    %h<got> = ($text ~~ rx/ \w+ \s+ $ /).trim;

    ok %h<got> eq %h<expected>, %h<description>;
}

done-testing;
