use v6;

use lib $?FILE.IO.parent(2);

use Test;
plan 2;

{
    need packages::Export_PackA;

    is packages::Export_PackA::exported_foo(),
       42, 'Can "need" a module';
    throws-like 'exported_foo()',
        X::Undeclared::Symbols, '"need" did not import the default export list';
}

# vim: ft=perl6
