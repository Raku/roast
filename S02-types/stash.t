use v6;

use Test;

plan 1;

#L<S02/Mutable Types>

# RT #118029
{
    sub S (Stash $s) { $s.WHAT.perl };
    is S(Stash.new), 'Stash', 'Stash.new creates Stash, not a Hash';
}

# vim: ft=perl6
