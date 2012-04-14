use v6;

use Test;

plan 141;

# I'm using semi-random nouns for variable names since I'm tired of foo/bar/baz and alpha/beta/...

# L<S02/Names/>
# syn r14552

#?rakudo skip 'package variable autovivification'
#?niecza skip 'Undeclared name: Terrain::'
{
    my $mountain = 'Hill';
    $Terrain::mountain  = 108;
    $Terrain::Hill::mountain = 1024;
    our $river = 'Terrain::Hill';
    is($mountain, 'Hill', 'basic variable name');
    is($Terrain::mountain, 108, 'variable name with package');
    is(Terrain::<$mountain>, 108, 'variable name with sigil not in front of package');
    is($Terrain::Hill::mountain, 1024, 'variable name with 2 deep package');
    is(Terrain::Hill::<$mountain>, 1024, 'varaible name with sigil not in front of 2 package levels deep');
    is($Terrain::($mountain)::mountain, 1024, 'variable name with a package name partially given by a variable ');
    is($::($river)::mountain, 1024, 'variable name with package name completely given by variable');
}

{
    my $bear = 2.16;
    is($bear,       2.16, 'simple variable lookup');
    #?niecza todo
    #?rakudo skip 'this kind of lookup NYI'
    is($::{'bear'}, 2.16, 'variable lookup using $::{\'foo\'}');
    is(::{'$bear'}, 2.16, 'variable lookup using ::{\'$foo\'}');
    #?niecza todo
    #?rakudo skip 'this kind of lookup NYI'
    is($::<bear>,   2.16, 'variable lookup using $::<foo>');
    is(::<$bear>,   2.16, 'variable lookup using ::<$foo>');
}

#?rakudo skip '::{ } package lookup NYI'
#?niecza skip 'Postconstraints, and shapes on variable declarators NYI'
{
    my $::<!@#$> =  2.22;
    is($::{'!@#$'}, 2.22, 'variable lookup using $::{\'symbols\'}');
    is(::{'$!@#$'}, 2.22, 'variable lookup using ::{\'$symbols\'}');
    is($::<!@#$>,   2.22, 'variable lookup using $::<symbols>');
    is(::<$!@#$>,   2.22, 'variable lookup using ::<$symbols>');

}

# RT #65138, Foo::_foo() parsefails
{
    module A {
        our sub _b() { 'sub A::_b' }
    }
    is A::_b(), 'sub A::_b', 'A::_b() call works';
}

# RT #77750
#?rakudo todo 'dubious test - otherwise why is ::<$foo> allowed?'
eval_dies_ok '::.^methods', ':: is not a valid package';

# RT #63646
{
    dies_ok { OscarMikeGolf::whiskey_tango_foxtrot() },
            'dies when calling non-existent sub in non-existent package';
    dies_ok { Test::bravo_bravo_quebec() },
            'dies when calling non-existent sub in existing package';
    # RT #74520
    class TestA { };
    dies_ok { eval 'TestA::b(3, :foo)'},
        'calling non-existing function in foreign class dies';;
    #?rakudo todo 'nom regression'
    #?niecza todo
    ok "$!" ~~ / ' TestA::b' /, 'error message mentions function name';
}

# RT #71194
{
    sub self { 4 };
    is self(), 4, 'can define and call a sub self()';
}

# RT #77528
# Subroutines whose names begin with a keyword followed by a hyphen
# or apostrophe
# RT #72438
# Subroutines with keywords for names (may need to be called with
# parentheses).
#?DOES 114
{
    for <
        foo package module class role grammar my our state let
        temp has augment anon supersede sub method submethod
        macro multi proto only regex token rule constant enum
        subset if unless while repeat for foreach loop given
        when default > -> $kw {
        eval_lives_ok "sub $kw \{}; {$kw}();",
            "sub named \"$kw\" called with parentheses";
        eval_lives_ok "sub {$kw}-rest \{}; {$kw}-rest;",
            "sub whose name starts with \"$kw-\"";
        eval_lives_ok "sub {$kw}'rest \{}; {$kw}'rest;",
            "sub whose name starts with \"$kw'\"";
    }
}

# RT #69752
{
    try { eval 'Module.new' };
    ok "$!" ~~ / 'Module' /,
        'error message mentions name not recognized, no maximum recursion depth exceeded';
}

# RT #74276
# Rakudo had troubles with names starting with Q
eval_lives_ok 'class Quox { }; Quox.new', 'class names can start with Q';

# RT #58488 
dies_ok {
    eval 'class A { has $.a};  my $a = A.new();';
    eval 'class A { has $.a};  my $a = A.new();';
    eval 'class A { has $.a};  my $a = A.new();';
}, 'can *not* redefine a class in eval -- classes are package scoped';

# RT #83874
{
    class Class { };
    ok Class.new ~~ Class, 'can call a class Class';
}

# vim: ft=perl6
