use v6;
use Test;
plan 2;

# L<S32::Containers/"List"/"=item map">

my $text  = "abc";
my %ret;

# XXX depends on the Pair stringification which is likely going to change

{
    %ret = map { $_ => uc $_; }, $text.comb;
    is ~%ret.sort, "a\tA b\tB c\tC", "=> works in a map block";
}

%ret = map { $_, uc $_ }, $text.comb;
is ~%ret.sort, "a\tA b\tB c\tC", "map called with function return values works";

# vim: ft=perl6
