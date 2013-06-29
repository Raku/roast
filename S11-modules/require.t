use v6;
use Test;

plan 12;

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives_ok { require "t/spec/S11-modules/InnerModule.pm"; },
         'can load InnerModule from a path at run time';
#?pugs skip 'parsefail'
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

my $name = 't/spec/S11-modules/InnerModule.pm';

#?rakudo todo 'variable form plus imports NYI'
#?pugs 2 skip "parsefail"
lives_ok { require $name '&bar'; },
         'can load InnerModule from a variable at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
#?pugs skip "parsefail"
{
    require InnerModule:file($name) <&bar>;
    is bar(), 'Inner::bar', 'can load InnerModule by name and path, with import list';
}

#RT #118407
#?rakudo skip "Null PMC access"
#?pugs skip 'parsefail'
{ 
    require InnerModule:file($name) <quux>;
    is quux(), 'Inner::quux', "can import quux without ampersand (&quux)";
}

# no need to do that at compile time, since require() really is run time
@*INC.unshift: 't/spec/packages';

# Next line is for final test.
#?pugs emit #
GLOBAL::<$x> = 'still here';

lives_ok { require Fancy::Utilities; },
         'can load Fancy::Utilities at run time';
is Fancy::Utilities::lolgreet('me'),
   'O HAI ME', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
#?pugs todo
lives_ok { my $name = 'A'; require ::($name) }, 'can require with variable name';

#?pugs skip 'Must only use named arguments to new() constructor'
{
    require ::('Fancy::Utilities');
    is ::('Fancy::Utilities')::('&lolgreet')('tester'), "O HAI TESTER",
       'can call subroutines in a module by name';
}

# L<S11/"Runtime Importation"/"Importing via require also installs names into the current lexical scope">

#?pugs skip 'NYI'
{
    require Fancy::Utilities <&allgreet>;
    is allgreet(), 'hi all', 'require with import list';
}

#?pugs skip 'parsefail'
is GLOBAL::<$x>, 'still here', 'loading modules does not clobber GLOBAL';

# vim: ft=perl6
