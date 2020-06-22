use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;
use Test::Util;

plan 9;

dies-ok { Supplier.new.Supply.interval(1) }, 'can not be called as an instance method';

{
    my $scheduler = FakeScheduler.new;
    tap-ok Supply.interval(1, :$scheduler),
      [^5],
      'interval of 1 second',
      :after-tap( { $scheduler.progress-by(Duration.new(4.5)) } ),
      :virtual-time;
}

{
    my $scheduler = FakeScheduler.new;
    tap-ok Supply.interval(1, 2, :$scheduler),
      [^3],
      'interval of 1 second with delay of 2',
      :after-tap( { $scheduler.progress-by(Duration.new(4.5)) } ),
      :virtual-time;
}

# https://github.com/Raku/old-issue-tracker/issues/4406
is_run(
       'my $timer = Supply.interval(0.1); $timer.tap({ die "uh-oh" }); sleep 5;',
       { status => * != 0, err => /"uh-oh"/},
       'Exception thrown in a timer and unhandled terminates program',
);

# https://github.com/Raku/old-issue-tracker/issues/5398
{
    my $code = 'react { whenever Supply.interval: .01 { done } };'
            ~ ' say "Did not hang"';

    for ^3 {
        doesn't-hang \($*EXECUTABLE, '-e', $code), :out(/'Did not hang'/),
            'done() on first iteration of Supply.interval does not hang';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5820
{
    # treat too-small values as minimum timer resolution (e.g. 0.001 seconds)
    # emitting optional warning in such cases is allowed
    CONTROL { when CX::Warn { .resume } }
    my @a;
    react {
        whenever Supply.interval(.0001) {
            push @a, $_;
            done if $_ == 5
        }
    }
    is-deeply @a, [0..5], "Timer with very short interval fires multiple times";
}

{
    # treat negatives/zeros as minimum timer resolution (e.g. 0.001 seconds)
    # emitting optional warning in such cases is allowed
    CONTROL { when CX::Warn { .resume } }
    my @a;
    react {
        whenever Supply.interval(-100) {
            push @a, $_;
            done if $_ == 5
        }
    }
    is-deeply @a, [0..5], "Timer with very short interval fires multiple times";
}

# vim: expandtab shiftwidth=4
