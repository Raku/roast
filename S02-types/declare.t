use v6;
use Test;

# see if you can declare the various built-in types
# a broad but not in depth test of the existence of various types

plan 78;

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
#?pugs todo
{
 my Bit $namcu =1;
 isa_ok($namcu,Bit);
}

{
 my Regex $morna;
 isa_ok($morna, Regex);
}

#?pugs skip 'Set'
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
#?pugs skip 'Buf'
{
 my Buf $nacpoi;
 ok($nacpoi ~~ Buf);
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

#?pugs skip 'Callable'
{
 my Callable $fancu ;
 ok($fancu ~~ Callable);
}

#?rakudo skip 'Integral not implemented'
#?pugs skip 'Integral'
{
 my Integral $foo;
 ok($foo ~~ Integral);
}


# Non-object (native) types are lowercase: int, num, complex, rat, buf, bit.

#?rakudo todo 'int not implemented'
#?niecza skip 'int not implemented'
#?pugs skip 'parsefail'
{
 my int $namcu =2;
 isa_ok($namcu,int);
}

#?rakudo todo 'num not implemented'
#?niecza skip 'num not implemented'
#?pugs skip 'num'
{
 my num $namcu =1.1e0;
 isa_ok($namcu,num);
}

# Type mismatch in assignment; expected something matching type Complex but got something of type Num()

#?rakudo skip 'complex not implemented'
#?niecza skip 'complex not implemented'
#?pugs skip 'complex'
{
 my complex $namcu =1.3;
 isa_ok($namcu,complex);
}

#?rakudo skip 'rat not implemented'
#?niecza skip 'rat not implemented'
#?pugs skip 'rat'

{
 my rat $namcu = 7 / 4;
 isa_ok($namcu,rat);
}

#?rakudo skip 'bit not implemented'
#?niecza skip 'bit not implemented'
#?pugs skip 'bit'
{
 my bit $namcu =1;
 isa_ok($namcu,bit);
}

#?rakudo skip 'buf not implemented'
#?niecza skip 'buf not implemented'
#?pugs skip 'buf'
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
#?pugs skip 'junction'
{
 my junction $sor;
 isa_ok($sor, junction);
}

#?rakudo skip 'StrPos not implemented'
#?niecza skip 'StrPos not implemented'
#?pugs skip 'StrPos'
{
 my StrPos $pa;
 isa_ok($pa,StrPos  );
}


#?rakudo skip 'StrLen not implemented'
#?niecza skip 'StrLen not implemented'
#?pugs skip 'StrLen'
{
 my StrLen $re;
 isa_ok($re,StrLen  );
}

#?pugs skip 'Nil'
#?niecza skip 'No value for parameter $l in infix:<===>'
{
 my Nil $ci;
 ok($ci === Nil);
}

#?pugs skip 'Whatever'
{
 my Whatever $vo;
 isa_ok($vo,Whatever  );
}

{
 my Mu $mu;
 ok($mu ~~ Mu  );
}

#?niecza skip 'Failure not implemented'
#?pugs skip 'Failure'
{
 my Failure $xa;
 isa_ok($xa,Failure  );
}

#?niecza skip 'Exception not implemented'
#?pugs skip 'Exception'
{
 my Exception $ze;
 isa_ok($ze,Exception  );
}

#?pugs skip 'Range'
{
 my Range $bi;
 isa_ok($bi,Range  );
}

#?pugs skip 'Bag'
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

#?niecza skip 'Blob not implemented'
#?pugs skip 'Blob'
{
 my Blob $pare;
 ok($pare ~~ Blob);
}

#?pugs skip 'Instant'
{
 my Instant $paci;
 isa_ok($paci,Instant  );
}

#?niecza skip 'Duration not implemented'
#?pugs skip 'Duration'
{
 my Duration $pavo;
 isa_ok($pavo,Duration  );
}

#?niecza skip 'KeyHash not implemented'
#?rakudo skip 'KeyHash not implemented'
#?pugs skip 'KeyHash'
{
 my KeyHash $pamu;
 isa_ok($pamu,KeyHash  );
}

#?pugs skip 'KeySet'
{
 my KeySet $paxa;
 isa_ok($paxa,KeySet  );
}

#?pugs skip 'KeyBag'
{
 my KeyBag $paze;
 isa_ok($paze,KeyBag  );
}

{
 my Pair $pabi;
 isa_ok($pabi,Pair  );
}

#?pugs skip 'EnumMap'
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

#?pugs skip 'Order'
{
 my Order $karbi;
 isa_ok($karbi, Order);
}

#?rakudo skip 'Matcher isa not implemented'
#?niecza skip 'Matcher not implemented'
#?pugs skip 'Matcher'
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
#?pugs skip 'Char'
{
  my Char $pav;
  isa_ok($pav, Char);
}

#?rakudo skip 'Byte not implemented'
#?niecza skip 'Byte not implemented'
#?pugs skip 'Byte'
{
  my Byte $biv;
  isa_ok($biv, Byte);
}

#?rakudo skip 'AnyChar not implemented'
#?niecza skip 'AnyChar not implemented'
#?pugs skip 'AnyChar'
{
  my AnyChar $lerfu;
  isa_ok($lerfu, AnyChar);
}

#?rakudo skip 'CharLingua not implemented'
#?niecza skip 'CharLingua not implemented'
#?pugs skip 'CharLingua'
{
  my CharLingua  $lerfu;
  isa_ok($lerfu, CharLingua );
}

#?rakudo skip 'Codepoint not implemented'
#?niecza skip 'Codepoint not implemented'
#?pugs skip 'Codepoint'
{
  my Codepoint $cypy;
  isa_ok($cypy,Codepoint );
}

#?rakudo skip 'Grapheme not implemented'
#?niecza skip 'Grapheme not implemented'
#?pugs skip 'Grapheme'
{
  my Grapheme $gy;
  isa_ok($gy,Grapheme );
}

# Positional Associative Ordering Ordered
# KeyExtractor Comparator OrderingPair HyperWhatever

#?pugs skip 'Positional'
{
  my Positional $mokca;
  ok($mokca ~~ Positional,'Positional exists');
}

#?pugs skip 'Associative'
{
  my Associative $kansa;
  ok($kansa ~~ Associative,'Associative exists');
}

#?rakudo skip 'Ordering not implemented'
#?niecza skip 'Ordering not implemented'
#?pugs skip 'Ordering'
{
  my Ordering $foo;
  isa_ok($foo,Ordering);
}

#?rakudo skip 'KeyExtractor not implemented'
#?niecza skip 'KeyExtractor not implemented'
#?pugs skip 'KeyExtractor'
{
  my KeyExtractor $ckiku;
  isa_ok($ckiku, KeyExtractor);
}

# KeyExtractor Comparator OrderingPair HyperWhatever

#?rakudo skip 'Comparator not implemented'
#?niecza skip 'Comparator not implemented'
#?pugs skip 'Comparator'
{
  my Comparator $bar;
  isa_ok($bar,Comparator);
}

#?rakudo skip 'OrderingPair not implemented'
#?niecza skip 'OrderingPair not implemented'
#?pugs skip 'OrderingPair'
{
  my OrderingPair $foop;
  isa_ok($foop,OrderingPair);
}

#?rakudo skip 'HyperWhatever not implemented'
#?niecza skip 'HyperWhatever not implemented'
#?pugs skip 'HyperWhatever'
{
  my HyperWhatever $baz;
  isa_ok($baz,HyperWhatever);
}

# utf8 utf16 utf32

#?niecza skip 'utf8 not implemented'
#?pugs skip 'utf8'
{
  my utf8 $ubi;
  isa_ok($ubi,utf8);
}

#?niecza skip 'utf16 not implemented'
#?pugs skip 'utf16'
{
  my utf16 $upaxa;
  isa_ok($upaxa,utf16);
}

#?niecza skip 'utf32 not implemented'
#?pugs skip 'utf32'
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
#?pugs skip 'num16'
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
#?pugs skip 'parsefail'
{
  my Array of Int @box;
  ok(1,'Array of Int @box');
}

#?niecza skip 'Coercive declarations NYI'
#?pugs skip 'parsefail'
{
  my Array of Array of Int @box;
  ok(1,'Array of Array of Int @box');
}

# TODO FIXME



# vim: ft=perl6
