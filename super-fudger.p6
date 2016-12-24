#!/usr/bin/env perl6
# This is a script to fudge ALL failing tests in a test file.
# It detects if the line is a testing line by whether it starts
# with certain words. For now it only works with one line tests
# not needing values from other lines to work.
use v6;
use MONKEY-SEE-NO-EVAL;
use Test;
my @test-words = <bail-out todo skip skip-rest diag
                  subtest ok nok cmp-ok is is-deeply isnt
                  is-approx like unlike use-ok isa-ok does-ok can-ok
                  dies-ok lives-ok eval-dies-ok eval-lives-ok throws-like>;

sub MAIN ( Str $test-file, Str $backend, Str $fudge-type, Str $message ) {
    my @lines = $test-file.IO.slurp.lines;
    my @new-lines;
    my $line-no = 0;
    my $num-already-fudged = 0;
    for @lines -> $line {
        $line-no++;
        if $line.match(/^ \s* '#?' $backend ' ' $<number>=(\S+)/) {
            say "Already fudged";
            if $<number> ~~ /^(\d+)$/ {
                $num-already-fudged = $0.Int;
            }
            else {
                $num-already-fudged = 1;
            }
        }
        my $test-line = False;
        for @test-words {
            if $line.match(/^ \s* $_/) {
                $test-line = True;
                last;
            }
        }
        if $test-line {
            if $num-already-fudged > 0 {
                $num-already-fudged--;
                push @new-lines, $line;
                next;
            }
            my $passed = so EVAL $line;
            if $passed {
                push @new-lines, $line;
                next;
            }
            else {
                push @new-lines, "#?$backend $fudge-type '$message'";
                push @new-lines, $line;
                next;
            }
        }
        else {
            push @new-lines, $line;
            next;
        }
    }
    $test-file.IO.spurt(@new-lines.join("\n") ~ "\n");
}
