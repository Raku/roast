use v6;

use Test;

plan 144;

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
    #?niecza skip 'Object reference not set to an instance of an object'
    #?rakudo skip 'this kind of lookup NYI'
    is($::{'bear'}, 2.16, 'variable lookup using $::{\'foo\'}');
    is(::{'$bear'}, 2.16, 'variable lookup using ::{\'$foo\'}');
    #?niecza skip 'Object reference not set to an instance of an object'
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
is_deeply ::.^methods, PseudoStash.^methods, ':: is a valid PseudoStash';

# RT #63646
{
    throws_like { OscarMikeGolf::whiskey_tango_foxtrot() },
      Exception,
      'dies when calling non-existent sub in non-existent package';
    throws_like { Test::bravo_bravo_quebec() },
      Exception,
      'dies when calling non-existent sub in existing package';
    # RT #74520
    class TestA { };
    #?niecza todo
    throws_like { TestA::frobnosticate(3, :foo) },
      Exception,
      'calling non-existing function in foreign class dies';;
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

{
    my \s = 42;
    is s, 42, 'local terms override quoters';
    sub m { return 42 };
    is m, 42, 'local subs override quoters';
}

# RT #77006
isa_ok (rule => 1), Pair, 'rule => something creates a Pair';

# RT #69752
{
    throws_like { EVAL 'Module.new' },
      X::Undeclared::Symbols,
      'error message mentions name not recognized, no maximum recursion depth exceeded';
}

# RT #74276
# Rakudo had troubles with names starting with Q
lives_ok { EVAL 'class Quox { }; Quox.new' },
  'class names can start with Q';

# RT #58488
throws_like {
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
},
  X::Redeclaration,
  'can *not* redefine a class in EVAL -- classes are package scoped';

# RT #83874
{
    class Class { };
    ok Class.new ~~ Class, 'can call a class Class';
}

# RT #75646
{
    throws_like { my ::foo $x, say $x }, Exception,
        message => 'Cannot type check against type variable foo',
        'no Null PMC access when printing a variable typed as ::foo ';
}

# vim: ft=perl6
