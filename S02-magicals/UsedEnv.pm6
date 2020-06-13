module UsedEnv {
    use Test;
    plan 1;
    # https://github.com/Raku/old-issue-tracker/issues/2213
    ok (%*ENV<PATH>:exists or %*ENV<HOMEPATH>:exists), "env exists in use (RT #78258)";
}


# vim: expandtab shiftwidth=4
