# http://perl6advent.wordpress.com/2009/12/01/day-1-getting-rakudo/

use v6;
use Test;

plan(2);

# say "Hello World";

is( (10/7).WHAT.gist, 'Rat()', 'WHAT');

is(([+] (1..999).grep( { $_ % 3 == 0 || $_ % 5 == 0 } )), 233168, 'Project Euler #1');
