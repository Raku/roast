use v6;

use Test;

=begin description

=head1 indirect object notation call tests

These tests are the testing for "Method" section of Synopsis 12

L<S12/Methods/Indirect object notation now requires a colon after the invocant if there are no arguments>

=end description

plan 28;


##### Without arguments
class T1
{
    method a
    {
        'test';
    }
}

{
    my T1 $o .= new;
    ok( "Still alive after new" );

    is( $o.a(), 'test', "The indirect object notation call without argument 1" );
#?rakudo skip 'unimpl parse error near $o:'
    is( (a $o:), 'test', "The indirect object notation call without arguments 2" );
}

##### With arguments
class T2
{
    method a( $x )
    {
        $x;
    }
}

{
    my T2 $o .= new;
    ok( "Still alive after new" );
    my $seed = 1000.rand;
    is( $o.a( $seed ), $seed, "The indirect object notation call with argument 1" );
#?rakudo skip 'unimpl parse error near $o:'
    is( (a $o: $seed), $seed, "The indirect object notation call with arguments 2" );
    my $name = 'a';
    eval_dies_ok('$name $o: $seed', 'Indirect object notation and indirect method calls cannot be combined');
}


# L<S12/Methods/"There are several forms of indirection for the method name">

{
    class A {
        method abc { 'abc' };
        method bcd { 'bcd' };
    }
    my $o = A.new();

    is $o."abc",    'abc',   'calling method with $object."methodname"';
    my $bc = 'bc';
    is $o."a$bc",   'abc',  'calling method with $object."method$name"';
    is $o."{$bc}d", 'bcd',  'calling method with $object."method$name"';


    my $meth = method { self.abc ~ self.bcd };
    is $o.$meth, 'abcbcd',   'calling method with $object.$methodref';

    my $m2 = method { .abc };
    #?rakudo skip 'RT #61106'
    is $o.$m2,   'abc',      '$object.$methodref where the invocant is passed as $_';
}

# L<S12/Methods/"$obj.@candidates(1,2,3)">

#?rakudo skip 'method closures, $obj.@candidates'
{
    my ($m1, $m2, $m3, $m4);
    my $called = 0;
    class T3 {
        has $.x;
        has $.y;

        $m1 = method ()         { "$.x|$.y"; $called++ };
        $m2 = method ($a)       { "$.x|$a" ; $called++ };
        $m3 = method ($a, $b)   { "$a|$b"  ; $called++ };
        $m4 = method ()         { $called++; nextwith; };
    }
    my @c = ($m1, $m2, $m3);
    my $o = T3.new(:x<p>, :y<q>);
    
    is $o.@c(),         'p|q', 'found the correct candidate (with zero args)';
    is $called,         1,     'called only one method per dispatch';
    is $o.@c('r'),      'p|r', 'found the correct candidate (with one arg )';
    is $called,         2,     'called only one method per dispatch';
    is $o.@c('r', 's'), 'r|s', 'found the correct candidate (with two args )';
    is $called,         3,     'called only one method per dispatch';
    @c.unshift: $m4;
    is $o.@c(),         'p|q', 're-dispatch with nextwith worked';
    is $called,         5,     'called both methods';
    dies_ok { $o.@c(1, 2, 3, 4) }, 'no dispatch -> fail';
    is $called,         3,     'no method called';
}

# L<S12/Methods/"other form of indirection relies on the fact">
#?rakudo skip '$obj.infix:<+>'
{
    is 1.infix:<+>(2),      3,      'Can call $obj.infix:<+>';
    my $op = '*';
    is 2.infix:{$op}(3),    6,      'can call $obj.infix:{$op}';
    is 2.infix:{'*'}(4),    8,      'can call $obj.infix:{"*"}';
    is 2.:<+>(7),           9,      'short form also works';
    my $x = 3;
    is $x.:<++>,            4,      '.:<++> defaults to prefix';
    is $x,                  4,      '... and it changed the variable';
}

# vim: ft=perl6
