use v6;
use Test;

use lib $?FILE.IO.parent(2).add("packages/Export_Pack/lib");

plan 2;

{
    need Export_PackA;

    is Export_PackA::exported_foo(),
       42, 'Can "need" a module';
    throws-like 'exported_foo()',
        X::Undeclared::Symbols, '"need" did not import the default export list';
}

# vim: expandtab shiftwidth=4
