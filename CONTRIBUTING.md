# Contributing

## Adding A Test

A person who wants to contribute a test to the project should read
this Github guide to
issues and [pull requests](http://help.github.com/categories/collaborating-with-issues-and-pull-requests)
(PRs) which describes in great detail the work flow for forks and
submitting PRs to a project.

## Determine The Purpose

There may be two different purposes to contribute to this project:

1. Contributors may wish to fix an error or add a test for existing functionality. The
   latter is often needed when a bug is discovered in a compiler and there is reason
   to cover this bug with a test.
2. Contributors may wish to propose a change to the Raku language itself. This kind
   of contribution should be started by submitting an issue in the
   [problem-solving](https://github.com/Raku/problem-solving) repository. The
   issue must be opened using the _Report a language problem_ template. If the
   proposed change is accepted then a test to cover the new behavior is to be
   submitted to roast.

Note that in the second case if the proposal is accepted but not implemented yet,
the test must be fudged. See _Fudged tests_ below and
[README](https://github.com/Raku/roast)) for more details. The preferable way is
to use the `todo` verb because in this case a tester would get notified when a
fudged test passes due to a feature being implemented or a bug fixed.

## Submission Steps

Follow the same general steps for [the Raku roast](https://github.com/Raku/roast)
project:

- fork the project 
- clone your fork of `roast` to a local directory
- set the origin and upstream remotes
- checkout a branch to work on your issue or proposal
  - see [below](#working-the-issue) for details
- when through, ensure all desired commits are finished
- push the issue branch to your origin (your fork of `roast` on github)
- go to your github account for project `roast` and submit the PR

### Working the issue

#### Normal tests

New tests for existing features are usually accomplished by adding
the test(s) to an existing test file. Then that file's `plan` count is
updated. The new test(s) are tested locally by executing

```
$ raku <test file(s)>
```

When all is well, the commits are finalized, the branch is pushed
to the user's fork on Github, and there the PR is initiated.

If a new test file has been created, one additional step has to be
taken: the new test file has to be added to `spectest.data`.
(This file used to live in the Rakudo repo at `github.com/rakudo/rakudo`
but it is part of `roast` nowadays.) The header of `spectest.data` is to be
carefully examined as the test may require additional marking or other kinds of
special care.

#### Fudged tests

Let's say you want to propose a new feature, method `printf` for IO::Handle and,
being a believer in test-driven development, are submittng some test for
something that can't yet be tested. Thus we will need to create the test but we
will `fudge` it so it will be ignored.

We create a new test file named appropriately. Say, `S16-io/printf.t`,
the contents of which are:

```raku
use v6;
use Test;
plan 1;

my $f = $*TMPDIR.add('.printf-tmpfil');
my $fh = open $f, :w;
$fh.printf("Hi\n");
$fh.close;
my $res = slurp $f;
is $res, "Hi\n", "printf() works with zero args";
unlink $f;
```

We know the test doesn't work yet:

```
$ raku S16-io/printf.t
1..1
No such method 'printf' for invocant of type 'IO::Handle'
  in block <unit> at ./S16-io/printf.t line 9

# Looks like you planned 1 test, but ran 0
```

so we add the fudge to it to get the new contents:

```raku
use v6;
use Test;
plan 1;

#?rakudo skip 'GH #999999 not yet implemented'
{
    my $f = $*TMPDIR.add('.printf-tmpfil');
    my $fh = open $f, :w;
    $fh.printf("Hi\n");
    $fh.close;
    my $res = slurp $f;
    is $res, "Hi\n", "printf() works with zero args";
    unlink $f;
}
```

Notice we put the test in a block.  All tests in that block
are affected by the fudge line preceding it.

We want to test the fudged file before we submit the PR so we have to
manually create the fudged test file:

```
$ fudge rakudo S16-io/printf.t
S16-io/printf.rakudo
```

which, as we see by the return from the command, produces file
`S16-io/printf.rakudo` whose contents are

```raku
use v6;
use Test;
plan 1;

#?rakudo skip 'GH #999999 not yet implemented'
skip('GH #999999 not yet implemented', 1);# {
#     my $f = $*TMPDIR.add('.printf-tmpfil');
#     my $fh = open $f, :w;
#     $fh.printf("Hi\n");
#     $fh.close;
#     my $res = slurp $f;
#     is $res, "Hi\n", "printf() works with zero args";
#     unlink $f;
# }

say "# FUDGED!";
exit(1);
```

We can then test it:

```
$ raku S16-io/printf.rakudo
1..1
ok 1 - \# SKIP GH \#999999 not yet implemented
# FUDGED!
```

Success! Now we can commit the new test file, but **NOT** the generated fudge
test file that will be generated automatically by the test harness during the
regular testing on the servers. As described earlier, the new test file will
have to be added to the spectest.data file via a PR.

### Suggestions

#### Error Messages

In general, tests for the specific wording of error messages should go into the
implementation's test suite and not become part of the specification.

- the Rakudo implementation has a specific directory in its suite for messages tests:
    https://github.com/rakudo/rakudo/tree/master/t/05-messages

#### Exception types

If the test expects a generic exception, generally you should use `Exception`
and not `X::Comp::AdHoc` unless this is _exactly_ what is expected. This is to
handle a situation when a generic `die` is replaced with a typed exception to
produce a more specific and manageable error. For example, say, we had:

```raku
if $bad-data {
    die "Bad data, expected better one"
}
```

and replace it with

```raku
if $bad-data {
    X::Data::Bad.new.throw
}
```

Then a test like:

```raku
throws-like { test-sub() }, X::Comp::AdHoc;
```

will start failing because `X::Data::Bad` is unlikely to inherit from
`X::Comp::AdHoc`.
