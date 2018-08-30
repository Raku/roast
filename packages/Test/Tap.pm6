use v6;
unit module Test::Tap;

use Test;

proto sub tap-ok(|) is export { * }

multi sub tap-ok (
  $s,
  $expected,
  $desc,
  :$live = False,
  :&emit,
  :&done,
  :&after-tap,
  :$timeout is copy = 10,
  :$sort,
  :$virtual-time
) {
    subtest {
        plan $virtual-time ?? 4 !! 5;
        ok $s ~~ Supply, "{$s.^name} appears to be doing Supply";
        is $s.live, $live, "Supply appears to {'NOT ' unless $live}be live";

        my @res;
        my $done;
        isa-ok $s.tap(
                 { emit() if &emit; @res.push($_) },
          :done( { done() if &done; $done = True } ),
        ), Tap, "$desc got a tap";
        after-tap() if &after-tap;

        unless $virtual-time {
            $timeout *= 10;
            for ^$timeout { last if $done; sleep .1 }
            ok $done, "$desc was really done";
        }
        @res .= sort if $sort;
        is-deeply @res, $expected, $desc;
    }, $desc;
}

# Rather cheating test scheduler.
my class FakeScheduler does Scheduler is export {
    has $.time = now;
    has @.upcoming;

    my class Scheduled {
        has $.deadline;
        has &.code;
    }

    method cue(&code, :$every, :$in = Duration.new(0), *%unknown) {
        die "Fake scheduler does not understand: %unknown.keys().join(', ')"
            if %unknown;

        if $every {
            for ^100 {
                state $deadline = $!time + $in;
                @!upcoming.push(Scheduled.new(:$deadline, :&code));
                $deadline += $every;
            }
        }
        else {
            code();
        }
    }

    method loads() { ??? }

    method progress-by(Duration $d) {
        $!time += $d;
        @!upcoming .= grep: {
            if .deadline <= $!time {
                .code().();
                False
            }
            else {
                True
            }
        }
    }
}

=begin pod

=head1 NAME

Test::Tap - Extra utility code for testing Supply

=head1 SYNOPSIS

  use Test;
  use Test::Tap;

  tap-ok( $supply, [<a b c>], "comment" );

  tap-ok(
    $supply,
    [<a b c>],
    "text",
    :live,
    :emit( { ... } ),
    :done( { ... } ),
    :after-tap( { ... } ),
    :timeout(50),
    :sort,
  );

=head1 DESCRIPTION

This module is for Supply test code.

=head1 FUNCTIONS

=head2 tap-ok( $s, [$result], "comment" )

Takes 3 positional parameters: the C<Supply> to be tested, an array with the
expected values, and a comment to describe the test.

Performs the following actions in a C<subtest>:
- checks whether the first positional is a Supply.
- checks whether the Supply is live or on demand with what is expected.
- attempts to put a C<.tap> on the Supply and whether a Tap was returned.
- runs any code specified to be run after the tap.
- waits for the Supply to be C<done>, or until the timeout has passed.
- emits a fail if the timeout has passed.
- sorts the values as received from the Supply if so indicated.
- tests the values received.

Takes optional named parameters:

=over 4

=item :live

Optional indication of the value C<Supply.live> is supposed to return.  By
default, the C<Supply> is expected to be C<on demand> (as in B<not> live).

=item :emit( {...} )

Optional code to be executed whenever a value is received (emitted) on the tap.
By default, does B<not> execute any code.

=item :done( {...} )

Optional code to be executed whenever the supply indicates it is "done".
By default, does B<not> execute any code.

=item :after-tap( {...} )

Optional code to be executed after a tap has been made on the given C<Supply>.
By default, does B<not> execute any code.

=item :timeout(50)

Optional timeout specification: defaults to B<10> (seconds).

=item :sort

Boolean indicating whether to sort the values provided by the supply before
checking it against the desired result.  Default is no sorting.

=back

=end pod

# vim: ft=perl6
