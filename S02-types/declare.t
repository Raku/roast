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

{
 my Complex $namcu = 1.3 + 0i;
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

#?rakudo skip 'Bit NYI'
#?niecza skip 'Bit NYI'
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
 ok($nacpoi ~~ Buf);
}

{
 my Routine $gunka;
 isa_ok($gunka, Routine);
}

{
 my Stash $igeda;
 isa_ok($igeda, Stash);
}

#?rakudo skip 'Module NYI'
#?niecza skip 'Module NYI'
{
 my Module $brodu;
 isa_ok($brodu, Module);
}

# non-instantiable Roles such as Callable, Failure, and Integral
{
 my Callable $fancu ;
 ok($fancu ~~ Callable);
}

#?rakudo skip 'Integral NYI'
{
 my Integral $foo;
 ok($foo ~~ Integral);
}


# Non-object (native) types are lowercase: int, num, complex, rat, buf, bit.

#?rakudo todo 'int NYI'
#?niecza skip 'int NYI'
{
 my int $namcu =2;
 isa_ok($namcu,int);
}

#?rakudo todo 'num NYI'
#?niecza skip 'num NYI'
{
 my num $namcu =1.1e0;
 isa_ok($namcu,num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'complex NYI'
#?niecza skip 'complex NYI'
{
 my complex $namcu =1.3;
 isa_ok($namcu,complex);
}

#?rakudo skip 'rat NYI'
#?niecza skip 'rat NYI'

{
 my rat $namcu = 7 / 4;
 isa_ok($namcu,rat);
}

#?rakudo skip 'bit NYI'
#?niecza skip 'bit NYI'
{
 my bit $namcu =1;
 isa_ok($namcu,bit);
}

#?rakudo skip 'buf NYI'
#?niecza skip 'buf NYI'
{
 my buf $nacpoi;
 isa_ok($nacpoi, buf);
}

# junction StrPos StrLen uint Nil Whatever Mu Failure
# Exception Range Bag Signature Capture Blob Instant Duration
# Keyhash SetHash BagHash Pair Mapping IO Routine Sub Method
# Submethod Macro Match Package Module Class Role Grammar Any

#?rakudo skip 'junction NYI'
#?niecza skip 'junction NYI'
{
 my junction $sor;
 isa_ok($sor, junction);
}

#?rakudo skip 'StrPos NYI'
#?niecza skip 'StrPos NYI'
{
 my StrPos $pa;
 isa_ok($pa,StrPos  );
}


#?rakudo skip 'StrLen NYI'
#?niecza skip 'StrLen NYI'
{
 my StrLen $re;
 isa_ok($re,StrLen  );
}

#?niecza skip 'No value for parameter $l in infix:<===>'
{
 my Nil $ci;
 ok($ci === Nil);
}

{
 my Whatever $vo;
 isa_ok($vo,Whatever  );
}

{
 my Mu $mu;
 ok($mu ~~ Mu  );
}

#?niecza skip 'Failure NYI'
{
 my Failure $xa;
 isa_ok($xa,Failure  );
}

#?niecza skip 'Exception NYI'
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

#?niecza skip 'Blob NYI'
{
 my Blob $pare;
 ok($pare ~~ Blob);
}

{
 my Instant $paci;
 isa_ok($paci,Instant  );
}

#?niecza skip 'Duration NYI'
{
 my Duration $pavo;
 isa_ok($pavo,Duration  );
}

#?niecza skip 'QuantHash NYI'
{
 my QuantHash $pamu;
 ok($pamu ~~ QuantHash, 'The object does QuantHash' );
}

#?niecza skip 'SetHash'
{
 my SetHash $paxa;
 isa_ok($paxa,SetHash  );
}

#?niecza skip 'BagHash'
{
 my BagHash $paze;
 isa_ok($paze,BagHash  );
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

#?niecza skip 'Macro NYI'
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

{
 my Bool $jetfu;
 isa_ok($jetfu, Bool);
}

{
 my Order $karbi;
 isa_ok($karbi, Order);
}

#?rakudo skip 'Matcher isa NYI'
#?niecza skip 'Matcher NYI'
{
  my Matcher $mapti;
  isa_ok($mapti, Matcher);
}

{
  my Proxy $krati;
  isa_ok($krati, Proxy);
}

# CharLingua Byte Char AnyChar 

#?rakudo skip 'Char NYI'
#?niecza skip 'Char NYI'
{
  my Char $pav;
  isa_ok($pav, Char);
}

#?rakudo skip 'Byte NYI'
#?niecza skip 'Byte NYI'
{
  my Byte $biv;
  isa_ok($biv, Byte);
}

#?rakudo skip 'AnyChar NYI'
#?niecza skip 'AnyChar NYI'
{
  my AnyChar $lerfu;
  isa_ok($lerfu, AnyChar);
}

#?rakudo skip 'CharLingua NYI'
#?niecza skip 'CharLingua NYI'
{
  my CharLingua  $lerfu;
  isa_ok($lerfu, CharLingua );
}

#?rakudo skip 'Codepoint NYI'
#?niecza skip 'Codepoint NYI'
{
  my Codepoint $cypy;
  isa_ok($cypy,Codepoint );
}

#?rakudo skip 'Grapheme NYI'
#?niecza skip 'Grapheme NYI'
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

#?rakudo skip 'Ordering NYI'
#?niecza skip 'Ordering NYI'
{
  my Ordering $foo;
  isa_ok($foo,Ordering);
}

#?rakudo skip 'KeyExtractor NYI'
#?niecza skip 'KeyExtractor NYI'
{
  my KeyExtractor $ckiku;
  isa_ok($ckiku, KeyExtractor);
}

# KeyExtractor Comparator OrderingPair HyperWhatever

#?rakudo skip 'Comparator NYI'
#?niecza skip 'Comparator NYI'
{
  my Comparator $bar;
  isa_ok($bar,Comparator);
}

#?rakudo skip 'OrderingPair NYI'
#?niecza skip 'OrderingPair NYI'
{
  my OrderingPair $foop;
  isa_ok($foop,OrderingPair);
}

#?niecza skip 'HyperWhatever NYI'
{
  my HyperWhatever $baz;
  isa_ok($baz,HyperWhatever);
}

# utf8 utf16 utf32

#?niecza skip 'utf8 NYI'
{
  my utf8 $ubi;
  isa_ok($ubi,utf8);
}

#?niecza skip 'utf16 NYI'
{
  my utf16 $upaxa;
  isa_ok($upaxa,utf16);
}

#?niecza skip 'utf32 NYI'
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

#?rakudo skip 'num16  NYI'
#?niecza skip 'num16 NYI'
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

#RT #75896
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
