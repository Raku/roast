use v6;

use Test;

plan 14;

# Checking Junctions' Associativeness
# TODO: need smartlink

sub jv(Object $j) {
    return $j.values.sort.join(' ');
    

}

# L<S03/"Junctive operators">
# L<S09/"Junctions">
{

    is('1 2 3', jv((1|2)|3), "Left-associative any, | operator");
    is('1 2 3', jv(1|(2|3)), "Right-associative any, | operator");

    is('1 2 3', jv(any(any(1,2),3)), "Left-associative any()");
    is('1 2 3', jv(any(1,any(2,3))), "Right-associative any()");

    is('1 2 3', jv((1&2)&3), "Left-associative all, & operator");
    is('1 2 3', jv(1&(2&3)), "Right-associative all, & operator");

    is('1 2 3', jv(all(all(1,2),3)), "Left-associative all()");
    is('1 2 3', jv(all(1,all(2,3))), "Right-associative all()");

    isnt('1 2 3', jv((1^2)^3), "Left-associative one, ^ operator");
    isnt('1 2 3', jv(1^(2^3)), "Right-associative one, ^ operator");

    isnt('1 2 3', jv(one(one(1,2),3)), "Left-associative one()");
    isnt('1 2 3', jv(one(1,one(2,3))), "Right-associative one()");

    is('1 2 3', jv(none(none(1,2),3)), "Left-associative none()");
    is('1 2 3', jv(none(1,none(2,3))), "Right-associative none()");

}

# vim: ft=perl6
