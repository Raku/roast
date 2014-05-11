use v6;
use Test;

plan 19;

{
    my $p = Promise.new;
    is $p.status, Planned, "Newly created Promise has Planned status";
    nok $p.Bool, "Newly created Promise has now result yet";
    nok ?$p, "Newly created Promise is false";
    dies_ok { $p.cause }, "Cannot call cause on a Planned Promise";
    
    $p.keep("kittens");
    is $p.status, Kept, "Kept Promise has Kept status";
    ok $p.Bool, "Kept Promise has a result";
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
    ok $p.Bool, "Broken Promise has a result";
    ok ?$p, "Broken Promise is true";
    isa_ok $p.cause, Exception, "cause returns an exception";
    is $p.cause.message, "glass", "Correct message";
    dies_ok { $p.result }, "result throws exception";
    
    dies_ok { $p.keep("eating") }, "Cannot keep a Broken Promise";
    dies_ok { $p.break("bad") }, "Cannot re-break a Broken Promise";
}
