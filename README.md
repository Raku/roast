# The Official Perl 6 Test Suite

The purpose of the test suite is to validate implementations that wish to be known
as a conforming Perl 6 implementation.

#### Contents

-  [Introduction](#introduction)

-  [Environment Variables](#environment-variables)

-  [Contributing](CONTRIBUTING.md)

## Introduction

Please consider this test suite to be the bleeding edge of Perl 6
development. New tests, tests for experimental new features, etc.,
will live on this 'master' branch. Once a specification is cut, a branch
will be created for that version of the spec, e.g., `6.c` for Christmas.

As they develop, different implementations will certainly be in
different states of readiness with respect to the test suite, so
in order for the various implementations to track their progress
independently, we've established a mechanism for _fudging_ the
tests in a kind of failsoft fashion.  To pass a test officially,
an implementation must be able to run a test file unmodified, but an
implementation may (temporarily) skip tests or mark them as "todo" via
the fudging mechanism, which is implemented via the `fudge` preprocessor.
Individual implementations are not allowed to modify the actual test
code, but may insert line comments before each actual test (or block
of tests) that changes how those tests are to be treated for this
platform.  The `fudge` preprocessor pays attention only to the comments
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
the expression are in scope at the location `fudge` eventually inserts a
"skip()" call.

When applied to a subsequent sub definition, `fudge` registers the sub name as
doing that many tests when called.  Note, however, that any skipping
is done at the point of the call, not within the subroutine, so the count
may not refer to any parameter of the sub.

When you run the `fudge` preprocessor, if it decides the test needs
fudging, it returns the new fudged filename; otherwise it returns
the original filename.  (Generally you don't run `fudge` directly,
but your test harness runs the `fudgeall` program for you; see below.)
If there is already a fudged program in the directory that is newer
than the unfudged version, `fudge` just returns the fudged version
without regenerating it.  If the fudged version is older, it removes
it and then decides anew whether to regenerate it based on the internal
fudge comments.

The `fudgeall` program may be called to process all the needed fudging
for a particular implementation:

```perl6
$ fudgeall rakudo */*.t */*/*.t
```

Program `fudgeall` will use the `fudge` program to translate any fudged files to a new
file where the extension is not `*.t` but instead is `*.rakudo` to indicate
the implementation dependency.  It also returns the fudged list of filenames
to run, where unfudged tests are just passed through unchanged as `*.t`.
Each test comes through as either fudged or not, but never both.
The test harness then runs the selected test files as it normally
would (it shouldn't care whether they are named `*.t` or `*.rakudo`).

In cases where the current working directory makes a difference, the tests
assume that the working directory is the root of the test suite, so that the
relative path to itself is `t/spec/S\d\d-$section/$filename`.

## Environment Variables

- **ROAST_TIMING_SCALE**

Some tests rely on a process to complete in a certain amount of time. If you're
running on a slowish computer, try setting **ROAST_TIMING_SCALE** to a larger
value that will be used as a multiplier for the time to wait. We don't wait for
too long a time by default so as to make the roast run faster.  Defaults to `1`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
