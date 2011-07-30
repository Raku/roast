use v6;
use Test;

# L<S03/"Declarators">
# This section describes declarators like my, our, etc
# Note that the usage of declarators on the RHS is not spec'ed yet,
# but works like Perl 5. Also note that the list if declarators here
# does not match the list described in the referenced specs. 

plan 5;

# sanity: declarations and very simple use (scoping tests come later)
# we take care to use different names to avoid other *kinds* of insanity.

is((try {  my $a1 = my    $b1 = 42; $b1++; "$a1, $b1" }), '42, 43', "chained my");
is((try {  my $a2 = our   $b2 = 42; $b2++; "$a2, $b2" }), '42, 43', "chained my, our");
is((try {  my $a4 = constant $b4 = 42;     "$a4, $b4" }), '42, 42', "chained my, constant");
is((try {  my $a5 = state $b5 = 42; $b5++; "$a5, $b5" }), '42, 43', "chained my, state");

# scoping

eval_dies_ok '
    {
        our $sa2 = my $sb2 = 42;
    }
    ($sa2, $sb2);
   ', "scoping our, my ('our' doesn't leak)";

# XXX: add more!

# vim: ft=perl6
