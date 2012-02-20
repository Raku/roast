use v6;
use Test;

# see if you can declare the various built-in types
# a broad but not in depth test of the existence of various types

plan 79;

# L<S02/"Built-in Type Conventions"/"Built-in object types start with an uppercase letter">

# immutable types (e.g. Int, Num, Complex, Rat, Str, Bit, Regex, Set, Block, List)

{
 my Int $namcu =2;
 isa_ok($namcu,Int);
}

{
 my Num $namcu =1.1e1;
 isa_ok($namcu,Num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'Complex not type converted properly during assignment from Num'
#?niecza skip 'Complex not type converted properly during assignment from Rat'
{
 my Complex $namcu =1.3;
 isa_ok($namcu,Complex);
}

{
 my Rat $namcu = 7 / 4;
 isa_ok($namcu,Rat);
}

{
 my Str $lerpoi = "broda";
 isa_ok($lerpoi,Str);
}

#?rakudo skip 'Bit not implemented'
#?niecza skip 'Bit not implemented'
{
 my Bit $namcu =1;
 isa_ok($namcu,Bit);
}

{
 my Regex $morna;
 isa_ok($morna, Regex);
}

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


# mutable (container) types, such as Scalar, Array, Hash, Buf, Routine, Module
# Buf nacpoi

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

#?niecza skip "Buf NYI"
{
 my Buf $nacpoi;
 isa_ok($nacpoi, Buf);
}

{
 my Routine $gunka;
 isa_ok($gunka, Routine);
}

#?rakudo skip 'No Module type yet'
#?niecza skip 'No Module type yet'
{
 my Module $brodu;
 isa_ok($brodu, Module);
}


# non-instantiable Roles such as Callable, Failure, and Integral

{
 my Callable $fancu ;
 ok($fancu ~~ Callable);
}

#?rakudo skip 'Integral not implemented'
{
 my Integral $foo;
 ok($foo ~~ Integral);
}


# Non-object (native) types are lowercase: int, num, complex, rat, buf, bit.

#?rakudo todo 'int not implemented'
#?niecza skip 'int not implemented'
{
 my int $namcu =2;
 isa_ok($namcu,int);
}

#?rakudo todo 'num not implemented'
#?niecza skip 'num not implemented'
{
 my num $namcu =1.1e0;
 isa_ok($namcu,num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'complex not implemented'
#?niecza skip 'complex not implemented'
{
 my complex $namcu =1.3;
 isa_ok($namcu,complex);
}

#?rakudo skip 'rat not implemented'
#?niecza skip 'rat not implemented'

{
 my rat $namcu = 7 / 4;
 isa_ok($namcu,rat);
}

#?rakudo skip 'bit not implemented'
#?niecza skip 'bit not implemented'
{
 my bit $namcu =1;
 isa_ok($namcu,bit);
}

#?rakudo skip 'buf not implemented'
#?niecza skip 'buf not implemented'
{
 my buf $nacpoi;
 isa_ok($nacpoi, buf);
}

# junction StrPos StrLen uint Nil Whatever Mu Failure
# Exception Range Bag Signature Capture Blob Instant Duration
# Keyhash KeySet KeyBag Pair Mapping IO Routine Sub Method
# Submethod Macro Match Package Module Class Role Grammar Any

#?rakudo skip 'junction not implemented'
#?niecza skip 'junction not implemented'
{
 my junction $sor;
 isa_ok($sor, junction);
}

#?rakudo skip 'StrPos not implemented'
#?niecza skip 'StrPos not implemented'
{
 my StrPos $pa;
 isa_ok($pa,StrPos  );
}


#?rakudo skip 'StrLen not implemented'
#?niecza skip 'StrLen not implemented'
{
 my StrLen $re;
 isa_ok($re,StrLen  );
}

{
 my Nil $ci;
 ok($ci ~~ Nil);
}

{
 my Whatever $vo;
 isa_ok($vo,Whatever  );
}

{
 my Mu $mu;
 ok($mu ~~ Mu  );
}

#?niecza skip 'Failure not implemented'
{
 my Failure $xa;
 isa_ok($xa,Failure  );
}

#?niecza skip 'Exception not implemented'
{
 my Exception $ze;
 isa_ok($ze,Exception  );
}

{
 my Range $bi;
 isa_ok($bi,Range  );
}

{
 my Bag $so;
 isa_ok($so,Bag  );
}

{
 my Signature $pano;
 isa_ok($pano,Signature  );
}

{
 my Capture $papa;
 isa_ok($papa,Capture  );
}

#?rakudo skip 'Blob not implemented'
#?niecza skip 'Blob not implemented'
{
 my Blob $pare;
 isa_ok($pare,Blob  );
}

{
 my Instant $paci;
 isa_ok($paci,Instant  );
}

#?niecza skip 'Duration not implemented'
{
 my Duration $pavo;
 isa_ok($pavo,Duration  );
}

#?niecza skip 'KeyHash not implemented'
{
 my KeyHash $pamu;
 isa_ok($pamu,KeyHash  );
}

#?rakudo skip 'KeySet not implemented'
{
 my KeySet $paxa;
 isa_ok($paxa,KeySet  );
}

#?rakudo skip 'KeyBag not implemented'
{
 my KeyBag $paze;
 isa_ok($paze,KeyBag  );
}

{
 my Pair $pabi;
 isa_ok($pabi,Pair  );
}

{
 my EnumMap $paso;
 isa_ok($paso,EnumMap  );
}

{
 my IO $reno;
 isa_ok($reno,IO  );
}

{
 my Routine $repa;
 isa_ok($repa,Routine  );
}

{
 my Sub $rere;
 isa_ok($rere, Sub );
}

{
 my sub bar() { say 'blah' };
 my Sub $rr = &bar;
 isa_ok($rr, Sub );
}

{
 my sub baz() { return 1;};
 my sub bar() { return baz;} ;
 my &foo := &bar;
 is(&foo(), 1,'nested sub call');
}

{
 my sub baz() { return 1;};
 my sub bar() { return baz;} ;
 my $foo = &bar;
 is($($foo()), 1, 'nested sub call');
}


{
 my Method $reci;
 isa_ok($reci, Method );
}

{
 my Submethod $revo;
 isa_ok($revo, Submethod );
}

#?rakudo skip 'Macro not implemented'
#?niecza skip 'Macro not implemented'
{
 my Macro $remu;
 isa_ok($remu,Macro  );
}

{
 my Match $rexa;
 isa_ok($rexa,Match  );
}

{
 my Grammar $cire;
 isa_ok($cire,Grammar  );
}

{
 my Any $civo;
 isa_ok($civo, Any );
}

# http://svn.pugscode.org/pugs/src/perl6/CORE.pad had list of types pugs supports

{
 my Bool $jetfu;
 isa_ok($jetfu, Bool);
}

{
 my Order $karbi;
 isa_ok($karbi, Order);
}

#?rakudo skip 'Matcher isa not implemented'
#?niecza skip 'Matcher not implemented'
{
  my Matcher $mapti;
  isa_ok($mapti, Matcher);
}

{
  my Proxy $krati;
  isa_ok($krati, Proxy);
}

# CharLingua Byte Char AnyChar 

#?rakudo skip 'Char not implemented'
#?niecza skip 'Char not implemented'
{
  my Char $pav;
  isa_ok($pav, Char);
}

#?rakudo skip 'Byte not implemented'
#?niecza skip 'Byte not implemented'
{
  my Byte $biv;
  isa_ok($biv, Byte);
}

#?rakudo skip 'AnyChar not implemented'
#?niecza skip 'AnyChar not implemented'
{
  my AnyChar $lerfu;
  isa_ok($lerfu, AnyChar);
}

#?rakudo skip 'CharLingua not implemented'
#?niecza skip 'CharLingua not implemented'
{
  my CharLingua  $lerfu;
  isa_ok($lerfu, CharLingua );
}

#?rakudo skip 'Codepoint not implemented'
#?niecza skip 'Codepoint not implemented'
{
  my Codepoint $cypy;
  isa_ok($cypy,Codepoint );
}

#?rakudo skip 'Grapheme not implemented'
#?niecza skip 'Grapheme not implemented'
{
  my Grapheme $gy;
  isa_ok($gy,Grapheme );
}

# Positional Associative Ordering Ordered
# KeyExtractor Comparator OrderingPair HyperWhatever

{
  my Positional $mokca;
  ok($mokca ~~ Positional,'Positional exists');
}

{
  my Associative $kansa;
  ok($kansa ~~ Associative,'Associative exists');
}

#?rakudo skip 'Ordering not implemented'
#?niecza skip 'Ordering not implemented'
{
  my Ordering $foo;
  isa_ok($foo,Ordering);
}

#?rakudo skip 'KeyExtractor not implemented'
#?niecza skip 'KeyExtractor not implemented'
{
  my KeyExtractor $ckiku;
  isa_ok($ckiku, KeyExtractor);
}

# KeyExtractor Comparator OrderingPair HyperWhatever

#?rakudo skip 'Comparator not implemented'
#?niecza skip 'Comparator not implemented'
{
  my Comparator $bar;
  isa_ok($bar,Comparator);
}

#?rakudo skip 'OrderingPair not implemented'
#?niecza skip 'OrderingPair not implemented'
{
  my OrderingPair $foop;
  isa_ok($foop,OrderingPair);
}

#?rakudo skip 'HyperWhatever not implemented'
#?niecza skip 'HyperWhatever not implemented'
{
  my HyperWhatever $baz;
  isa_ok($baz,HyperWhatever);
}

# utf8 utf16 utf32

#?rakudo skip 'utf8  not implemented'
#?niecza skip 'utf8 not implemented'
{
  my utf8 $ubi;
  isa_ok($ubi,utf8);
}

#?rakudo skip 'utf16  not implemented'
#?niecza skip 'utf16 not implemented'
{
  my utf16 $upaxa;
  isa_ok($upaxa,utf16);
}

#?rakudo skip 'utf32  not implemented'
#?niecza skip 'utf32 not implemented'
{
  my utf32 $ucire;
  isa_ok($ucire,utf32);
}

# L<S09/Sized types/>
# int in1 int2 int4 int8 int16 in32 int64
# uint uin1 uint2 uint4 uint8 uint16 uint32 uint64
# t/spec/S02-builtin_data_types/int-uint.t already has these covered

# L<S09/Sized types/"num16">
# num16 num32 num64 num128
# complex16 complex32 complex64 complex128
# buf8 buf16 buf32 buf64 

#?rakudo skip 'num16  not implemented'
#?niecza skip 'num16 not implemented'
{
  my num16 $namcupaxa;
  isa_ok($namcupaxa,num16);
}

# TODO FIXME rakudo does not have any of them anyway

# L<S02/"Hierarchical types"/"A non-scalar type may be qualified">
# my Egg $cup; my Egg @carton; my Array of Egg @box; my Array of Array of Egg @crate;
# my Hash of Array of Recipe %book;
# my Hash:of(Array:of(Recipe)) %book;
# my Hash of Array of Recipe %book; my %book of Hash of Array of Recipe

#?niecza skip 'Coercive declarations NYI'
{
  my Array of Int @box;
  ok(1,'Array of Int @box');
}

#?niecza skip 'Coercive declarations NYI'
{
  my Array of Array of Int @box;
  ok(1,'Array of Array of Int @box');
}

# TODO FIXME



# vim: ft=perl6
