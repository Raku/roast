use v6;
use Test;
plan 21;

# L<S29/Scalar/"=item defined">

=begin pod

Tests for the defined() builtin

=end pod



ok(!defined(undef), 'undef is not defined');

ok(defined(1),   'numeric literal 1 is defined');
ok(defined(""),  'empty string is defined');
ok(defined("a"), '"a" is defined');
ok(defined(0),   'numeric literal 0 is defined');

my $foo;
ok(!defined($foo), 'unassigned variable $foo is undefined');

$foo = 1;
ok(defined($foo), 'variable $foo is now defined (as numeric literal 1)');

$foo = "";
ok(defined($foo), 'variable $foo is now defined (as a empty string)');

$foo = undef;
ok(!defined($foo), 'variable $foo is now undefined again');

$foo = "a";
ok(defined($foo), 'variable $foo is now defined (as string "a")');

$foo = 0;
ok(defined($foo), 'variable $foo is now defined (as numeric literal 0)');

undefine($foo);
ok(!defined($foo), 'undef $foo works');

# try the invocant syntax

my $foo;
ok(!$foo.defined, 'unassigned variable $foo is undefined');

$foo = 1;
ok($foo.defined, 'variable $foo is now defined (as numeric literal 1)');

$foo = "";
ok($foo.defined, 'variable $foo is now defined (as a empty string)');

$foo = undef;
ok(!$foo.defined, 'variable $foo is now undefined again');

$foo = "a";
ok($foo.defined, 'variable $foo is now defined (as string "a")');

$foo = 0;
ok($foo.defined, 'variable $foo is now defined (as numeric literal 0)');

undefine($foo);
ok(!$foo.defined, 'undef $foo works');


# While porting a Perl 5 solution to QoTW regular #24, I noticed the following bug:
#   my %a = (a => 1);
#   defined %a{"b"}; # true!
my %a = (a => 1);
ok defined(%a{"a"}),        "defined on a hash with parens (1)";
ok !defined(%a{"b"}),       "defined on a hash with parens (2)";
