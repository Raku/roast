use v6;
use Test;

plan 8;

# GH#2979 Symbols are not to be exported in containerized form.

use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");

use GH2979;

is @foo.VAR.^name, 'Array', 're-exported Array';
is %foo.VAR.^name, 'Hash', 're-exported Hash';
is $foo.VAR.^name, 'Scalar', 're-exported Scalar';
is &foo.VAR.^name, 'Sub', 're-exported Sub';
is @bar.VAR.^name, 'Array', 'exported Array';
is %bar.VAR.^name, 'Hash', 'exported Hash';
is $bar.VAR.^name, 'Scalar', 'exported Scalar';
is &bar.VAR.^name, 'Sub', 'exported Sub';

# vim: ft=perl6 sw=4 expandtabs
