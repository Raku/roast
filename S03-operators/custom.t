use v6;
use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/2697
{
    enum A <e1 e2>;
    multi infix:<< - >>(e1, e2) { return "AWW" };
    is e1 - e2, "AWW", "can use <<>> for infix defs";
}

# vim: expandtab shiftwidth=4
