use v6;
use Test;

plan 8;
lives_ok { require "t/spec/S11-modules/InnerModule.pm"; },
         'can load InnerModule.pm from a path at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

# no need to do that at compile time, sine require() really is run time
@*INC.push: 't/spec/packages';

# Next line is for final test.
#?pugs emit #
GLOBAL::<$x> = 'still here';

lives_ok { require Fancy::Utilities; },
         'can load Fancy::Utilities at run time';
is Fancy::Utilities::lolgreet('me'),
   'O HAI ME', 'can call our-sub from required module';

lives_ok { my $name = 'A'; require $name }, 'can require with variable name';

#?pugs skip 'Must only use named arguments to new() constructor'
{
    require 'Fancy::Utilities';
    is ::('Fancy::Utilities')::('&lolgreet')('tester'), "O HAI TESTER",
       'can call subroutines in a module by name';
}

#?pugs skip 'NYI'
{
    require Fancy::Utilities <&allgreet>;
    is allgreet(), 'hi all', 'require with import list';
}

#?pugs skip 'parsefail'
is GLOBAL::<$x>, 'still here', 'loading modules does not clobber GLOBAL';

# vim: ft=perl6
