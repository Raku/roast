use v6;
use Test;

plan 1;

{
    # https://github.com/Raku/old-issue-tracker/issues/5308
    lives-ok { $*USER.gist; $*USER.WHAT.gist; },
        '.WHAT on $*USER after using $*USER values lives';
}

# vim: expandtab shiftwidth=4
