use v6;
use Test;

plan 1;

{
    # https://github.com/Raku/old-issue-tracker/issues/5308
    lives-ok { $*GROUP.gist; $*GROUP.WHAT.gist; },
        '.WHAT on $*GROUP after using $*GROUP values lives';
}

# vim: expandtab shiftwidth=4
