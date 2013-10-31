use v6;
use Test;

plan 58;

{
    my $p = Promise.new;
    is $p.status, Planned, "Newly created Promise has Planned status";
    nok $p.has_result, "Newly created Promise has now result yet";
    nok ?$p, "Newly created Promise is false";
    dies_ok { $p.cause }, "Cannot call cause on a Planned Promise";
    
    $p.keep("kittens");
    is $p.status, Kept, "Kept Promise has Kept status";
    ok $p.has_result, "Kept Promise has a result";
    ok ?$p, "Kept Promise is true";
    is $p.result, "kittens", "Correct result";
    
    dies_ok { $p.cause }, "Cannot call cause on a Kept Promise";
    dies_ok { $p.keep("eating") }, "Cannot re-keep a Kept Promise";
    dies_ok { $p.break("bad") }, "Cannot break a Kept Promise";
}

{
    my $p = Promise.new;
    $p.break("glass");
    is $p.status, Broken, "Broken Promise has Broken status";
    ok $p.has_result, "Broken Promise has a result";
    ok ?$p, "Broken Promise is true";
    isa_ok $p.cause, Exception, "cause returns an exception";
    is $p.cause.message, "glass", "Correct message";
    dies_ok { $p.result }, "result throws exception";
    
    dies_ok { $p.keep("eating") }, "Cannot keep a Broken Promise";
    dies_ok { $p.break("bad") }, "Cannot re-break a Broken Promise";
}

{
    my $p = Promise.run({
        pass "Promise.run actually runs";
        42
    });
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = Promise.run({
        pass "Promise.run actually runs";
        die "trying"
    });
    dies_ok { $p.result }, "result throws exception";
    is $p.status, Broken, "Promise was broken";
    is $p.cause.message, "trying", "Correct exception stored";
}

{
    my $start = now;
    my $p = Promise.sleep(1);
    is $p.result, True, "Promise.sleep result is True";
    ok now - $start >= 1, "Promise.sleep took long enough";
}

{
    my $run_then = 0;
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        $run_then = 1;
        ok $res === $p1, "Got correct Promise passed to then";
        is $res.status, Kept, "Promise passed to then was kept";
        is $res.result, 42, "Got correct result";
        101
    });
    isa_ok $p2, Promise, "then returns a Promise";
    is $run_then, 0, "Not run then yet";
    
    $p1.keep(42);
    is $p2.result, 101, "Got correct result from then Promise";
    ok $run_then, "Certainly ran the then";
}

{
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        ok $res === $p1, "Got correct Promise passed to then";
        is $res.status, Broken, "Promise passed to then was broken";
        is $res.cause.message, "we fail it", "Got correct cause";
        "oh noes"
    });
    
    $p1.break("we fail it");
    is $p2.result, "oh noes", "Got correct result from then Promise";
}

{
    my $run_then = 0;
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        die "then died"
    });

    $p1.keep(42);
    dies_ok { $p2.result }, "result from then Promise dies";
    is $p2.status, Broken, "then Promise is broken";
    is $p2.cause.message, "then died", "then Promise has correct cause";
}

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);
    isa_ok $pany, Promise, "anyof returns a Promise";
    nok $pany.has_result, "No result yet";
    
    $p1.keep(1);
    is $pany.result, True, "result is true";
    is $pany.status, Kept, "Promise was kept";
    
    $p2.break("fail");
    is $pany.status, Kept, "Other promise breaking doesn't affect status";
}

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);
    
    $p2.break("oh noes");
    dies_ok { $pany.result }, "Getting result of broken anyof dies";
    is $pany.status, Broken, "Promise was broken";
    is $pany.cause.message, "oh noes", "breakage reason conveyed";
    
    $p1.keep(1);
    is $pany.status, Broken, "Other promise keeping doesn't affect status";
}

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pall = Promise.allof($p1, $p2);
    isa_ok $pall, Promise, "allof returns a Promise";
    nok $pall.has_result, "No result yet";
    
    $p1.keep(1);
    nok $pall.has_result, "Still not kept";
    
    $p2.keep(1);
    is $pall.result, True, "result is true after both kept";
    is $pall.status, Kept, "Promise was kept";
}

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pall = Promise.allof($p1, $p2);
    $p1.keep(1);
    $p2.break("danger danger");
    dies_ok { $pall.result }, "result on broken all-Promise throws";
    is $pall.status, Broken, "all-Promise was borken";
}
