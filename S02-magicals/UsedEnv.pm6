module UsedEnv {
    use Test;
    plan 1;
    ok %*ENV.exists('PATH'), "env exists in use (RT #78258)";
    done;
}

