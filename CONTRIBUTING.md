# Contributing

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
- go to your github account for project `roast` and submit the PR

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
tested. Thus we will need to create the test but we will `fudge` it so
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

We know the test doesn't work yet:

```perl6
$ perl6 S16-io/printf.t
1..1
No such method 'printf' for invocant of type 'IO::Handle'
  in block <unit> at ./S16-io/printf.t line 9

# Looks like you planned 1 test, but ran 0
```

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
```

which, as we see by the return from the command, produces file
`S16-io/printf.rakudo` whose contents are


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
