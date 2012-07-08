use v6;
use Test;

plan 5;

# no need to do that compile time, sine require() really is run time
@*INC.push: 't/spec/packages';

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

# vim: ft=perl6
