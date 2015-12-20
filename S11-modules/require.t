use v6;

use lib '.';
use MONKEY-SEE-NO-EVAL;

my $required-Test = (require Test <&plan &is &lives-ok &skip &todo>);

plan 17;

# RT #126100
{
    is $required-Test.gist, '(Test)', "successful require PACKAGE returns PACKAGE";
    is (require "t/spec/S11-modules/InnerModule.pm"), "t/spec/S11-modules/InnerModule.pm",
        "successful require STRING returns STRING";
}

my $staticname;
BEGIN try EVAL '$staticname = Test';
#?rakudo todo 'creation of stub package symbol NYI RT #125083'
is $staticname.gist, '(Test)', "require Test installs stub Test package at compile time";

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives-ok { require "t/spec/S11-modules/InnerModule.pm"; },
         'can load InnerModule from a path at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

my $name = 't/spec/S11-modules/InnerModule.pm';

#?rakudo todo 'variable form plus imports NYI RT #125084'
lives-ok { require $name '&bar'; },
         'can load InnerModule from a variable at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
{
    require InnerModule:file($name) <&bar>;
    is bar(), 'Inner::bar', 'can load InnerModule by name and path, with import list';
}

#RT #118407
#?rakudo skip "Trying to import from 'InnerModule', but the following symbols are missing: quux RT #118407"
{ 
    require InnerModule:file($name) <quux>;
    is quux(), 'Inner::quux', "can import quux without ampersand (&quux)";
}

# no need to do that at compile time, since require() really is run time
PROCESS::<$REPO> := CompUnit::Repository::FileSystem.new(:prefix<t/spec/packages>, :next-repo($*REPO));

# Next line is for final test.
GLOBAL::<$x> = 'still here';

lives-ok { require Fancy::Utilities; },
         'can load Fancy::Utilities at run time';
is Fancy::Utilities::lolgreet('me'),
   'O HAI ME', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
lives-ok { my $name = 'A'; require ::($name) }, 'can require with variable name';

{
    require ::('Fancy::Utilities');
    is ::('Fancy::Utilities')::('&lolgreet')('tester'), "O HAI TESTER",
       'can call subroutines in a module by name';
}

# L<S11/"Runtime Importation"/"Importing via require also installs names into the current lexical scope">

{
    require Fancy::Utilities <&allgreet>;
    is allgreet(), 'hi all', 'require with import list';
}

is GLOBAL::<$x>, 'still here', 'loading modules does not clobber GLOBAL';

# tests the combination of chdir+require
lives-ok { chdir "t/spec/packages"; require "Foo.pm"; },
         'can change directory and require a module';

# RT #115626
lives-ok { try require "THIS_FILE_HOPEFULLY_NEVER_EXISTS.pm"; },
         'requiring something non-existent does not make it segfault';

# vim: ft=perl6
