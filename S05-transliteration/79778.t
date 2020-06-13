use v6;

use Test;
plan 1;

# https://github.com/Raku/old-issue-tracker/issues/2277
is "this sentence no verb".trans( / \s+ / => " " ), 'this sentence no verb',"got expected string"  ;

# vim: expandtab shiftwidth=4
