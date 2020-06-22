use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S04/The general loop statement>

=begin kwid

loop statement tests


=end kwid

plan 18;

# basic loop

{
    my $i = 0;
    is($i, 0, 'verify our starting condition');
    loop ($i = 0; $i < 10; $i++) {}
    is($i, 10, 'verify our ending condition');
}

# loop with last
{
    my $i = 0;
    is($i, 0, 'verify our starting condition');
    loop ($i = 0; $i < 10; $i++) {
        if $i == 5 { 
            last;
        }
    }
    is($i, 5, 'verify our ending condition');
}

# infinite loop

{
    my $i = 0;
    is($i, 0, 'verify our starting condition');
    loop (;;) { $i++; last; }
    is($i, 1, 'verify our ending condition');
}

# declare variable $j inside loop
{
    my $count  = 0;
    is($count, 0, 'verify our starting condition');
    loop (my $j = 0; $j < 10; $j++) { $count++; };
    is($count, 10, 'verify our ending condition');
}

# Ensure condition is tested on the first iteration
{
    my $never_did_body = 1;
    loop (;0;)
    {
        $never_did_body = 0;
    }
    ok($never_did_body, "loop with an initially-false condition executes 0 times");
}

# Loop with next should still execute the continue expression
{
    my $i;
    my $continued;
    loop ($i = 0;; $continued = 1)
    {
        last if $i;
        $i++;
        next;
    }
    ok($continued, "next performs a loop's continue expression");
}

{
    my $loopvar = 0;

    loop {
        last if ++$loopvar == 3;
    }
    is($loopvar, 3, "bare loop exited after 3 iterations");
}

{
    my $rt65962 = 'did not loop';
    
    loop ( my $a = 1, my $b = 2; $a < 5; $a++, $b++ ) {
        $rt65962 = "$a $b";
    }

    is $rt65962, '4 5', 'loop with two variables in init works';
}

# https://github.com/Raku/old-issue-tracker/issues/1450
eval-lives-ok('class A { has $!to; method x { loop { (:$!to); } } };', 'pair colon syntax in a loop refers to an attribute works');

# https://github.com/Raku/old-issue-tracker/issues/761
throws-like 'loop { say "# RT63760"; last } while 1', X::Syntax::Confused,
             '"loop {} while" is a syntax error (RT #63760)';

# https://github.com/Raku/old-issue-tracker/issues/2732
{
    my @a = gather loop { take 1; take 2; last };
    is @a.join, '12', 'gather, take and loop work together';
}

# https://github.com/Raku/old-issue-tracker/issues/5039
{
    my @rt127238;
    sub rt127238 {
        loop (my $i = 0; $i < 5; ++$i) { @rt127238.push: $i }
    }
    rt127238();
    is @rt127238.join("-"), '0-1-2-3-4', 'loop variable inside sub is correctly set';
}

# https://github.com/Raku/old-issue-tracker/issues/5885
{
    # Test the `last` used with $mod aborts the `loop`
    # In the process, test that other CONTROL exceptions continue to work
    sub code-with ($mod) {
        ｢say eager gather loop {｣
        ~ ｢ do { say "saying"; warn "warning"; take "taking"; last } ｣
        ~ $mod ~ ｢; say "Test:fail" }｣
    }
    for ｢without Any｣, ｢with 42｣ -> $mod {
        #?rakudo.jvm skip 'needs investigation'
        doesn't-hang(
            code-with($mod),
            "`last` aborts loop when using `$mod`",
              :out{
                  not .contains('Test:fail')
                  and .contains('saying')
                  and .contains('taking')
              },
              :err(/«warning»/),
        );
    }
}

# vim: expandtab shiftwidth=4
