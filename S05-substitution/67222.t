use v6;
use Test;
plan 1;

$_ = "(foo,bar,(baz))"; 
$_.=subst( /<-[(),]>+/, { "'$/'" }, :g ); 

# https://github.com/Raku/old-issue-tracker/issues/1117
ok $_ eq "('foo','bar',('baz'))", "RT #67222 check the value of \$/ in closures in the second argument of .=subst calls";

# vim: expandtab shiftwidth=4
