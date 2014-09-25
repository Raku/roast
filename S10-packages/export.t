use v6;

# L<S11/Exportation>

use Test;

plan 7;

use lib '.';

# (Automatic s:g/::/$PATH_SEPARATOR_OF_CUR_OS/)++
use t::spec::packages::Export_PackB;

ok t::spec::packages::Export_PackB::does_export_work(),
  "'is export' works correctly even when not exporting to Main (1)";

# t::spec::packages::Export_PackA::exported_foo should not have been exported into
# our namespace.
dies_ok { exported_foo() },
  "'is export' works correctly even when not exporting to Main (2)";

{
    use t::spec::packages::Export_PackC;
    lives_ok { foo_packc() }, "lexical export works";
}
dies_ok { foo_packc() }, "lexical export is indeed lexical";


sub moose {
    use t::spec::packages::Export_PackD;
    is(this_gets_exported_lexically(), 'moose!', "lexical import survives pad regeneration")
}

moose();
moose();
moose();

# vim: ft=perl6
