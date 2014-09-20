use v6;
use Test;
plan 1;

enum somenum <a b c d e>; 
my somenum $temp = d; 
ok  $temp eq 'd', "RT #75370 enum name";

