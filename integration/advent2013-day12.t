use v6.c;
use Test;
plan 32;

# :exists
# =======

my %h = a=>1, b=>2;

is-deeply %h<a>:exists, True, 'exists';

is-deeply %h<a b c>:exists, (True, True, False), 'exists - slice';

isa-ok ((%h<a>:exists).WHAT), Bool, 'exists type';
isa-ok ((%h<a b c>:exists).WHAT), List, 'exists type - slice';

my @a="a";
isa-ok ((%h{@a}:exists).WHAT), List, 'exists type - array';

is-deeply %h<c>:!exists, True, 'does not exist';

# :delete
# =======

is-deeply %h<a>:delete, 1, 'delete';
is-deeply %h, ("b" => 2).hash, 'delete result';

%h = a=>1, b=>2;
is-deeply %h<a b c>:delete, (1, 2, (Any)), 'delete slice';
is-deeply %h, ().hash, 'delete result';

{
    my %h is default(42) = a=>1, b=>2;
    is-deeply %h<a b c>:delete, (1, 2, 42), 'delete slice with default';
}

{
    my $really = True; my %h = a=>1, b=>2;
    is-deeply %h<a b c>:delete($really), (1, 2, (Any)), 'delete(True) slice';
    is-deeply %h, ().hash, 'delete(True) result';
}

{
    my $really; my %h = a=>1, b=>2;
    is-deeply %h<a b c>:delete($really), (1, 2, (Any)), 'delete(False) slice';
    is-deeply %h, ("a" => 1, "b" => 2).hash, 'delete(False) result';
}

# :kv, :p, :k, :v
# ===============

%h = a=>1, b=>2;

is-deeply %h<a>:kv, ("a", 1), ':kv';
is-deeply %h<a>:p, ("a" => 1), ':p';
is-deeply %h<a>:k, "a", ':k';
is-deeply %h<a>:v, 1, ':v';

is-deeply %h<a b c>, (1, 2, (Any)), "hash slice";
is-deeply %h<a b c>:v, (1, 2), "hash slice :v";

is-deeply %h<a b c>:k, ('a', 'b'), "hash slice, :k adverb";
is-deeply %h<a b c>:!k, ('a', 'b', 'c'), "hash slice :!k adverb";

# Combining Adverbs
# -----------------

my %i = (%h<a c>:delete:p).list;
is-deeply %h, ("b" => 2).hash, '%h';
is-deeply %i, ("a" => 1).hash, '%i';

%h = a=>1, b=>2;
is-deeply %h<a b c>:delete:k, ('a', 'b'), ':delete:k adverbs';

# Arrays are not Hashes
# ---------------------

#RT #121622
{
    my @a;
    @a[3] = 1;
    is @a[]:k, 3, '@a[]:k';
    is-deeply @a[]:!k, (0,1,2,3), '@a[]:!k';
}
{
    my @a = ^10;
    @a[3]:delete;
    is-deeply @a[2,3,4], (2, Any, 4), '@a[2,3,4]';
    is-deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4]';
}

{
    my @a is default(42) = ^10;
    @a[3]:delete;

    is-deeply @a[2,3,4], (2, 42, 4), '@a[2,3,4] (default)';
    is-deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4] (default)';
}
