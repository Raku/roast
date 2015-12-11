use v6;

use Test;

plan 15;

=begin pod

Tests for .^roles from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"list of roles">

{
    my role R1 { }
    my role R2 { }
    my role R3 { }
    my class C1 does R1 does R2 { }
    my class C2 is C1 does R3 { }
    
    my @roles = C2.^roles(:local);
    is +@roles,   1,  ':local returned list with correct number of roles';
    is @roles[0], R3, 'role in list was correct';
    
    @roles = C1.^roles(:local);
    is +@roles,   2,  ':local returned list with correct number of roles';
    ok (@roles[0] ~~ R1 && @roles[1] ~~ R2 || @roles[0] ~~ R2 && @roles[1] ~~ R1),
                    'roles in list were correct';
    
    ok C2.^roles ~~ Positional, '.^roles returns something Positional';
    @roles = C2.^roles();
    is +@roles,   3,  'with no args returned list with correct number of roles';
    is @roles[0], R3, 'first role in list was correct';
    ok (@roles[1] ~~ R1 && @roles[2] ~~ R2 || @roles[1] ~~ R2 && @roles[2] ~~ R1),
                    'second and third roles in list were correct';
}

{
    my role R1 {}
    my role R2 does R1 {}
    my role R3[::T] {}
    class C1 does R2 {}
    class C2 does R3[Int] {}

    sub does-names($check, @expected, $desc, *%options) {
        my @got = $check.^roles(|%options).map({ .^name });
        is @got.sort, @expected.sort, $desc;
    }

    does-names R1, < >, 'role R1 does no roles';
    does-names R2, <R1>.list, 'role R2 does one role';
    does-names C1, <R1 R2>, 'class C1 does R2 and so also R1';
    does-names C1, <R2>.list, :!transitive, 'class C1 does R2 only with :!transitive';
    does-names C2, <R3[Int]>.list, 'class C2 does R3[Int]';

    # RT #125731
    my role A { };
    my role B does A { };
    does-names B.new, <B A>, 'punned class shows transitively done roles';
    does-names B.new, <B>.list, :!transitive,
        'punned class shows immediate role only with :!transitive';
}

# vim: ft=perl6
