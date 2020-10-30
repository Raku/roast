use v6;
use Test;

# L<S11/Exportation>
use lib $?FILE.IO.parent(2).child("packages/Export_Pack/lib");

plan 7;

# (Automatic s:g/::/$PATH_SEPARATOR_OF_CUR_OS/)++
use Export_PackB;

ok Export_PackB::does_export_work(),
  "'is export' works correctly even when not exporting to Main (1)";

# packages::Export_PackA::exported_foo should not have been exported into
# our namespace.
dies-ok { ::('&exported_foo')() },
  "'is export' works correctly even when not exporting to Main (2)";

{
    use Export_PackC;
    lives-ok { foo_packc() }, "lexical export works";
}
dies-ok { ::('&foo_packc')() }, "lexical export is indeed lexical";


sub moose is test-assertion {
    use Export_PackD;
    is(this_gets_exported_lexically(), 'moose!', "lexical import survives pad regeneration")
}

moose();
moose();
moose();

# vim: expandtab shiftwidth=4
