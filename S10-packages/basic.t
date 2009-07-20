use v6;

# L<S10/Packages>

use Test;

plan 22;

regex fairly_conclusive_platform_error {:i ^\N*<<Null?>>}

regex likely_perl6_not_found_err
    {:i ^\N*<<not>>\N*<<[f[i|ou]nd|located?|access[ed]?]>>}

package Empty {}
package AlsoEmpty::Nested {}

package Simple {
    enum B <a>;
    class Bar {method baz {'hi'}};
    our $forty_two = 42;
}

is Simple::Bar.new.baz, 'hi', 'class test';

#?rakudo todo 'ticket uses role; RT #62900'
{
    is  eval('~AlsoEmpty'), 'AlsoEmpty()',
        'autovivification(?) for nested packages'
}

#?rakudo todo 'RT #65404'
{
    lives_ok {Empty.perl ne "tbd"}, 'test for working .perl method'
}

# change to match likely error (top of file) when passes
#?rakudo todo 'RT #62970'
{
    eval_dies_ok 'Empty::no_such_sub()', 'Non-existant sub through package';
}

# Not sure whether you should be able to access something in package this way
# might change to match likely error (top of file) when passes
#?rakudo todo 'RT #63432'
{
    eval_dies_ok 'Empty.no_such_sub_or_prop',
                 'Non-existent method with package';
}

#?rakudo todo 'RT #63826'
{
    enum SimpleB <a>; # useful for fudging success
    is eval('Simple::B::a'), 0, 'enum in package'
}

# more sophisticated variants of test exist elsewhere - but seems basic ...
#?rakudo todo 'RT #59484'
{
    is  eval('package Simp2 {sub pkg { $?PACKAGE }}; Simp2::pkg'),
        'Simp2', 'access to $?PACKAGE variable'
}

#?rakudo todo 'ticket based only on class; RT #60446'
{
    lives_ok {Simple::Bar.new.WHO}, 'some WHO implementation';
    is eval('~(Simple::Bar.new.WHO)'), 'Simple::Bar',
        'WHO implementation with longname'
}

lives_ok {package A1 { role B1 {}; class C1 does A1::B1 {}} },
    'can refer to role using package';

#?rakudo todo 'ticket based on module; RT #63510'
{
    eval_lives_ok '{package A2 { role B2 {}; class C2 does B2 {} }}',
        'since role is in package should not need package name';
}

#?rakudo todo 'ticket based on class(es) not package; RT #65022'
{
    eval_lives_ok '{
        package C1Home { class Baz {} };
        package C2Home { class Baz {} }
    }', 'two different packages should be two different Baz';

    eval_lives_ok '{
        package E1Home { enum EHomeE <a> };
        package E2Home { role EHomeE {}; class EHomeC does E2Home::EHomeE {} }
    }', 'two different packages should be two different EHomeE';        
}

# making test below todo causes trouble right now ...
#?rakudo skip 'ticket based on module; RT #64876'
{
    eval_lives_ok 'package InternalCall { sub foo() { return 42 }; foo() }',
        'call of method defined in package';
}

#?rakudo todo 'RT #64606'
{
    eval_lives_ok 'package DoMap {my @a = map { $_ }, (1, 2, 3)}}',
        'map in package';
}

my $outer_lex = 17;
#?rakudo todo 'ticket used class; RT #61356'
{
    package RetOuterLex {sub outer_lex_val { $outer_lex } };
    is eval('RetOuterLex::outer_lex_val()'), $outer_lex, 'use outer lexical'
}

our $outer_package = 19;
#?rakudo todo 'ticket used class; RT #63588'
{
    package RetOuterPack {sub outer_pack_val { $outer_package } };
    is  eval('RetOuterPack::outer_pack_val()'), $outer_package,
        'use outer package var';

    eval_lives_ok
        'package ModOuterPack { $outer_package = 3 }; $outer_package',
        'Should be able to update outer package var';
}

# change tests to match likely error (top of file) when they pass
#?rakudo todo 'RT #64204'
{
    eval 'my $x = ::P';
    ok  ~$! !~~ /<fairly_conclusive_platform_error>/, 
        'simple package case that should not blow platform';

    eval 'A::B';
    ok  ~$! !~~ /<fairly_conclusive_platform_error>/,
        'another simple package case that should not blow platform';
}

#?rakudo skip 'RT #64606'
eval_lives_ok q' module MapTester { (1, 2, 3).map: { $_ } } ', 
              'map works in a module (RT #64606)';

# used to be a  pugs regression
{
    BEGIN { @*INC.push: 't/spec/packages' }
    use ArrayInit;
    my $first_call = array_init();
    is array_init(), $first_call,
       'array initialization works fine in imported subs';
}

# vim: ft=perl6
