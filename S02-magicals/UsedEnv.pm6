module UsedEnv {
    use Test;
    plan 1;
    ok %*ENV<PATH>:exists, "env exists in use (RT #78258)";
    done;
}

