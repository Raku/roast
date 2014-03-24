use v6;
use Test;
plan 32;

# :exists
# =======

my %h = a=>1, b=>2;

is_deeply %h<a>:exists, True, 'exists';

is_deeply %h<a b c>:exists, (True, True, False), 'exists - slice';

isa_ok ((%h<a>:exists).WHAT), Bool, 'exists type';
isa_ok ((%h<a b c>:exists).WHAT), Parcel, 'exists type - slice';

my @a="a";
isa_ok ((%h{@a}:exists).WHAT), Parcel, 'exists type - array';

is_deeply %h<c>:!exists, True, 'does not exist';

# :delete
# =======

is_deeply %h<a>:delete, 1, 'delete';
is_deeply %h, ("b" => 2).hash, 'delete result';

%h = a=>1, b=>2;
is_deeply %h<a b c>:delete, (1, 2, (Any)), 'delete slice';
is_deeply %h, ().hash, 'delete result';

{
    my %h is default(42) = a=>1, b=>2;
    is_deeply %h<a b c>:delete, (1, 2, 42), 'delete slice with default';
}

{
    my $really = True; my %h = a=>1, b=>2;
    is_deeply %h<a b c>:delete($really), (1, 2, (Any)), 'delete(True) slice';
    is_deeply %h, ().hash, 'delete(True) result';
}

{
    my $really; my %h = a=>1, b=>2;
    is_deeply %h<a b c>:delete($really), (1, 2, (Any)), 'delete(False) slice';
    is_deeply %h, ("a" => 1, "b" => 2).hash, 'delete(False) result';
}

# :kv, :p, :k, :v
# ===============

%h = a=>1, b=>2;

is_deeply %h<a>:kv, ("a", 1), ':kv';
is_deeply %h<a>:p, ("a" => 1), ':p';
is_deeply %h<a>:k, "a", ':k';
is_deeply %h<a>:v, 1, ':v';

is_deeply %h<a b c>, (1, 2, (Any)), "hash slice";
is_deeply %h<a b c>:v, (1, 2), "hash slice :v";

is_deeply %h<a b c>:k, ('a', 'b'), "hash slice, :k adverb";
is_deeply %h<a b c>:!k, ('a', 'b', 'c'), "hash slice :!k adverb";

# Combining Adverbs
# -----------------

my %i = (%h<a c>:delete:p).list;
is_deeply %h, ("b" => 2).hash, '%h';
is_deeply %i, ("a" => 1).hash, '%i';

%h = a=>1, b=>2;
is_deeply %h<a b c>:delete:k, ('a', 'b'), ':delete:k adverbs';

# Arrays are not Hashes
# ---------------------
{
    my @a;
    @a[3] = 1;
    is @a[]:k, 3, '@a[]:k';
    is_deeply @a[]:!k, (0,1,2,3), '@a[]:!k';

    @a = ^10;
    @a[3]:delete;
    is_deeply @a[2,3,4], (2, Any, 4), '@a[2,3,4]';
    is_deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4]';
}

{
    my @a is default(42) = ^10;
    @a[3]:delete;

    is_deeply @a[2,3,4], (2, 42, 4), '@a[2,3,4] (default)';
    is_deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4] (default)';
}
