use v6.d;

# L<S11/Exportation>
use lib $?FILE.IO.parent.child("packages");

use Test;

plan 7;

# (Automatic s:g/::/$PATH_SEPARATOR_OF_CUR_OS/)++
use packages::Export_PackB;

ok packages::Export_PackB::does_export_work(),
  "'is export' works correctly even when not exporting to Main (1)";

# packages::Export_PackA::exported_foo should not have been exported into
# our namespace.
dies-ok { ::('&exported_foo')() },
  "'is export' works correctly even when not exporting to Main (2)";

{
    use packages::Export_PackC;
    lives-ok { foo_packc() }, "lexical export works";
}
dies-ok { ::('&foo_packc')() }, "lexical export is indeed lexical";


sub moose {
    use packages::Export_PackD;
    is(this_gets_exported_lexically(), 'moose!', "lexical import survives pad regeneration")
}

moose();
moose();
moose();

# vim: ft=perl6
