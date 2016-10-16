# The Official Perl 6 Test Suite

The purpose of the test suite is to validate implementations that wish to be known
as a conforming Perl 6 implementation.

#### Contents

-  [Introduction](#introduction)

-  [Environment Variables](#environment-variables)

-  [Contributing](#contributing)

## Introduction

Please consider this test suite to be the bleeding edge of Perl 6
development. New tests, tests for experimental new features, etc.,
will live on this 'master' branch. Once a specification is cut, a branch
will be created for that version of the spec, e.g., `6.c` for Christmas.

As they develop, different implementations will certainly be in
different states of readiness with respect to the test suite, so
in order for the various implementations to track their progress
independently, we've established a mechanism for "fudging" the
tests in a kind of failsoft fashion.  To pass a test officially,
an implementation must be able to run a test file unmodified, but an
implementation may (temporarily) skip tests or mark them as "todo" via
the fudging mechanism, which is implemented via the fudge preprocessor.
Individual implementations are not allowed to modify the actual test
code, but may insert line comments before each actual test (or block
of tests) that changes how those tests are to be treated for this
platform.  The fudge preprocessor pays attention only to the comments
that belong to the current implementation and ignores all the rest.  If your
implementation is named "rakudo" then your special comment lines look like:

    #?rakudo: [NUM] VERB ARGS

(The colon is optional.)

The optional NUM says how many statements or blocks to apply the
verb to.  (If not supplied, a value of 1 is assumed).  A statement
is arbitrarily defined as one or more lines starting with a test call
and ending in a semicolon (with an optional comment).

VERBs include:

    skip "reason"	# skip test entirely
    eval "reason"	# eval the test because it doesn't parse yet
    try "reason"	# try the test because it throws exception
    todo "reason"	# mark "todo" because "not ok" is expected
    emit code		# insert code (such as "skip-rest();") inline

All fudged tests return an exit code of 1 by default, so the test harness
will mark it as "dubious" even if all the tests supposedly pass.

You may also negate the test:

    #!rakudo [NUM] VERB ARGS

This will apply the verb on any system that *isn't* rakudo.

Sometimes environment variables distinguish syntactic or semantic
variants, so you may apply a verb depending on the presence or absence
of such a setting:

    #?MYSPECIALVAR [NUM] VERB ARGS
    #!MYSPECIALVAR [NUM] VERB ARGS

The environment variable must be uppercase.

There is also the following directive which modifies the test count of
the next construct:

    #?DOES count

The count may be an expression as long as any variables referenced in
the expression are in scope at the location fudge eventually inserts a
"skip()" call.

When applied to a subsequent sub definition, fudge registers the sub name as
doing that many tests when called.  Note, however, that any skipping
is done at the point of the call, not within the subroutine, so the count
may not refer to any parameter of the sub.

When you run the fudge preprocessor, if it decides the test needs
fudging, it returns the new fudged filename; otherwise it returns
the original filename.  (Generally you don't run "fudge" directly,
but your test harness runs the "fudgeall" program for you; see below.)
If there is already a fudged program in the directory that is newer
than the unfudged version, fudge just returns the fudged version
without regenerating it.  If the fudged version is older, it removes
it and then decides anew whether to regenerate it based on the internal
fudge comments.

The `fudgeall` program may be called to process all the needed fudging
for a particular implementation:

```perl6
    $ fudgeall rakudo */*.t */*/*.t
```

will use the "fudge" program to translate any fudged files to a new
file where the extension is not *.t but instead is *.rakudo to indicate
the implementation dependency.  It also returns the fudged list of filenames
to run, where unfudged tests are just passed through unchanged as *.t.
Each test comes through as either fudged or not, but never both.
The test harness then runs the selected test files as it normally
would (it shouldn't care whether they are named *.t or *.rakudo).

In cases where the current working directory makes a difference, the tests
assume that the working directory is the root of the test suite, so that the
relative path to itself is t/spec/S\d\d-$section/$filename.

## Environment Variables

- **ROAST_TIMING_SCALE**

Some tests rely on a process to complete in a certain amount of time. If you're
running on a slowish computer, try setting `ROAST_TIMING_SCALE` to a larger
value that will be used as a multiplier for the time to wait. We don't wait for
too long a time by default so as to make the roast run faster.  Defaults to `1`.

## Contributing

A person who wants to contribute a test to the project should read
this Github guide to
issues and [pull requests](http://help.github.com/categories/collaborating-with-issues-and-pull-requests)
(PRs) which describes in great detail the work flow for forks and
submitting PRs to a project.

Follow the same general steps for project `github.com/perl6/roast`:

- fork project `roast`
- clone your fork of `roast` to a local directory
- set the origin and upstream remotes
- checkout a branch to work on your issue or proposal
  - see [below](#working-the-issue) for details
- when through, ensure all desired commits are finished
- push the issue branch to your origin (your fork of `roast` on github)
- got to your github account for project `roast` and submit the PR

### Working the issue

#### Normal tests

New tests for existing features are usually accomplished by adding
the test(s) to an existing test file. Then that file's `plan` count is
updated.  The new test(s) are tested locally by executing

```perl6
    $ perl6 <test file(s)>
```

When all is well, the commits are finalized, the branch is pushed
to the user's fork on Github, and there the PR is initiated.

If a new test file has been created, one additional step has to be
taken: the new test file has to be added to
`github.com/rakudo/rakudo/t/spectest.data` and a PR for project
`github.com/rakudo/rakudo` can be submitted for that. However, it is
easier just to ask for help adding the new test file on IRC channel
`#perl6`.

#### Fudged tests

Let's say you want to propose a new feature, method `printf` for
IO::Handle, for `rakudo` and, being a believer in test-driven
development, are submittng some test for something that can't yet be
tested. Thus we will need to create the test but we will _fudge_ it so
it will be ignored.

We create a new test file named appropriately, say, `S16-io/printf.t` ,
the contents of which are:

```perl6
    use v6;
    use Test;
    plan 1;

    my $f = './.printf-tmpfil';
    my $fh = open $f, :w;
    $fh.printf("Hi\n");
    $fh.close;
    my $res = slurp $f;
    is $res, "Hi\n", "printf() works with zero args";
    unlink $f;
```

We know the test doesn't work yet

```perl6
    $ perl6 S16-io/printf.t
    1..1
    No such method 'printf' for invocant of type 'IO::Handle'
      in block <unit> at ./S16-io/printf.t line 9

    # Looks like you planned 1 test, but ran 0

so we add the fudge to it to get the new contents:

```perl6
    use v6;
    use Test;
    plan 1;

    #?rakudo skip 'RT #999999 not yet implemented'
    {
        my $f = './.printf-tmpfil';
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

```perl6
    $ fudge rakudo S16-io/printf.t
    S16-io/printf.rakudo

which produces file `S16-io/printf.rakudo` whose contents are

```perl6
    use v6;
    use Test;
    plan 1;

    #?rakudo skip 'RT #999999 not yet implemented'
    skip('RT #999999 not yet implemented', 1);# {
    #     my $f = './.printf-tmpfil';
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

```perl6
    $ perl6 S16-io/printf.rakudo
    1..1
    ok 1 - \# SKIP RT \#999999 not yet implemented
    # FUDGED!
```

Success! Now we can commit the new test file, but **NOT** the generated fudge
test file&mdash;that will be generated automatically by the test
harness during the regular testing on the servers. As
described earlier, the new test file will have to be added to the spectest.data
file, either via a PR or a request to someone on IRC to add it.
