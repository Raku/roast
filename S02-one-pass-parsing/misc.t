use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/3692
{
    is_run q[say $\\], { :1status, err => /'Confused'/ },
        'spurious backslash at end of file error must ask for semicolon';
}

# vim: expandtab shiftwidth=4
