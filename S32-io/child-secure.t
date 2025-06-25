use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 10;

sub failuring-like (&test, $ex-type, $reason?, *%matcher) {
    todo $_ with $*NOT-IMPL-TODO;
    subtest $reason => sub {
        plan 2;
        CATCH { default {
            with "expected code to fail but it threw {.^name} instead" {
                .&flunk;
                .&skip;
                return False;
            }
        }}
        my $res := test;
        isa-ok $res, Failure, 'code returned a Failure';
        throws-like { $res.sink }, $ex-type,
          'Failure threw when sunk', |%matcher,
    }
}

my $parent := make-temp-dir;
my $non-resolving-parent := make-temp-file.child('bar');

{
#?rakudo emit my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";

    failuring-like { $non-resolving-parent.child('../foo', :secure) },
      X::IO::Resolve,
      'non-resolving parent fails (given path is non-child)';

    failuring-like { $non-resolving-parent.child('foo', :secure) },
      X::IO::Resolve,
      'non-resolving parent fails (given path is child)';

    failuring-like { $parent.child('foo/bar', :secure) },
      X::IO::Resolve,
      'resolving parent fails (given path is a child, but not resolving)';

    failuring-like { $parent.child('../foo', :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child)';
}

is-path $parent.child('foo', :secure), $parent.child('foo'),
  'resolved parent with resolving, non-existent child';

$parent.child('foo').mkdir;
is-path $parent.child('foo', :secure), $parent.child('foo'),
    'resolved parent with resolving, existent child';

is-path $parent.child('foo/bar', :secure), $parent.child('foo/bar'),
    'resolved parent with resolving, existent child in a subdir';

is-path $parent.child('foo/../bar', :secure), $parent.child('bar'),
    'resolved parent with resolving, non-existent child, with ../';

{
#?rakudo emit my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";

    failuring-like { $parent.child('foo/../../bar', :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child, via child + ../)';

    failuring-like { $parent.child("../\x[308]", :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child, via combiners)';
}

# vim: expandtab shiftwidth=4
