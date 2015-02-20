use Test;

plan 7;

{
    my @seen;
    sub print($a) { @seen.push: $a };  # assume .act serializes

    my $s = Supply.new;
    $s.act: { print " Fizz" if $_ %% 3 }
    $s.act: { print " Buzz" if $_ %% 5 }
    $s.act: { print " $_" unless $_ %% 3 || $_ %% 5 }
    $s.emit($_) for 1..20;

    is +@seen, 21, 'do we have right number of elements';
    is @seen.join,
      " 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 Fizz Buzz 16 17 Fizz 19 Buzz",
      'did we get the right string';
}

#?rakudo skip 'sometimes hangs, sometimes segfaults'
{
    my $times = 100000;
    my $a;
    $*SCHEDULER.cue: { $a++ } for ^$times;
    sleep 5;
    isnt $a, $times, "Missed some updates: {$times - $a}";
}

{
    my $s = Supply.new;
    my @seen;
    $s.act: { @seen.push: "Fizz" if $_ %% 3 }
    $s.act: { @seen.push: "Buzz" if $_ %% 5 }
    $s.act: { @seen.push: $_ unless $_%%3 || $_%%5 }
    await do for 1..20 { start { sleep rand; $s.emit($_) } }
    is +@seen, 21, 'do we have right number of elements';
    is @seen.sort,
      "1 2 4 7 8 11 13 14 16 17 19 Buzz Buzz Buzz Buzz Fizz Fizz Fizz Fizz Fizz Fizz",
      'did we get the right string';
}

{
    my $s = Supply.new;
    my @seen;
    $s.act: { @seen[$_]   = "Fizz" if $_ %% 3 }
    $s.act: { @seen[$_]  ~= "Buzz" if $_ %% 5 }
    $s.act: { @seen[$_] //= $_ }
    await do for 1..20 { start { sleep rand; $s.emit($_) } }
    is +@seen, 21, 'do we have right number of elements';
    is @seen[1..20],
      "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz",
      'did we get the right string';
}
