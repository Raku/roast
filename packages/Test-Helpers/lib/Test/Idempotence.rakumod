use v6;
unit module Test::Idempotence;

use Test;

sub is-perl-idempotent(
  $thing, $desc?, %subst?, :$eqv = False
) is export is test-assertion {
    my $fail = 1;
    my $stage1p;
    my $stage1r;
    my $stage2;
    my $stage2p;
    subtest {
        plan $eqv ?? 3 !! 2;
        try {
            $stage1p = $thing.raku;
            $stage1r = $stage1p;
            for %subst.kv -> $old, $new {
                $stage1r ~~ s:g/$old/$new/;
            }
            $stage2 = EVAL $stage1r;
            $stage2p = $stage2.raku;
            for %subst.kv -> $old, $new {
                $stage2p ~~ s:g/$old/$new/;
            }
            CATCH {
                default { $fail = $_ };
            }
        }
        if ($eqv) {
            diag "$thing.raku() !eqv $stage2.raku()"
              unless ok $thing eqv $stage2, "Result is same as original";
        }
        is $stage1r, $stage2p, "Same .raku output";
        is $fail, 1, "...and no failures.";
    }, $desc // (".raku of " ~ $thing.gist ~ " is idempotent");
}

=begin pod

=head1 NAME

Test::Idempotence - Extra tests for idempotence related matters

=head1 SYNOPSIS

  use Test;
  use Test::Idempotence;

  is-perl-idempotent("expression");
  #      1..2
  #      ok 1 - Same .raku output
  #      ok 2 - ...and no failures.
  #  ok 1 - .raku of expression is idempotent

  is-perl-idempotent(1, ".raku of one");
  #      1..2
  #      ok 1 - Same .raku output
  #      ok 2 - ...and no failures.
  #  ok 1 - .raku of one

  is-perl-idempotent(1, :eqv);
  #      1..3
  #      ok 1 - Result is same as original
  #      ok 2 - Same .raku output
  #      ok 3 - ...and no failures.
  #  ok 1 - .raku of 1 is idempotent

  is-perl-idempotent(:(Int $a = 1), "sig", { '= { ... }' => '= 1' }, :eqv);
  #      1..3
  #      ok 1 - Result is same as original
  #      ok 2 - Same .raku output
  #      ok 3 - ...and no failures.
  #  ok 3 - sig

=head1 DESCRIPTION

Tests that assure that certain Raku constructs produce identical
results when their output is fed back to them.

=head1 FUNCTIONS

=head2 is-perl-idempotent($thing, $desc, %subst?)

Ensures that C<$thing.raku> is the same string as C<(EVAL $thing.raku).raku>,
modulo any substitutions in C<%subst>.  The C<%subst> parameter consists of patterns
as keys and the tet to substitute as values.  It will not interpolate
regexp syntax; if you want that, feed it an object hash instead of a normal
hash, like so:

    :{ rx/foo/ => 'bar' }

...in which case any keys that are Regex objects are used as such.

The substitutions are performed on $thing.raku before sending it to EVAL,
and again on the result of the EVAL. They are intended to be used to gloss
over things that C<.raku> cannot be reasonably expected to emit useable code
for, and should be used sparingly.

The C<$desc> simply sets the description of the test which is output.

=end pod

# vim: expandtab shiftwidth=4
