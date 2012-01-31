use v6;
use Test;
plan 54;

# L<S32::Basics/Mu/=item defined>

=begin pod

Tests for the defined() builtin

=end pod



ok(!defined(Mu), 'Mu is not defined');
ok(!defined(Int), 'Int is not defined');
ok(!defined(Num), 'Num is not defined');
ok(!defined(Str), 'Str is not defined');

ok(defined(1),   'numeric literal 1 is defined');
ok(defined(""),  'empty string is defined');
ok(defined("a"), '"a" is defined');
ok(defined(0),   'numeric literal 0 is defined');
ok(defined(()),  'empty Parcel is defined');
ok(defined([]),  'empty Array is defined');
ok(defined({}),  'empty Hash is defined');

my $foo;
ok(!defined($foo), 'unassigned variable $foo is undefined');

$foo = 1;
ok(defined($foo), 'variable $foo is now defined (as numeric literal 1)');

$foo = "";
ok(defined($foo), 'variable $foo is now defined (as a empty string)');

$foo = Nil;
ok(!defined($foo), 'variable $foo is now undefined again');

$foo = "a";
ok(defined($foo), 'variable $foo is now defined (as string "a")');

$foo = Mu;
ok(!defined($foo), 'variable $foo is now undefined again');

$foo = "b";
ok(defined($foo), 'variable $foo is now defined (as string "b")');

$foo = 0;
ok(defined($foo), 'variable $foo is now defined (as numeric literal 0)');

{
    undefine($foo);
    ok(!defined($foo), 'undefine $foo works');
}

# containers

my @bax;
ok(defined(@bax), 'unassigned variable @bax is defined');

@bax = 3, 4, 5;
ok(defined(@bax), 'unassigned variable @bax is defined');

@bax = Nil;
ok(defined(@bax), 'variable @bax is defined after assigning Nil');

# try the invocant syntax

{
    my Mu $foo;
    ok(!$foo.defined, 'unassigned variable $foo is undefined');

    $foo = 1;
    ok($foo.defined, 'variable $foo is now defined (as numeric literal 1)');

    $foo = "";
    ok($foo.defined, 'variable $foo is now defined (as a empty string)');

    $foo = Nil;
    ok(!$foo.defined, 'variable $foo is now undefined again');

    $foo = "a";
    ok($foo.defined, 'variable $foo is now defined (as string "a")');

    $foo = Mu;
    ok(!$foo.defined, 'variable $foo is now undefined again');

    $foo = "b";
    ok($foo.defined, 'variable $foo is now defined (as string "b")');

    $foo = 0;
    ok($foo.defined, 'variable $foo is now defined (as numeric literal 0)');

{
    undefine($foo);
    ok(!$foo.defined, 'undefine $foo works');
}
}

# RT #81352
# Ensure that we always get Bools
{
    isa_ok defined(Mu), Bool, 'defined(Mu) returns a Bool';
    isa_ok Mu.defined, Bool, 'Mu.defined returns a Bool';
    isa_ok defined(Int), Bool, 'defined(Int) returns a Bool';
    isa_ok Int.defined, Bool, 'Int.defined returns a Bool';
    isa_ok defined(1), Bool, 'defined(1) returns a Bool';
    isa_ok 1.defined, Bool, '1.defined returns a Bool';
    isa_ok defined("a"), Bool, 'defined("a") returns a Bool';
    isa_ok "a".defined, Bool, '"a".defined returns a Bool';
    isa_ok defined(()), Bool, 'defined(()) returns a Bool';
    isa_ok ().defined, Bool, '().defined returns a Bool';
    isa_ok defined({}), Bool, 'defined({}) returns a Bool';
    isa_ok {}.defined, Bool, '{}.defined returns a Bool';

    my $bar;
    isa_ok defined($bar), Bool, 'defined($bar) with $bar unset returns a Bool';
    isa_ok $bar.defined, Bool, '$bar.defined with $bar unset returns a Bool';
    $bar = "";
    isa_ok defined($bar), Bool, 'defined($bar) with $bar eq "" returns a Bool';
    isa_ok $bar.defined, Bool, '$bar.defined with $bar eq "" returns a Bool';
    $bar = 7;
    isa_ok defined($bar), Bool, 'defined($bar) with $bar == 7 returns a Bool';
    isa_ok $bar.defined, Bool, '$bar.defined with $bar == 7 returns a Bool';
    $bar = Mu;
    isa_ok defined($bar), Bool, 'defined($bar) with $bar set to Mu returns a Bool';
    isa_ok $bar.defined, Bool, '$bar.defined with $bar set to Mu returns a Bool';
}

# While porting a Perl 5 solution to QoTW regular #24, I noticed the following bug:
#   my %a = (a => 1);
#   defined %a{"b"}; # true!
my %a = (a => 1);
ok defined(%a{"a"}),        "defined on a hash with parens (1)";
ok !defined(%a{"b"}),       "defined on a hash with parens (2)";

# vim: ft=perl6
