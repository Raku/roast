use v6;

use Test;

# L<S04/"Loop statements"/next>

=begin pod
next
next if <condition>;
<condition> and next;
next <label>;
next in nested loops
next <label> in nested loops

=end pod

plan 12;

# test for loops with next

{
    my $tracker=0; for 1..2 { next; $tracker++;}
    is(
        $tracker,
        0,
        "tracker is 0 because next before increment",
    );
}

{
    my $tracker = 0; for 1..5 { next unless 2 < $_ < 4; $tracker = $_;}
    is(
        $tracker,
        3,
        "... nothing before or after 3 (next unless <cond>)",
    );
}

{
    my $tracker = 0; for 1..5 { $_ > 3 && next; $tracker = $_;}
    is(
        $tracker,
        3,
        "... nothing after 3 (<cond> && next)",
    );
}

{
    my $tracker = 0; for 1..5 { $_ > 3 and next; $tracker = $_;}
    is(
        $tracker,
        3,
        "... nothing after 3 (<cond> and next)",
    );
}

{
    my $tracker="err"; 
    $tracker = 0; DONE: for 1..2 { next DONE; $tracker++;};
    is(
        $tracker,
        0,
        "tracker is 0 because next before increment",
    );
}

{
    my $tracker=0; for 1..5 -> $out {for 10..11 -> $in { next if $out > 2; $tracker = $in + $out;}}
    is($tracker,
        13,
        'inner loop skips once inner is run twice (next inside nested loops)',
    );
}

{
    my $tracker="err"; 
    $tracker = 0; 
    OUT: for 1..2 {
        IN: for 1..2 {
            next OUT;
            $tracker++;
        }
    }
    is(
        $tracker,
        0,
        "tracker is 0 because next before increment in nested loop",
    );
}

=begin pod

Check that C<next> works on the correct loop/block

=end pod

{
  my $foo = '';
  for 1..2 -> $a {
    $foo ~= "A";
    for 1..2 -> $b {
        $foo ~= "B";
        next;             # works on higher level loop, should work on inner
    }
  }
  is($foo, "ABBABB", "next works on inner loop of 2");
}

{
    my $bar = '';
    for 1..2 -> $a {
        $bar ~= "A";
        for 1..2 -> $b {
            $bar ~= "B";
            for 1..2 -> $c {
                $bar ~= "C";
                next;         # same thing
            }
        }
    }
    is($bar, "ABCCBCCABCCBCC", "next works on inner loop of 3");
}

{
    my @log;    
    my $i = 0;
    while ++$i < 2 {
        push @log, "before";
        next;
        push @log, "after";
    }
    
    is(~@log, "before", "statements after next are not executed");
}

{
    my $i = 0;
    
    for 1, 1, 0, 1, 0, 1 -> $x {
        if ($x) { next }
        $i++;
    }
    
    is($i, 2, '$i++ executed only twice, because next ')
}

{
    my $i = 0;
    my $j;
    
    loop ($j = 0; $j < 6; $j++) {
        if ($j % 2 == 0) { next }
        $i++;
    }
    
    is($i, 3, '$i++ was not executed when next was called before it in loop {}');
}

# vim: ft=perl6
