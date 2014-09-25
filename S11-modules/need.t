use v6;

use Test;
plan 2;

use lib '.';

{
    need t::spec::packages::Export_PackA;

    is t::spec::packages::Export_PackA::exported_foo(),
       42, 'Can "need" a module';
    eval_dies_ok 'exported_foo()',
                 '"need" did not import the default export list';
}

# vim: ft=perl6
