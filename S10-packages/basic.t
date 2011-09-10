use v6;

# L<S10/Packages>

use Test;

plan 53;

my regex fairly_conclusive_platform_error {:i ^\N*<<Null?>>}

my regex likely_perl6_not_found_err {:i ^\N*<<[can]?not>>\N*<<[f[i|ou]nd|located?|access'ed'?]>>}

package Empty {}
package AlsoEmpty::Nested {}

package Simple {
    enum B <a>;
    class Bar {method baz {'hi'}};
    our $forty_two = 42;
}

#?rakudo skip 'nested packages'
is Simple::Bar.new.baz, 'hi', 'class test';

#?rakudo skip 'ticket uses role; RT #62900'
{
    is  eval('~AlsoEmpty'), 'AlsoEmpty()',
        'autovivification(?) for nested packages'
}

#RT #65404'
{
    lives_ok {Empty.perl ne "tbd"}, 'test for working .perl method'
}

# change to match likely error (top of file) when passes
{
    eval_dies_ok 'Empty::no_such_sub()', 'Non-existent sub through package';
}

# Not sure whether you should be able to access something in package this way
# might change to match likely error (top of file) when passes
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
#?rakudo skip 'RT #59484'
{
    is  eval('package Simp2 {sub pkg { $?PACKAGE }}; Simp2::pkg'),
        'Simp2', 'access to $?PACKAGE variable'
}

{
    #?rakudo todo 'WHO'
    lives_ok {Simple::Bar.new.WHO}, 'some WHO implementation';
    #?rakudo skip 'ticket based only on class... RT #60446'
    is ~(Simple::Bar.new.WHO), 'Simple::Bar',
        'WHO implementation with longname';
}

#?rakudo skip 'role in package'
eval_lives_ok 'package A1 { role B1 {}; class C1 does A1::B1 {}} ',
    'can refer to role using package';

{
    eval_lives_ok '{package A2 { role B2 {}; class C2 does B2 {} }}',
        'since role is in package should not need package name';
}

{
    my $x;

    eval '$x = RT64828g; grammar RT64828g {}';
    ok  $!  ~~ Exception, 'reference to grammar before definition dies';
    ok "$!" ~~ / RT64828g /, 'error message mentions the undefined grammar';

    eval '$x = RT64828m; module RT64828m {}';
    ok  $!  ~~ Exception, 'reference to module before definition dies';
    ok "$!" ~~ / RT64828m /, 'error message mentions the undefined module';

    eval '$x = RT64828r; role RT64828r {}';
    ok  $!  ~~ Exception, 'reference to role before definition dies';
    ok "$!" ~~ / RT64828r /, 'error message mentions the undefined role';

    eval '$x = RT64828c; class RT64828c {}';
    ok  $!  ~~ Exception, 'reference to class before definition dies';
    ok "$!" ~~ / RT64828c /, 'error message mentions the undefined class';

    eval '$x = RT64828p; package RT64828p {}';
    ok  $!  ~~ Exception, 'reference to package before definition dies';
    ok "$!" ~~ / RT64828p /, 'error message mentions the undefined package';
}

#?rakudo todo 'ticket based on class(es) not package; RT #65022'
{
    eval_lives_ok '{ package C1Home { class Baz {} }; package C2Home { class Baz {} } }',
        'two different packages should be two different Baz';

    eval_lives_ok '{ package E1Home { enum EHomeE <a> }; package E2Home { role EHomeE {}; class EHomeC does E2Home::EHomeE {} } }',
        'two different packages should be two different EHomeE';        
}

# making test below todo causes trouble right now ...
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
{
    package RetOuterLex { our sub outer_lex_val { $outer_lex } };
    is eval('RetOuterLex::outer_lex_val()'), $outer_lex, 'use outer lexical'
}

our $outer_package = 19;
{
    package RetOuterPack { our sub outer_pack_val { $outer_package } };
    is  eval('RetOuterPack::outer_pack_val()'), $outer_package,
        'use outer package var';

    eval_lives_ok
        'my $outer; package ModOuterPack { $outer= 3 }; $outer',
        'Should be able to update outer package var';
}

# change tests to match likely error (top of file) when they pass (RT 64204)
{
    eval 'my $x = ::P';
    ok  ~$! !~~ /<&fairly_conclusive_platform_error>/, 
        'simple package case that should not blow platform';

    eval 'A::B';
    ok  ~$! ~~ /<&likely_perl6_not_found_err>/,
        'another simple package case that should not blow platform';
}

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

# RT #68290
{
    eval_dies_ok q[class A { sub a { say "a" }; sub a { say "a" } }],
                 'sub redefined in class dies';
    eval_dies_ok q[package P { sub p { say "p" }; sub p { say "p" } }],
                 'sub redefined in package dies';
    eval_dies_ok q[module M { sub m { say "m" }; sub m { say "m" } }],
                 'sub redefined in module dies';
    eval_dies_ok q[grammar B { token b { 'b' }; token b { 'b' } };],
                 'token redefined in grammar dies';
    #?rakudo todo 'RT 68290, redinition of method in class should die'
    eval_dies_ok q[class C { method c { say "c" }; method c { say "c" } }],
                 'method redefined in class dies';
}

{
    eval_lives_ok 'class RT64688_c1;use Test', 'use after class line';
    #?rakudo todo 'RT #64688'
    eval_lives_ok 'class RT64688_c1 { use Test }', 'use in class block';
    eval_lives_ok 'module RT64688_m1;use Test', 'use after module line';
    eval_lives_ok 'module RT64688_m2 { use Test }', 'use in module block';
    eval_lives_ok 'package RT64688_p2 { use Test }', 'use in package block';
    eval_lives_ok 'grammar RT64688_g1;use Test', 'use after grammar line';
    eval_lives_ok 'grammar RT64688_g2 { use Test }', 'use in grammar block';
    eval_lives_ok 'role RT64688_r1;use Test', 'use after role line';
    eval_lives_ok 'role RT64688_r2 { use Test }', 'use in role block';
}

{
    @*INC.unshift: 't/spec/packages';
    eval_lives_ok 'use LoadFromInsideAModule',
        'can "use" a class inside a module';
    eval_lives_ok 'use LoadFromInsideAClass',
        'can "use" a class inside a class';

    # RT #65738
    use Foo;
    use OverrideTest;
    is test_ucfirst('moin'), 'Moin',
        'overrides from one module do not affect a module that is loaded later on';
}

# also checks RT #73740
{
    eval_lives_ok 'use PM6', 'can load a module ending in .pm6';
    is eval('use PM6; pm6_works()'), 42, 'can call subs exported from .pm6 module';
}

# package Foo; is perl 5 code;
# RT #75458
{
    eval_dies_ok "package Perl5Code;\n'this is Perl 5 code'",
        'package Foo; is indicator for Perl 5 code';
}

#?rakudo todo 'RT 80856'
eval_dies_ok 'module RT80856 is not_RT80856 {}',
             'die if module "is" a nonexistent';

# vim: ft=perl6
