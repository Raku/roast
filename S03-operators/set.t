use v6;
use Test;

plan 2;

# Union tests moved to union.t

# Intersection tests moved to intersection.t

# set subtraction moved to difference.t

# symmetric difference moved to set_symmetric_difference.t

# symmetric difference with Bag moved to bag.t

# is subset of moved to subset.t

# is proper subset of moved to proper-subset.t

# is not a proper subset of moved to proper-subset.t

# is superset of moved to subset.t

# is not a superset of moved to proper-subset.t

# RT #117997
{
    throws-like 'set;', Exception,
        'set listop called without arguments dies (1)',
        message => { m/'Function "set" may not be called without arguments'/ };
    throws-like 'set<a b c>;', X::Syntax::Confused,
        'set listop called without arguments dies (2)',
        message => { m/'Use of non-subscript brackets after "set" where postfix is expected'/ };
}

# vim: ft=perl6
