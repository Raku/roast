use v6;
use Test;

plan 3;

# no need to do that compile time, sine require() really is run time
@*INC.push: 't/spec/packages';

lives_ok { require Fancy::Utilities; },
         'can load Fancy::Utilities at run time';
is Fancy::Utilities::lolgreet('me'),
   'O HAI ME', 'can call our-sub from required module';

lives_ok { my $name = 'A'; require $name }, 'can require with variable name';

# vim: ft=perl6
