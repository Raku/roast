use v6;
use Test;

=begin kwid

  regex r { <null> | x <r> }

  "x" ~~ /<r>$/  should match "x", not "".

=end kwid

plan 20;

unless "a" ~~ /a/ {
  skip_rest "skipped tests - rule support appears to be missing";
  exit;
}

# rule r { <null> | x <r> }  - XXX 'rule' doesn't backtrack
regex r { <null> | x <r> }

ok "" ~~ /<r>/, '"" ~~ /<r>/ matched';
is $/, "", 'with ""';
is $/.from, 0, 'from 0';
is $/.to, 0, 'to 0';

ok "x" ~~ /<r>/, '"x" ~~ /<r>/ matched';
is $/, "", 'with ""';
is $/.from, 0, 'from 0';
is $/.to, 0, 'to 0';

#?pugs emit skip_rest 'infinite loop in PCR - XXX fix this before release!';
#?pugs emit exit;

ok "x" ~~ /<r>$/, '"x" ~~ /<r>$/ matched';
is $/, "x", 'with "x"';
is $/.from, 0, 'from 0';
is $/.to, 1, 'to 1';

ok "xx" ~~ /<r>$/, '"xx" ~~ /<r>$/ matched';
is $/, "xx", 'with "xx"';
is $/.from, 0, 'from 0';
is $/.to, 2, 'to 2';


# rule r2 { <null> | <r2> x }
regex r2 { <null> | <r2> x }

ok "x" ~~ /<r2>$/, '"x" ~~ /<r2>$/ matched';
is $/, "x", 'with "x"';
is $/.from, 0, 'from 0';
is $/.to, 1, 'to 1';

