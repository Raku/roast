use v6;

my $required-Test = (require Test <&plan &is &lives-ok &skip &todo
                                  &nok &throws-like &eval-lives-ok &ok>);

############################################################################
# Note: do not add any additional `use` lib or use any additional modules.
# The tests in this file require a specific environment in this area for
# them to test the functionality correctly. Place your tests in another file,
# if you need to load any other modules.
#############################################################################

use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");
use lib $?FILE.IO.parent(2).add("packages/Cool/lib");

use MONKEY-SEE-NO-EVAL;

plan 58;

# https://github.com/Raku/old-issue-tracker/issues/4548
{
    is $required-Test.gist, '(Test)', "successful require PACKAGE returns PACKAGE";
    is (require "InnerModule.pm6"), "InnerModule.pm6",
        "successful require STRING returns STRING";
}

my $staticname;
BEGIN try EVAL '$staticname = Test';
is $staticname.gist, '(Test)', "require Test installs stub Test package at compile time";

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives-ok {
    require "InnerModule.pm6";
    is ::('InnerModule').WHO<EXPORT>.WHO<DEFAULT>.WHO<&bar>(), 'Inner::bar', "can introspect EXPORT of require'd package";
    is ::('InnerModule').WHO<&oursub>(),"Inner::oursub","can call our-sub from required module";
}, 'can load InnerModule from a path at run time';


my $name = 'InnerModule.pm6';

# https://github.com/Raku/old-issue-tracker/issues/4208
{
    require $name '&bar';
    is bar(),'Inner::bar','can load InnerModule from a variable at run time';
}

# https://github.com/Raku/old-issue-tracker/issues/5034
{
    require NoModule <&bar>;
    my $result = bar();
    is $ = bar(),'NoModule::bar','can import symbol not inside module';
}

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
{
    require InnerModule:file($name) <&bar>;
    is bar(), 'Inner::bar', 'can load InnerModule by name and path, with import list';
}
nok ::('&bar'), ｢&bar didn't leak to outer scope｣;

# https://github.com/Raku/old-issue-tracker/issues/3162
throws-like { require InnerModule:file($name) <quux> },
    X::Import::MissingSymbols,
'&-less import of sub does not produce `Null PMC access` error';

{
    my $class-path = $?FILE.IO.parent(2).add('packages/S11-modules/lib/InnerClass.pm6').absolute;
    require TestStub:file($class-path);
    my @keys = TestStub::.keys;
    is @keys.grep('InnerClass').elems, 1, 'can load InnerClass.pm6 class into specified stub';
    ok TestStub::<InnerClass>.test1 eq 'test1', 'TestStub::<InnerClass>.test1 is callable';

    is @keys.grep('InnerClassTwo').elems, 1, 'can load multiple classes from InnerClass.pm6 class into specified stub';
    ok TestStub::<InnerClassTwo>.test2 eq 'test2', 'TestStub::<InnerClass>.test1 is callable';
}

# no need to do that at compile time, since require() really is run time
PROCESS::<$REPO> := CompUnit::Repository::FileSystem.new(:next-repo($*REPO),
    :prefix($?FILE.IO.parent(2).child('packages/Fancy/lib').relative));

# Next line is for final test.
GLOBAL::<$x> = 'still here';

lives-ok {
    require Fancy::Utilities;
    is Fancy::Utilities::lolgreet('me'),
       'O HAI ME', 'can call our-sub from required module';
}, 'can load Fancy::Utilities at run time';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
lives-ok {
    use lib $?FILE.IO.parent(2).add("packages/AandB/lib");
    my $name = 'A';
    require ::($name)
}, 'can require with variable name';

{
    my $res = (require ::('Fancy::Utilities'));
    is ::('Fancy::Utilities')::('&lolgreet')('tester'), "O HAI TESTER",
    'can call subroutines in a module by name';
    ok $res ~~ ::('Fancy::Utilities'),'package returned from Fancy::Utilities matches the indirect lookup';
}

# L<S11/"Runtime Importation"/"Importing via require also installs names into the current lexical scope">

{
    require Fancy::Utilities <&allgreet>;
    is allgreet(), 'hi all', 'require with import list';
}

is GLOBAL::<$x>, 'still here', 'loading modules does not clobber GLOBAL';

# tests the combination of chdir+require
my $cwd = $*CWD;
lives-ok { chdir $?FILE.IO.parent(2).child('packages/FooBarBaz/lib'); require "Foo.pm6"; },
         'can change directory and require a module';
chdir $cwd;

# https://github.com/Raku/old-issue-tracker/issues/2966
lives-ok { try require "THIS_FILE_HOPEFULLY_NEVER_EXISTS.pm6"; },
         'requiring something non-existent does not make it segfault';


throws-like { require Fancy::Utilities <&aint-there> },
X::Import::MissingSymbols,'throws correct exception';

eval-lives-ok q|BEGIN require Fancy::Utilities;|, 'require works at BEGIN';

eval-lives-ok q|BEGIN require Fancy::Utilities <&allgreet>;|,'require can import at BEGIN';

{
        require "GlobalOuter.pm6";
        nok ::('GlobalOuter') ~~ Failure, "got outer symbol";
        ok  ::('GlobalOuter').load, "call method that causes a require";
        ok ::('GlobalInner') ~~ Failure, "Did not find inner symbol";
}

# Test that symbols under a core package namespace (Cool::) are merged.
# see https://github.com/rakudo/rakudo/pull/714, WRT IO::Socket::SSL
{
    my $res = (require Cool::Utils);
    nok ::('Cool::Utils') ~~ Failure,'Cool::Utils has been merged';
    is $res,::('Cool::Utils'), 'Cool::Utils was returned';
}

{
     require Cool::Utils;
     {
         require Cool::Beans;
         require Cool::Cat;
         require Cool::Cat::Goes::Splat;
         for <Utils Beans Cat>.kv -> $i,$sym {
             #?rakudo.jvm todo 'only test for Cool::Cat passes in this loop'
             ok Cool::{$sym}:exists,"{$i+1}. multiple requires with top level package already defined";
         }
         #?rakudo.jvm 2 skip 'You cannot create an instance of this type'
         is Cool::Cat.new.meow,'meow','class in required package';
         is Cool::Cat::Goes::Splat.new.meow,'splat',"class in long required package name";
     }
}

# https://github.com/Raku/old-issue-tracker/issues/6179
#?rakudo.jvm skip 'R#3158'
{
    require ::('SetConst');
    ok ::('SetConst::X') eqv set(<x y>),
        'require class with `Set` constant';
}

# GH #2983
{
    require GH2983 <R-GH2983 C-GH2983 C2983 $question>;

    ok ::('R-GH2983') ~~ R-GH2983, "role imported as itself";
    ok R-GH2983.HOW ~~ Metamodel::ParametricRoleGroupHOW, "role's metaclass is ParametricRoleGroupHOW";
    nok R-GH2983.VAR ~~ Scalar, "role is not containerized";

    ok ::('C-GH2983') ~~ C-GH2983, "class imported as itself";
    ok C-GH2983.HOW ~~ Metamodel::ClassHOW, "class' metaclass is ClassHOW";
    nok C-GH2983.VAR ~~ Scalar, "class is not containerized";

    is C2983, 42, "constant is imported";
    ok C2983.VAR ~~ Int, "constant is not containerized";

    is $question, "The Ultimate Question of Life, the Universe, and Everything", "a variable is imported ok";
    ok $question.VAR ~~ Scalar, "the variable is containerized";
}
{
    require ("GH2983.pm6") <R-GH2983 C-GH2983 C2983 $question>;

    ok ::('R-GH2983') ~~ R-GH2983, "role imported as itself";
    ok R-GH2983.HOW ~~ Metamodel::ParametricRoleGroupHOW, "role's metaclass is ParametricRoleGroupHOW";
    nok R-GH2983.VAR ~~ Scalar, "role is not containerized";

    ok ::('C-GH2983') ~~ C-GH2983, "class imported as itself";
    ok C-GH2983.HOW ~~ Metamodel::ClassHOW, "class' metaclass is ClassHOW";
    nok C-GH2983.VAR ~~ Scalar, "class is not containerized";

    is C2983, 42, "constant is imported";
    ok C2983.VAR ~~ Int, "constant is not containerized";

    is $question, "The Ultimate Question of Life, the Universe, and Everything", "a variable is imported ok";
    ok $question.VAR ~~ Scalar, "the variable is containerized";
}

# vim: expandtab shiftwidth=4
