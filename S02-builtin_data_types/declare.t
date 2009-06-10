use v6;
use Test;

# see if you can declare the various built-in types
plan 58;

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

# junction StrPos StrLen uint Nil Whatever Object Failure
# Exception Range Bag Signature Capture Blob Instant Duration
# Keyhash KeySet KeyBag Pair Mapping IO Routine Sub Method
# Submethod Macro Match Package Module Class Role Grammar Any

#maybe it just needs
#?rakudo skip 'junction not implemented'
{
 my junction $sor;
 isa_ok($sor, junction);
}

#?rakudo skip 'StrPos not implemented'
{
 my StrPos $pa;
 isa_ok($pa,StrPos  );
}


#?rakudo skip 'StrLen not implemented'
{
 my StrLen $re;
 isa_ok($re,StrLen  );
}

{
 my Nil $ci;
 isa_ok($ci,Nil  );
}

{
 my Whatever $vo;
 isa_ok($vo,Whatever  );
}

#?rakudo skip 'Object not working'
{
 my Object $mu;
 isa_ok($mu,Object  );
}

{
 my Failure $xa;
 isa_ok($xa,Failure  );
}

{
 my Exception $ze;
 isa_ok($ze,Exception  );
}

{
 my Range $bi;
 isa_ok($bi,Range  );
}

#?rakudo skip 'Bag not implemented'
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
{
 my Blob $pare;
 isa_ok($pare,Blob  );
}

#?rakudo skip 'Instant not implemented'
{
 my Instant $paci;
 isa_ok($paci,Instant  );
}

#?rakudo skip 'Duration not implemented'
{
 my Duration $pavo;
 isa_ok($pavo,Duration  );
}

#?rakudo skip 'KeyHash not implemented'
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
 my Mapping $paso;
 isa_ok($paso,Mapping  );
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
 my Method $reci;
 isa_ok($reci, Method );
}

{
 my Submethod $revo;
 isa_ok($revo, Submethod );
}

#?rakudo skip 'Macro not implemented'
{
 my Macro $remu;
 isa_ok($remu,Macro  );
}

{
 my Match $rexa;
 isa_ok($rexa,Match  );
}

#?rakudo skip 'Package not implemented'
{
 my Package $reze;
 isa_ok($reze,Package  );
}

{
 my Module $rebi;
 isa_ok($rebi,Module  );
}

#?rakudo skip 'Class not implemented'
{
 my Class $reso;
 isa_ok($reso,Class  );
}

#?rakudo skip 'Role causing Null PMC access in get_string()'
{
 my Role $cino;
 isa_ok($cino, Role );
}

{
 my Grammar $cire;
 isa_ok($cire,Grammar  );
}

{
 my Any $civo;
 isa_ok($civo, Any );
}
