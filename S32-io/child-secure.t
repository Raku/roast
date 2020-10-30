use Test;

plan 10;

sub make-rand-path (--> IO::Path:D) {
    $*TMPDIR.resolve.child: (
        'raku_roast_',
        $*PROGRAM.basename, '_line',
        ((try callframe(3).code.line)||''), '_',
        rand,
        time,
    ).join.subst: :g, /\W/, '_';
}

my @FILES-FOR-make-temp-file;
my @DIRS-FOR-make-temp-dir;
END {
    unlink @FILES-FOR-make-temp-file;
    rmdir  @DIRS-FOR-make-temp-dir;
}

sub make-temp-file (
  :$content where Any:U|Blob|Cool,
  Int :$chmod
--> IO::Path:D) {
    @FILES-FOR-make-temp-file.push: my \path = make-rand-path;
    with $chmod {
        path.spurt: $content // '';
        path.chmod: $_
    }
    orwith $content {
        path.spurt: $_
    }
    path
}

sub make-temp-dir (Int $chmod? --> IO::Path:D) {
    @DIRS-FOR-make-temp-dir.push: my \path = make-rand-path;
    path.mkdir;
    path.chmod: $_ with $chmod;
    path
}

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

sub is-path ($got, $expected, $desc) is test-assertion {
    cmp-ok $got.resolve, '~~', $expected.resolve, $desc
}

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
