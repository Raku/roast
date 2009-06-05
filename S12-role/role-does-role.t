use v6;

use Test;
plan 1;

role A {
}

ok A ~~ Role, 'a role does the Role type';
