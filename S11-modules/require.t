use v6;

use lib ".", $?FILE.IO.parent.child("lib").Str;

use MONKEY-SEE-NO-EVAL;

my $required-Test = (require Test <&plan &is &lives-ok &skip &todo
                                  &nok &throws-like &eval-lives-ok &ok>);
plan 34;

# RT #126100
{
    is $required-Test.gist, '(Test)', "successful require PACKAGE returns PACKAGE";
    is (require "t/spec/S11-modules/InnerModule.pm"), "t/spec/S11-modules/InnerModule.pm",
        "successful require STRING returns STRING";
}

my $staticname;
BEGIN try EVAL '$staticname = Test';
is $staticname.gist, '(Test)', "require Test installs stub Test package at compile time";

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives-ok {
    require "t/spec/S11-modules/InnerModule.pm";
    is ::('InnerModule').WHO<EXPORT>.WHO<DEFAULT>.WHO<&bar>(), 'Inner::bar', "can introspect EXPORT of require'd package";
    is ::('InnerModule').WHO<&oursub>(),"Inner::oursub","can call our-sub from required module";
}, 'can load InnerModule from a path at run time';


my $name = 't/spec/S11-modules/InnerModule.pm';

# RT #125084
{
    require $name '&bar';
    is bar(),'Inner::bar','can load InnerModule from a variable at run time';
}

# RT #127233
{
    require t::spec::S11-modules::NoModule <&bar>;
    is bar(),'NoModule::bar','can import symbol not inside module';
}

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
{
    require InnerModule:file($name) <&bar>;
    is bar(), 'Inner::bar', 'can load InnerModule by name and path, with import list';
}

#RT #118407
throws-like { require InnerModule:file($name) <quux> },
    X::Import::MissingSymbols,
'&-less import of sub does not produce `Null PMC access` error';

# no need to do that at compile time, since require() really is run time
PROCESS::<$REPO> := CompUnit::Repository::FileSystem.new(:prefix<t/spec/packages>, :next-repo($*REPO));

# Next line is for final test.
GLOBAL::<$x> = 'still here';

lives-ok {
    require Fancy::Utilities;
    is Fancy::Utilities::lolgreet('me'),
       'O HAI ME', 'can call our-sub from required module';
}, 'can load Fancy::Utilities at run time';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
lives-ok { my $name = 'A'; require ::($name) }, 'can require with variable name';

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
lives-ok { chdir "t/spec/packages"; require "Foo.pm"; },
         'can change directory and require a module';
chdir $cwd;

# RT #115626
lives-ok { try require "THIS_FILE_HOPEFULLY_NEVER_EXISTS.pm"; },
         'requiring something non-existent does not make it segfault';


throws-like { require Fancy::Utilities <&aint-there> },
X::Import::MissingSymbols,'throws correct exception';

eval-lives-ok q|BEGIN require Fancy::Utilities;|, 'require works at BEGIN';

eval-lives-ok q|BEGIN require Fancy::Utilities <&allgreet>;|,'require can import at BEGIN';

nok ::('&bar'),"bar didn't leak";

{
        require "t/spec/S11-modules/GlobalOuter.pm";
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

# RT #131112
lives-ok {require ::("t::spec::S11-modules::SetConst") }, "require class with set constant";

# vim: ft=perl6
