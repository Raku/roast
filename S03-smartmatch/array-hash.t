use v6.c;
use Test;
plan 6;

#L<S03/"Smart matching"/Array Hash hash slice existence>
#?rakudo skip 'RT #124444'
{
    my %h = (a => 'b', c => Mu);

    ok  (['a']      ~~ %h), 'Array ~~ Hash (exists and True)';
    ok  (['c']      ~~ %h), 'Array ~~ Hash (exists but Mu)';
    ok  ([<a c>]    ~~ %h), 'Array ~~ Hash (both exist)';
    ok  ([<c d>]    ~~ %h), 'Array ~~ Hash (one exists)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %h), 'Array ~~ Hash (empty list)';
    ok !(['e']      ~~ %h), 'Array ~~ Hash (not exists)';

}

# vim: ft=perl6
