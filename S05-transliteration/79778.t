use v6;

use Test;

is "this sentence no verb".trans( / \s+ / => " " ), 'this sentence no verb',"RT #79778 got expected string"  ;

done;
