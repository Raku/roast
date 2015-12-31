use v6;
use Test;

plan 10;

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);
    isa-ok $pany, Promise, "anyof returns a Promise";
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
    lives-ok { $pany.result }, "Getting result of anyof where on Promise broke lives";
    is $pany.status, Kept, "Promise from anyof was kept";
    
    $p1.keep(1);
    is $pany.status, Kept, "Other promise keeping doesn't affect status";
}

# RT #127101
{
     my $p = Promise.anyof(my @promises);
     is $p.status, Kept, 'an empty list should give a kept Promise';
}

throws-like { Promise.anyof(42) }, X::Promise::Combinator;
