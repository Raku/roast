use v6;
use Test;

plan 1;

{
    # RT #128099
    lives-ok { $*GROUP.gist; $*GROUP.WHAT.gist; },
        '.WHAT on $*GROUP after using $*GROUP values lives';
}

# vim: ft=perl6
