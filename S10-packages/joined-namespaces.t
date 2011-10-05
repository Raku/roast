use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages/' }

plan 1;

use Fancy::Utilities;
ok eval('class Fancy { }; 1'), 'can define a class A when module A::B has been used';
