use v6;
use Test;

=begin kwid

  regex r { <?> | x <r> }

  "x" ~~ /<r>$/  should match "x", not "".

=end kwid

plan 20;

# L<S05/Extensible metasyntax (C<< <...> >>)>

my regex r { <?> || x <&r> }

ok "" ~~ /<&r>/, '"" ~~ /<r>/ matched';
is $/, "", 'with ""';
is $/.from, 0, 'from 0';
is $/.to, 0, 'to 0';

ok "x" ~~ /<&r>/, '"x" ~~ /<r>/ matched';
is $/, "", 'with ""';
is $/.from, 0, 'from 0';
is $/.to, 0, 'to 0';

#?pugs emit skip_rest 'infinite loop in PCR - XXX fix this before release!'; exit;

ok "x" ~~ /<&r>$/, '"x" ~~ /<r>$/ matched';
#?rakudo todo 'nom regression'
is $/, "x", 'with "x"';
#?rakudo todo 'nom regression'
is $/.from, 0, 'from 0';
is $/.to, 1, 'to 1';

ok "xx" ~~ /<&r>$/, '"xx" ~~ /<r>$/ matched';
#?rakudo todo 'nom regression'
is $/, "xx", 'with "xx"';
#?rakudo todo 'nom regression'
is $/.from, 0, 'from 0';
is $/.to, 2, 'to 2';


# rule r2 { <?> | <r2> x }
my regex r2 { <?> | <&r2> x }

ok "x" ~~ /<&r2>$/, '"x" ~~ /<r2>$/ matched';
#?rakudo todo 'nom regression'
is $/, "x", 'with "x"';
#?rakudo todo 'nom regression'
is $/.from, 0, 'from 0';
is $/.to, 1, 'to 1';


# vim: ft=perl6
