use v6;
use Test;
plan 23;

# L<S02/"Built-In Data Types"/"Built-in object types start with an uppercase letter">

# immutable types (e.g. Int, Num, Complex, Rat, Str, Bit, Regex, Set, Block, List, Seq)

{
 my Int $namcu =2;
 isa_ok($namcu,Int);
}

{
 my Num $namcu =1.1;
 isa_ok($namcu,Num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'Complex not type converted properly during assignment from Num'
{
 my Complex $namcu =1.3;
 isa_ok($namcu,Complex);
}

#?rakudo skip 'Rat not implemented'
{
 my Rat $namcu = 7 div 4;
 isa_ok($namcu,Rat);
}

{
 my Str $lerpoi = "broda";
 isa_ok($lerpoi,Str);
}

#?rakudo skip 'Bit not implemented'
{
 my Bit $namcu =1;
 isa_ok($namcu,Bit);
}

{
 my Regex $morna;
 isa_ok($morna, Regex);
}

#?rakudo skip 'Set not implemented'
{
 my Set $selcmima;
 isa_ok($selcmima, Set);
}

{
 my Block $broda;
 isa_ok($broda, Block);
}

{
 my List $liste;
 isa_ok($liste, List);
}

#?rakudo skip 'Seq not implemented'
{
 my Seq $porsi;
 isa_ok($porsi, Seq);
}


# mutable (container) types, such as Scalar, Array, Hash, Buf, Routine, Module
# Buf nacpoi

#?rakudo skip 'Scalar not implemented'
{
 my Scalar $brode;
 isa_ok($brode, Scalar);
}

{
 my Array $porsi;
 isa_ok($porsi, Array);
}

{
 my Hash $brodi;
 isa_ok($brodi, Hash);
}

#?rakudo skip 'Buf not implemented'
{
 my Buf $nacpoi;
 isa_ok($nacpoi, Buf);
}

{
 my Routine $gunka;
 isa_ok($gunka, Routine);
}

{
 my Module $brodu;
 isa_ok($brodu, Module);
}


# non-instantiable Roles such as Callable, Failure, and Integral
# FIXME TODO how to test this?

# Non-object (native) types are lowercase: int, num, complex, rat, buf, bit.

#?rakudo skip 'int not implemented'
{
 my int $namcu =2;
 isa_ok($namcu,int);
}

#?rakudo skip 'num not implemented'
{
 my num $namcu =1.1;
 isa_ok($namcu,num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'complex not implemented'
{
 my complex $namcu =1.3;
 isa_ok($namcu,complex);
}

#?rakudo skip 'rat not implemented'
{
 my rat $namcu = 7 div 4;
 isa_ok($namcu,rat);
}

#?rakudo skip 'bit not implemented'
{
 my bit $namcu =1;
 isa_ok($namcu,bit);
}

#?rakudo skip 'buf not implemented'
{
 my buf $nacpoi;
 isa_ok($nacpoi, buf);
}

