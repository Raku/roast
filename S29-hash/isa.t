use v6;
use Test;
plan 2;

# L<S29/"Hash">
# there's probably a better smart link

=begin pod

Isa tests

=end pod

{
    my %hash = <1 2 3 4>;
    isa_ok(%hash, 'Hash');
    isa_ok(%hash, 'List');
}
