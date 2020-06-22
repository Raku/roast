use v6;

use Test;

plan 1;

#L<S02/Mutable Types>

# https://github.com/Raku/old-issue-tracker/issues/3137
{
    sub S (Stash $s) { $s.WHAT.raku };
    is S(Stash.new), 'Stash', 'Stash.new creates Stash, not a Hash';
}

# vim: expandtab shiftwidth=4
