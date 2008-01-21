use v6-alpha;
use Test;
plan 2;

# L<S29/"List"/"=item map">

my $text  = "abc";
my %ret;

%ret = map { $_ => uc $_; }, split "", $text;
is ~%ret.kv, "a A b B c C", "=> works in a map block";

%ret = map { $_, uc $_ }, split "", $text;
is ~%ret.kv, "a A b B c C", "map called with function return values works";
