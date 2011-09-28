use v6;
use Test;
plan 6;

#L<S03/"Smart matching"/Array Hash hash slice existence>
{
    my %h = (a => 'b', c => Mu);
    #?niecza skip 'TODO'
    ok  (['a']      ~~ %h), 'Array ~~ Hash (exists and True)';
    #?niecza skip 'TODO'
    ok  (['c']      ~~ %h), 'Array ~~ Hash (exists but Mu)';
    #?rakudo 2 todo 'nom regression'
    #?niecza skip 'TODO'
    ok  ([<a c>]    ~~ %h), 'Array ~~ Hash (both exist)';
    #?niecza skip 'TODO'
    ok  ([<c d>]    ~~ %h), 'Array ~~ Hash (one exists)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %h), 'Array ~~ Hash (empty list)';
    ok !(['e']      ~~ %h), 'Array ~~ Hash (not exists)';

}

done;

# vim: ft=perl6
