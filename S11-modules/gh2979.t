use v6;
use Test;

plan 8;

# GH#2979 Symbols are not to be exported in containerized form.

use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");

#?rakudo.jvm emit # compile time error: Method 'name' not found for invocant of class 'Any'
use GH2979;

#?rakudo.jvm 8 skip 'fails due to above error'
is @foo.VAR.^name, 'Array', 're-exported Array';
is %foo.VAR.^name, 'Hash', 're-exported Hash';
is $foo.VAR.^name, 'Scalar', 're-exported Scalar';
is &foo.VAR.^name, 'Sub', 're-exported Sub';
is @bar.VAR.^name, 'Array', 'exported Array';
is %bar.VAR.^name, 'Hash', 'exported Hash';
is $bar.VAR.^name, 'Scalar', 'exported Scalar';
is &bar.VAR.^name, 'Sub', 'exported Sub';

# vim: expandtab shiftwidth=4
