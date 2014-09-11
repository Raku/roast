use v6;

my $istrue = (require Test <&plan &is &lives_ok &skip &todo>);

plan 15;

is $istrue, True, "successful require returns True";

my $staticname;
BEGIN try EVAL '$staticname = Test';
#?rakudo todo 'creation of stub package symbol NYI'
is $staticname.gist, '(Test)', "require Test installs stub Test package at compile time";

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives_ok { require "t/spec/S11-modules/InnerModule.pm"; },
         'can load InnerModule from a path at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

my $name = 't/spec/S11-modules/InnerModule.pm';

#?rakudo todo 'variable form plus imports NYI'
lives_ok { require $name '&bar'; },
         'can load InnerModule from a variable at run time';
is GLOBAL::InnerModule::EXPORT::DEFAULT::<&bar>(), 'Inner::bar', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
{
    require InnerModule:file($name) <&bar>;
    is bar(), 'Inner::bar', 'can load InnerModule by name and path, with import list';
}

#RT #118407
#?rakudo skip "Trying to import from 'InnerModule', but the following symbols are missing: quux"
{ 
    require InnerModule:file($name) <quux>;
    is quux(), 'Inner::quux', "can import quux without ampersand (&quux)";
}

# no need to do that at compile time, since require() really is run time
@*INC.unshift: 't/spec/packages';

# Next line is for final test.
GLOBAL::<$x> = 'still here';

lives_ok { require Fancy::Utilities; },
         'can load Fancy::Utilities at run time';
is Fancy::Utilities::lolgreet('me'),
   'O HAI ME', 'can call our-sub from required module';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
lives_ok { my $name = 'A'; require ::($name) }, 'can require with variable name';

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
lives_ok { chdir "t/spec/packages"; require "Foo.pm"; },
         'can change directory and require a module';

# vim: ft=perl6
