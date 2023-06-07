use Test;
plan 6;

{
    my %h is Map = (a => 'b', c => Mu);

    ok  (['a']      ~~ %h), 'Array ~~ Map (exists and True)';
    ok  (['c']      ~~ %h), 'Array ~~ Map (exists but Mu)';
    ok  ([<a c>]    ~~ %h), 'Array ~~ Map (both exist)';
    ok  ([<c d>]    ~~ %h), 'Array ~~ Map (one exists)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %h), 'Array ~~ Map (empty list)';
    ok !(['e']      ~~ %h), 'Array ~~ Map (not exists)';

}

# vim: expandtab shiftwidth=4
