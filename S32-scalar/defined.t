use v6;
use Test;
plan 35;

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
ok(defined(Nil), 'Nil is defined');
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

undefine($foo);
ok(!defined($foo), 'undefine $foo works');

# containers

my @bax;
ok(defined(@bax), 'unassigned variable @bax is defined');

@bax = 3, 4, 5;
ok(defined(@bax), 'unassigned variable @bax is defined');

@bax = Nil;
ok(defined(@bax), 'variable @bax is defined after assigning Nil');

# try the invocant syntax

{
    my $foo;
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

    undefine($foo);
    ok(!$foo.defined, 'undefine $foo works');
}

# While porting a Perl 5 solution to QoTW regular #24, I noticed the following bug:
#   my %a = (a => 1);
#   defined %a{"b"}; # true!
my %a = (a => 1);
ok defined(%a{"a"}),        "defined on a hash with parens (1)";
ok !defined(%a{"b"}),       "defined on a hash with parens (2)";

# vim: ft=perl6
