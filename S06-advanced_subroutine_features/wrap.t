use v6;

use Test;

# L<S06/Wrapping>

# TODO
# nextsame, nextwith, callsame
# unwrap with no args pops the top most (is this spec?)
#
# mutating wraps -- those should be "deep", as in not touching coderefs
# but actually mutating how the coderef works.

plan 21;

my @log;

sub foo {
    push @log, "foo";
}

sub wrapper {
    push @log, "wrapper before";
    try { callwith() };
    push @log, "wrapper after";
}

sub other_wrapper () {
    push @log, "wrapper2";
    try { callwith() };
}

foo();
is(+@log, 1, "one event logged");
is(@log[0], "foo", "it's foo");

dies_ok { &foo.unwrap() }, 'cannot upwrap a never-wrapped sub.';

@log = ();

wrapper();
is(+@log, 2, "two events logged");
is(@log[0], "wrapper before", "wrapper before");
is(@log[1], "wrapper after", "wrapper after");

@log = ();

my $wrapped = &foo.wrap(&wrapper);

foo();

is(+@log, 3, "three events logged");
is(@log[0], "wrapper before", "wrapper before");
is(@log[1], "foo", "the wrapped sub");
is(@log[2], "wrapper after", "wrapper after");

@log = ();

my $doublywrapped = &foo.wrap(&other_wrapper);
foo();

is(+@log, 4, "four events");
is(@log[0], "wrapper2", "additional wrapping takes effect");
is(@log[1], "wrapper before", "... on top of initial wrapping");

@log = ();

&foo.unwrap($doublywrapped);
foo();

is(+@log, 3, "old wrapped sub was not destroyed");
is(@log[0], "wrapper before", "the original wrapper is still in effect");

@log = ();

&foo.unwrap($wrapped);
foo();

is(+@log, 1, "one events for unwrapped (should be back to original now)");
is(@log[0], "foo", "got execpted value");

@log = ();

$wrapped = &foo.wrap(&wrapper);
$doublywrapped = &foo.wrap(&other_wrapper);
&foo.unwrap($wrapped);
foo();
is(+@log, 2, "out of order unwrapping gave right number of results");
is(@log[0], "wrapper2", "got execpted value from remaining wrapper");
is(@log[1], "foo", "got execpted value from original sub");

dies_ok { &foo.unwrap($wrapped) }, "can't re-unwrap an already unwrapped sub";
