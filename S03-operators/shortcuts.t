use v6;
use Test;

plan 6;

class C {
  method @.[$i] { $i }
  method %.{$k} { $k }
  method &.($a) { 'karma ' ~ $a }
}

my $o = C.new;
ok  $o.[42] == 42, '@.[]';
ok  $o[42] == 42, '@.[] again';
ok  $o.{'thanks'} eq 'thanks', '%.{}';
ok  $o{'fish'} eq 'fish', '%.{} again';
ok  $o.('gnole') eq 'karma gnole', '@.()';
ok  $o('gnole') eq 'karma gnole', '@.() again';
