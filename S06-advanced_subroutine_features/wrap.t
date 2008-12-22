use v6;

use Test;

# L<S06/Wrapping>

# TODO
# nextsame, callwith
# named wrapping/unwrapping
# unwrap with no args pops the top most
#
# mutating wraps -- those should be "deep", as in not touching coderefs
# but actually mutating how the coderef works.
#
# of course, if we allow assigning into coderefs, then the wrap semantic
# could become a simple reassignment; but that is unspecced.

plan 20;

my @log;

sub foo {
    push @log, "foo";
}

sub wrapper {
    push @log, "wrapper before";
    try { callsame };
    push @log, "wrapper after";
}

sub other_wrapper (|$args) {
    push @log, "wrapper2";
    try { nextwith(|$args) };
}

foo();
is(+@log, 1, "one event logged");
is(@log[0], "foo", "it's foo");

@log = ();

wrapper();
is(+@log, 2, "two events logged");
is(@log[0], "wrapper before", "wrapper before");
is(@log[1], "wrapper after", "wrapper after");

@log = ();

my $wrapped;
try {
    $wrapped = &foo.wrap(&wrapper);
};

#?pugs 99 todo 'feature: wrapping'
isa_ok($wrapped, Sub);

$wrapped ||= -> { };
try { $wrapped.() };

is(+@log, 3, "three events logged");
is(@log[0], "wrapper before", "wrapper before");
is(@log[1], "foo", "the wrapped sub");
is(@log[2], "wrapper after", "wrapper after");

@log = ();

my $doublywrapped;
try {
    $doublywrapped = $wrapped.wrap(&other_wrapper);
};

isa_ok($doublywrapped, Sub);
$doublywrapped ||= -> { };
try { $doublywrapped.() };

is(+@log, 4, "four events");
is(@log[0], "wrapper2", "additional wrapping takes effect");
is(@log[1], "wrapper before", "... on top of initial wrapping");

@log = ();

try { $wrapped.() };
is(+@log, 3, "old wrapped sub was not destroyed");
is(@log[0], "wrapper before", "the original wrapper is still in effect");


@log = ();

my $unwrapped;
try {
    $unwrapped = $wrapped.unwrap(&wrapper);
};

isa_ok($unwrapped, Sub);
$unwrapped ||= -> {};
try { $unwrapped.() };

is(+@log, 2, "two events for unwrapped");
is(@log[0], "wrapper2");
is(@log[1], "foo");
