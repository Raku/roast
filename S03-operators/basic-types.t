use v6;

use Test;

plan 19;

# WHAT() on basic types

my $a;
isa_ok($a, Any, 'it is an Any type');

my @a;
isa_ok(@a, Array, 'it is an Array type');
ok @a ~~ Positional, 'An Array does Positional';

my %a;
isa_ok(%a, Hash, 'it is an Hash type');
ok %a ~~ Associative, 'A Hash does Associative';

# WHAT() on reference types

my $b1 = [];
isa_ok($b1, List, 'it is a List type');

# this seems to be the only way to make a hash - ref at the moment
my %b2 = ("one", 1); my $b2 = %b2;
isa_ok($b2, Hash, 'it is a Hash type'); 

# WHAT() on subroutines

my $s1 = sub {};
isa_ok($s1, Sub, 'it is a Sub type');

# See L<S02/"Built-in Data Types"> and especially L<A06/"The C<sub> form"> why {...} and ->
# ... {...} aren't Subs, but Blocks (they're all Codes, though).
# Quoting A06:
#                                   Code
#                        ____________|________________
#                       |                             |
#                    Routine                        Block
#       ________________|_______________ 
#      |     |       |       |    |     |
#     Sub Method Submethod Multi Rule Macro

# L<S06/Anonymous hashes vs blocks>
my $s2 = {};
isa_ok($s2, Hash, 'it is a Hash type (bare block)');

# L<S06/"Placeholder variables">
my $s2a = { $^a };
isa_ok($s2a, Block, 'it is a Parametric type (bare block with placeholder parameters)');

{
    my $s3 = -> {};
    isa_ok($s3, Block, 'it is a Block type (pointy block)');
}

# WHAT() on different types of scalars

my $int = 0;
isa_ok($int, Int, 'it is an Int type');

my $num = '';
ok(+$num ~~ Num, 'it is an Num type');

my $float = 0.5;
isa_ok($float, Num, 'it is an Num type');
#?rakudo skip 'infix:<div>, Rat'
isa_ok(1 div 4, Rat, 'infix:<div> produces a Rat');

my $string = "Hello World";
isa_ok($string, Str, 'it is a Str type');

my $bool = (0 == 0);
isa_ok($bool, Bool, 'it is a Bool type');

my $pair = ("foo" => "bar");
isa_ok($pair, Pair, 'it is a Pair type');

#?rakudo skip 'rx/.../'
{
    my $rule = rx/^hello\sworld$/;
    isa_ok($rule, Regex, 'it is a Regex type');
}
