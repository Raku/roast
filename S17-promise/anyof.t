use v6;
use Test;

plan 10;

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);
    isa_ok $pany, Promise, "anyof returns a Promise";
    nok $pany.Bool, "No result yet";
    
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

#?rakudo todo 'proper type checking of arguments'
throws_like { Promise.anyof(42) }, X::Promise::Combinator;
