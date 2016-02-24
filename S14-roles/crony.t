use v6.c;

use Test;

plan 4;

# A role composed from another role.
# String and integer allocated to attributes in roles.
# Test two attributes in each role because roles with single attributes are special
# Author: Richard Hainsworth, Oct 2, 2006

# L<S14/Roles/but may be composed of other roles>

role InnerRole {
  has $.inner_role_var_1 is rw;
  has $.inner_role_var_2 is rw;
};

role OuterRole does InnerRole {
  has $.outer_role_var_1 is rw;
  has $.outer_role_var_2 is rw;
};

my $w = OuterRole.new;

$w.outer_role_var_1 = 2;
$w.outer_role_var_2 = 'red';
is $w.outer_role_var_1, 2 , "integer attribute is set in outer role" ;
is $w.outer_role_var_2, 'red', "string attribute is set in outer role" ;

$w.inner_role_var_1 = 3;
$w.inner_role_var_2 = 'dog';
is $w.inner_role_var_1, 3 , "integer attribute is set in inner role" ; 
is $w.inner_role_var_2,'dog' , "string attribute is set in inner role" ;

# vim: ft=perl6
