use v6;

# L<S10/Packages>

use Test;

plan 81;

my regex fairly_conclusive_platform_error {:i ^\N* <<Null?>>}

my regex likely_perl6_not_found_err {:i ^\N* <<'can'?not>> \N* <<[f[i|ou]nd|located?|access'ed'?]>> }

package ThisEmpty {}
package AlsoEmpty::Nested {}

package Simple {
    enum B <a>;
    class Bar {method baz {'hi'}};
    our $forty_two = 42;
}

is Simple::Bar.new.baz, 'hi', 'class test';

#?niecza skip 'AlsoEmpty undeclared (ie no autovivification, I guess)'
{
    is AlsoEmpty.gist, '(AlsoEmpty)',
        'autovivification(?) for nested packages'
}

# RT #65404
#?niecza todo
{
    lives-ok {ThisEmpty.perl ne "tbd"}, 'test for working .perl method'
}

# change to match likely error (top of file) when passes
{
    throws-like 'ThisEmpty::no_such_sub()', Exception, 'Non-existent sub through package';
}

# Not sure whether you should be able to access something in package this way
# might change to match likely error (top of file) when passes
{
    throws-like 'ThisEmpty.no_such_sub_or_prop', X::Method::NotFound,
        'Non-existent method with package';
}

{
    enum SimpleB <a>; # useful for fudging success
    is Simple::B::a.Numeric, 0, 'enum in package'
}

# more sophisticated variants of test exist elsewhere - but seems basic ...
#?rakudo skip 'RT #59484'
#?niecza skip 'Unable to find lexical $?PACKAGE in pkg'
{
    is  EVAL('package Simp2 {sub pkg { $?PACKAGE }}; Simp2::pkg'),
        'Simp2', 'access to $?PACKAGE variable'
}

{
    lives-ok {Simple::Bar.new.WHO}, 'some WHO implementation';
    #?rakudo todo 'ticket based only on class... RT #60446'
    #?niecza todo
    is ~(Simple::Bar.new.WHO), 'Simple::Bar',
        'WHO implementation with longname';
}

eval-lives-ok 'package A1 { role B1 {}; class C1 does A1::B1 {}} ',
    'can refer to role using package';

{
    eval-lives-ok '{package A2 { role B2 {}; class C2 does B2 {} }}',
        'since role is in package should not need package name';
}

#?niecza skip 'Exception not defined'
{
    my $x;

    try {  EVAL '$x = RT64828g; grammar RT64828g {}' };
    ok  $!  ~~ Exception, 'reference to grammar before definition dies';
    ok "$!" ~~ / RT64828g /, 'error message mentions the undefined grammar';

    try { EVAL '$x = RT64828m; module RT64828m {}' };
    ok  $!  ~~ Exception, 'reference to module before definition dies';
    ok "$!" ~~ / RT64828m /, 'error message mentions the undefined module';

    try { EVAL '$x = RT64828r; role RT64828r {}' };
    ok  $!  ~~ Exception, 'reference to role before definition dies';
    ok "$!" ~~ / RT64828r /, 'error message mentions the undefined role';

    try { EVAL '$x = RT64828c; class RT64828c {}' };
    ok  $!  ~~ Exception, 'reference to class before definition dies';
    ok "$!" ~~ / RT64828c /, 'error message mentions the undefined class';

    try { EVAL '$x = RT64828p; package RT64828p {}' };
    ok  $!  ~~ Exception, 'reference to package before definition dies';
    ok "$!" ~~ / RT64828p /, 'error message mentions the undefined package';
}

#RT #65022
{
    eval-lives-ok '{ package C1Home { class Baz {} }; package C2Home { class Baz {} } }',
        'two different packages should be two different Baz';

    eval-lives-ok '{ package E1Home { enum EHomeE <a> }; package E2Home { role EHomeE {}; class EHomeC does E2Home::EHomeE {} } }',
        'two different packages should be two different EHomeE';        
}

# making test below todo causes trouble right now ...
{
    eval-lives-ok 'package InternalCall { sub foo() { return 42 }; foo() }',
        'call of method defined in package';
}

#?niecza todo
{
    eval-lives-ok 'package DoMap {my @a = map { $_ }, (1, 2, 3)}',
        'map in package';
}

my $outer_lex = 17;
{
    package RetOuterLex { our sub outer_lex_val { $outer_lex } };
    is EVAL('RetOuterLex::outer_lex_val()'), $outer_lex, 'use outer lexical'
}

our $outer_package = 19;
{
    package RetOuterPack { our sub outer_pack_val { $outer_package } };
    is  EVAL('RetOuterPack::outer_pack_val()'), $outer_package,
        'use outer package var';

    eval-lives-ok
        'my $outer; package ModOuterPack { $outer= 3 }; $outer',
        'Should be able to update outer package var';
}

# change tests to match likely error (top of file) when they pass (RT #64204)
{
    try { EVAL 'my $x = ::P' };
    ok  ~$! !~~ /<&fairly_conclusive_platform_error>/, 
        'simple package case that should not blow platform';

    try { EVAL 'A::B' };
    #?niecza todo
    ok  ~$! ~~ /<&likely_perl6_not_found_err>/,
        'another simple package case that should not blow platform';
}

eval-lives-ok q' module MapTester { (1, 2, 3).map: { $_ } } ', 
              'map works in a module (RT #64606)';

{
    use lib 't/spec/packages';
    use ArrayInit;
    my $first_call = array_init();
    is array_init(), $first_call,
       'array initialization works fine in imported subs';
}

# RT #68290
{
    throws-like q[class A { sub a { say "a" }; sub a { say "a" } }],
        X::Redeclaration, 'sub redefined in class dies';
    throws-like q[package P { sub p { say "p" }; sub p { say "p" } }],
        X::Redeclaration, 'sub redefined in package dies';
    throws-like q[module M { sub m { say "m" }; sub m { say "m" } }],
        X::Redeclaration, 'sub redefined in module dies';
    throws-like q[grammar B { token b { 'b' }; token b { 'b' } };],
        Exception, 'token redefined in grammar dies';
    throws-like q[class C { method c { say "c" }; method c { say "c" } }],
        Exception, 'method redefined in class dies';
}

{
    eval-lives-ok 'unit class RT64688_c1;use Test', 'use after class line';
    eval-lives-ok 'class RT64688_d1 { use Test }', 'use in class block';
    eval-lives-ok 'unit module RT64688_m1;use Test', 'use after module line';
    eval-lives-ok 'module RT64688_m2 { use Test }', 'use in module block';
    eval-lives-ok 'package RT64688_p2 { use Test }', 'use in package block';
    eval-lives-ok 'unit grammar RT64688_g1;use Test', 'use after grammar line';
    eval-lives-ok 'grammar RT64688_g2 { use Test }', 'use in grammar block';
    eval-lives-ok 'unit role RT64688_r1;use Test', 'use after role line';
    eval-lives-ok 'role RT64688_r2 { use Test }', 'use in role block';
}

#?niecza skip 'Export tags NYI'
{
    @*INC.unshift: 't/spec/packages';
    eval-lives-ok 'use LoadFromInsideAModule',
        'can "use" a class inside a module';
    eval-lives-ok 'use LoadFromInsideAClass',
        'can "use" a class inside a class';

    # RT #65738
    use Foo;
    use OverrideTest;
    is test_tc('moin'), 'Moin',
        'overrides from one module do not affect a module that is loaded later on';
}

# also checks RT #73740
#?niecza skip 'Unable to locate module PM6 in @path'
{
    eval-lives-ok 'use PM6', 'can load a module ending in .pm6';
    is EVAL('use PM6; pm6_works()'), 42, 'can call subs exported from .pm6 module';
}

# package Foo; is perl 5 code;
# RT #75458
{
    throws-like "package Perl5Code;\n'this is Perl 5 code'", Exception,
        'package Foo; is indicator for Perl 5 code';
}

#RT #80856
throws-like 'module RT80856 is not_RT80856 {}', X::Inheritance::UnknownParent,
    'die if module "is" a nonexistent';

{
    isa-ok Int.WHO, Stash, 'SomeType.WHO is a Stash';
    is Int.WHO.WHAT.gist, '(Stash)', 'and Stash correctly .gist-ifies';
}


# RT #98856
#?niecza todo
eval-lives-ok q[
    package NewFoo { }
    class   NewFoo { }
], 'can re-declare a class over a package of the same name';

# RT #73328
throws-like q[
    my package A {
        package B;
        1+1;
    }
], X::UnitScope::TooLate, 'Too late for semicolon form';

# RT #74592
#?niecza skip 'Nominal type check failed in binding $l in infix:<===>; got My74592, needed Any'
{
    my $p = my package My74592 { };
    ok $p === My74592, 'return value of "my" package declaration';

    $p = our package Our74592 { };
    ok $p === Our74592, 'return value of "Our" package declaration';
}

# RT #121253
{
    use lib 't/spec/packages';
    use Bar;
    use Baz;
    is Foo.foo, 'foo', 'can use two packages that both use the same third package'
}

# RT #79464
{
    lives-ok {Foo1::bar(); module Foo1 { our $x = 42; our sub bar() { $x.defined } }}, 'accessing module variable from within sub called from outside the module';
}

# RT #76606
{
    use lib 't/spec/packages';
    lives-ok { use RT76606 },
        'autovivification works with nested "use" directives (import from two nested files)';
}

# RT #120561
{
    lives-ok { use lib "$?FILE.IO.dirname()/t/spec/packages" },
        'no Null PMC access with "use lib $double_quoted_string"';
}

# RT #118361
{
    class Pub::Bar::Tap { }
    is Pub::Bar::Tap.gist, '(Tap)', 'type object of class gists to short name in parens';
    is Pub::Bar::Tap.WHO.gist, 'Pub::Bar::Tap', '.WHO of class gists to long name';
    is Pub::Bar::Tap.WHO.Str, 'Pub::Bar::Tap', '.WHO of class stringifies to long name';

    module Cafe {
        module Kitchen {
            module Blowtorch { }
        }
    }
    is Cafe::Kitchen::Blowtorch.gist, '(Blowtorch)',
        'type object of nested module definition gists to short name in parens';
    is Cafe::Kitchen::Blowtorch.WHO.gist, 'Cafe::Kitchen::Blowtorch',
        '.WHO of nested module definition gists to long name';
    is Cafe::Kitchen::Blowtorch.WHO.Str, 'Cafe::Kitchen::Blowtorch',
        '.WHO of nested module definition stringifies to long name';

    role Metal::Djent { }
    is Metal::Djent.gist, '(Djent)', 'type object of role gists to short name in parens';
    is Metal::Djent.WHO.gist, 'Metal::Djent', '.WHO of role gists to long name';
    is Metal::Djent.WHO.Str, 'Metal::Djent', '.WHO of role stringifies to long name';

    package Castle {
        role Princess { }
    }
    is Castle::Princess.gist, '(Princess)',
        'type object of nested role definition gists to short name in parens';
    is Castle::Princess.WHO.gist, 'Castle::Princess',
        '.WHO of nested role definition gists to long name';
    is Castle::Princess.WHO.Str, 'Castle::Princess',
        '.WHO of nested role definition stringifies to long name';

    package Tour {
        subset AllInclusive of Any;
    }
    is Tour::AllInclusive.gist, '(AllInclusive)', 'type object of subset gists to short name in parens';
    is Tour::AllInclusive.WHO.gist, 'Tour::AllInclusive', '.WHO of subset gists to long name';
    is Tour::AllInclusive.WHO.Str, 'Tour::AllInclusive', '.WHO of subset stringifies to long name';

    subset Digestive::Chocolate of Any;
    is Digestive::Chocolate.gist, '(Chocolate)',
        'type object of nested subset definition gists to short name in parens';
    is Digestive::Chocolate.WHO.gist, 'Digestive::Chocolate',
        '.WHO of nested subset definition gists to long name';
    is Digestive::Chocolate.WHO.Str, 'Digestive::Chocolate',
        '.WHO of nested subset definition stringifies to long name';
}

# vim: ft=perl6
