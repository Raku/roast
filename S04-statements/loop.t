use v6;

use Test;

# L<S04/The general loop statement>

=begin kwid

loop statement tests


=end kwid

plan 14;

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

# RT #71466
#?pugs skip 'eval_lives_ok'
eval_lives_ok('class A { has $!to; method x { loop { (:$!to); } } };', 'pair colon syntax in a loop refers to an attribute works');

# RT #63760
eval_dies_ok 'loop { say "# RT63760"; last } while 1',
             '"loop {} while" is a syntax error (RT 63760)';

# vim: ft=perl6
