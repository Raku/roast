use v6;
use Test;

plan 1;

{
    # RT #128099
    lives-ok { $*USER.gist; $*USER.WHAT.gist; },
        '.WHAT on $*USER after using $*USER values lives';
}

# vim: ft=perl6
