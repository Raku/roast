use v6;

use Test;

use lib $?FILE.IO.parent(2).add("packages/PackageTest/lib");

# test that packages work.  Note that the correspondance between type
# objects as obtained via the ::() syntax and packages is only hinted
# at in L<S10/Packages/or use the sigil-like>
plan 24;

# 4 different ways to be imported
# L<S10/Packages/A bare>
{
    package Test1 {
        our sub ns  { "Test1" }
        our sub pkg { $?PACKAGE }
        our sub test1_export is export { "export yourself!" }
    }
    package Test2 {
        our sub ns { "Test2" }
        our sub pkg { $?PACKAGE }
        our $scalar = 42;
    }
    package Test3 {
        our sub pkg { $?PACKAGE }
    }
}

use PackageTest;

# test that all the functions are in the right place

# sanity test
# L<S10/Packages/package for Perl>
is($?PACKAGE.^name, "GLOBAL", 'The Main $?PACKAGE was not broken by any declarations');

# block level
is(Test1::ns, "Test1", "block-level package declarations");
cmp-ok(Test1::pkg, &infix:<===>, ::Test1, 'block-level $?PACKAGE var');
dies-ok { EVAL 'test1_export' }, "export was not imported implicitly";

# declared packages
is(Test2::ns, "Test2", "declared package");
cmp-ok(Test2::pkg, &infix:<===>, ::Test2, 'declared package $?PACKAGE');

# string EVAL'ed packages
is(Test3::pkg, ::Test3, 'EVAL\'ed package $?PACKAGE');
cmp-ok(Test3::pkg, &infix:<===>, ::Test3, 'EVAL\'ed package type object');

# this one came from t/packages/Test.pm6
is(PackageTest::ns, "PackageTest", "loaded package");
cmp-ok(PackageTest::pkg, &infix:<===>, PackageTest, 'loaded package $?PACKAGE object');
my $x;
lives-ok { $x = test_export() }, "export was imported successfully";
is($x, "party island", "exported OK");

# exports
dies-ok { ::("&ns")() }, "no ns() leaked";

# now the lexical / file level packages...
my $pkg;
dies-ok  { $pkg = Our::Package::pkg },
    "Can't see `our' packages out of scope";
lives-ok { $pkg = PackageTest::get_our_pkg() },
    "Package in scope can see `our' package declarations";
is($pkg, PackageTest::Our::Package, 'correct $?PACKAGE');
ok(!($pkg === ::('Package::Our::Package')),
   'not the same as global type object');

# oh no, how do we get to that object, then?
# perhaps %PackageTest::<Our::Package> ?

dies-ok { $pkg = PackageTest::cant_see_pkg() },
    "can't see package declared out of scope";
lives-ok { $pkg = PackageTest::my_pkg() },
    "can see package declared in same scope";
is($pkg.^name, 'PackageTest::My::Package', 'correct $?PACKAGE');
ok($pkg !=== ::('PackageTest::My::Package'), 'not the same as global type object');

# Check temporization of variables in external packages
{
    # Use try because EVAL throws if parse fails.
    ok(my $rval = try { EVAL('temp $Test2::scalar; ++$Test2::scalar') }, "parse for temp package vars");
    with $rval {
        is $rval, 43, "scope returns value of a modified temp scalar";
    }
    else {
        skip "can't test for value because scope compile failed";
    }
    is($Test2::scalar, 42, 'temporization of external package variables');
}

# vim: expandtab shiftwidth=4
