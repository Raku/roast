use v6;

use Test;

plan 4 * ( 1 + 14 * 20 );

#-------------------------------------------------------------------------------
# initialisations

my $ok = True;
my $no = False;

sub gen(\h) {
    my Int $i = 0;
    h{$_} = ++$i for 'a'..'d';
    is h.elems, 4, "{h.^name} basic sanity";
}

gen my %a;
gen my Int %i;
gen my %c{Cool};
gen my Int %j{Cool};

my @b  = <b>;
my @B  = <B>;
my @bc = <b c>;
my @BC = <B C>;
my @bC = <b C>;

#-------------------------------------------------------------------------------
# Hash

for $%a, Any, $%i, Int, $%c, Any, $%j, Int -> %h, $T {
    my $n = %h.VAR.name;

# single existing key
{
    is %h<b>,               2, "$n single key existing: value";
    is %h<b>:k,           "b", "$n single key existing: :k";
    is %h<b>:k($ok),      "b", "$n single key existing: :k(\$ok)";
    is %h<b>:!k,          "b", "$n single key existing: :!k";
    is %h<b>:k($no),      "b", "$n single key existing: :k(\$no)";
    is %h<b>:v,             2, "$n single key existing: :v";
    is %h<b>:v($ok),        2, "$n single key existing: :v(\$ok)";
    is %h<b>:!v,            2, "$n single key existing: :!v";
    is %h<b>:v($no),        2, "$n single key existing: :v(\$no)";
    is %h<b>:kv,      ("b",2), "$n single key existing: :kv";
    is %h<b>:kv($ok), ("b",2), "$n single key existing: :kv(\$ok)";
    is %h<b>:!kv,     ("b",2), "$n single key existing: :!kv";
    is %h<b>:kv($no), ("b",2), "$n single key existing: :kv(\$no)";
    is %h<b>:p,        (b=>2), "$n single key existing: :p";
    is %h<b>:p($ok),   (b=>2), "$n single key existing: :p(\$ok)";
    is %h<b>:!p,       (b=>2), "$n single key existing: :!p";
    is %h<b>:p($no),   (b=>2), "$n single key existing: :p(\$no)";

    throws-like '%h<b>:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h<b>:zorp', X::AdHoc; # caught by MMD
    throws-like '%h<b>:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# array single existing key
{
    is %h{@b},            (2,), "$n array single key existing: value";
    is %h{@b}:k,        ("b",), "$n array single key existing: :k";
    is %h{@b}:k($ok),   ("b",), "$n array single key existing: :k(\$ok)";
    is %h{@b}:!k,       ("b",), "$n array single key existing: :!k";
    is %h{@b}:k($no),   ("b",), "$n array single key existing: :k(\$no)";
    is %h{@b}:v,          (2,), "$n array single key existing: :v";
    is %h{@b}:v($ok),     (2,), "$n array single key existing: :v(\$ok)";
    is %h{@b}:!v,         (2,), "$n array single key existing: :!v";
    is %h{@b}:v($no),     (2,), "$n array single key existing: :v(\$no)";
    is %h{@b}:kv,      ("b",2), "$n array single key existing: :kv";
    is %h{@b}:kv($ok), ("b",2), "$n array single key existing: :kv(\$ok)";
    is %h{@b}:!kv,     ("b",2), "$n array single key existing: :!kv";
    is %h{@b}:kv($no), ("b",2), "$n array single key existing: :kv(\$no)";
    is %h{@b}:p,        (b=>2), "$n array single key existing: :p";
    is %h{@b}:p($ok),   (b=>2), "$n single key existing: :p(\$ok)";
    is %h{@b}:!p,       (b=>2), "$n single key existing: :!p";
    is %h{@b}:p($no),   (b=>2), "$n single key existing: :p(\$no)";

    throws-like '%h{@b}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{@b}:rickroll', X::AdHoc; # caught by MMD
    throws-like '%h{@b}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# single missing key
{
    is %h<B>,               $T, "$n single key missing: value";
    is %h<B>:k,             (), "$n single key missing: :k";
    is %h<B>:k($ok),        (), "$n single key missing: :k(\$ok)";
    is %h<B>:!k,           "B", "$n single key missing: :!k";
    is %h<B>:k($no),       "B", "$n single key missing: :k(\$no)";
    is %h<B>:v,             (), "$n single key missing: :v";
    is %h<B>:v($ok),        (), "$n single key missing: :v(\$ok)";
    is %h<B>:!v,            $T, "$n single key missing: :!v";
    is %h<B>:v($no),        $T, "$n single key missing: :v(\$no)";
    is %h<B>:kv,            (), "$n single key missing: :kv(\$ok)";
    is %h<B>:kv($ok),       (), "$n single key missing: :kv";
    is %h<B>:!kv,     ("B",$T), "$n single key missing: :!kv";
    is %h<B>:kv($no), ("B",$T), "$n single key missing: :kv(\$no)";
    is %h<B>:p,             (), "$n single key missing: :p(\$ok)";
    is %h<B>:p($ok),        (), "$n single key missing: :p";
    is %h<B>:!p,       (B=>$T), "$n single key missing: :!p";
    is %h<B>:p($no),   (B=>$T), "$n single key missing: :p(\$no)";

    throws-like '%h<B>:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h<B>:baxter', X::AdHoc; # caught by MMD
    throws-like '%h<B>:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# array single missing key
{
    is %h{@B},            ($T,), "$n array single key missing: value";
    is %h{@B}:k,             (), "$n array single key missing: :k";
    is %h{@B}:k($ok),        (), "$n array single key missing: :k(\$ok)";
    is %h{@B}:!k,        ("B",), "$n array single key missing: :!k";
    is %h{@B}:k($no),    ("B",), "$n array single key missing: :k(\$no)";
    is %h{@B}:v,             (), "$n array single key missing: :v";
    is %h{@B}:v($ok),        (), "$n array single key missing: :v(\$ok)";
    is %h{@B}:!v,         ($T,), "$n array single key missing: :!v";
    is %h{@B}:v($no),     ($T,), "$n array single key missing: :v(\$no)";
    is %h{@B}:kv,            (), "$n array single key missing: :kv(\$ok)";
    is %h{@B}:kv($ok),       (), "$n array single key missing: :kv";
    is %h{@B}:!kv,     ("B",$T), "$n array single key missing: :!kv";
    is %h{@B}:kv($no), ("B",$T), "$n array single key missing: :kv(\$no)";
    is %h{@B}:p,             (), "$n array single key missing: :p(\$ok)";
    is %h{@B}:p($ok),        (), "$n array single key missing: :p";
    is %h{@B}:!p,       (B=>$T), "$n array single key missing: :!p";
    is %h{@B}:p($no),   (B=>$T), "$n array single key missing: :p(\$no)";

    throws-like '%h{@B}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{@B}:jefferson', X::AdHoc; # caught by MMD
    throws-like '%h{@B}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# multiple existing keys
{
    is %h<b c>,                 (2,3), "$n multiple key existing: value";
    is %h<b c>:k,               <b c>, "$n multiple key existing: :k";
    is %h<b c>:k($ok),          <b c>, "$n multiple key existing: :k(\$ok)";
    is %h<b c>:!k,              <b c>, "$n multiple key existing: :!k";
    is %h<b c>:k($no),          <b c>, "$n multiple key existing: :k(\$no)";
    is %h<b c>:v,               (2,3), "$n multiple key existing: :v";
    is %h<b c>:v($ok),          (2,3), "$n multiple key existing: :v(\$ok)";
    is %h<b c>:!v,              (2,3), "$n multiple key existing: :!v";
    is %h<b c>:v($no),          (2,3), "$n multiple key existing: :v(\$no)";
    is %h<b c>:kv,      ("b",2,"c",3), "$n multiple key existing: :kv";
    is %h<b c>:kv($ok), ("b",2,"c",3), "$n multiple key existing: :kv(\$ok)";
    is %h<b c>:!kv,     ("b",2,"c",3), "$n multiple key existing: :!kv";
    is %h<b c>:kv($no), ("b",2,"c",3), "$n multiple key existing: :kv(\$no)";
    is %h<b c>:p,         (b=>2,c=>3), "$n multiple key existing: :p";
    is %h<b c>:p($ok),    (b=>2,c=>3), "$n multiple key existing: :p(\$ok)";
    is %h<b c>:!p,        (b=>2,c=>3), "$n multiple key existing: :!p";
    is %h<b c>:p($no),    (b=>2,c=>3), "$n multiple key existing: :p(\$no)";

    throws-like '%h<b c>:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h<b c>:egg', X::AdHoc; # caught by MMD
    throws-like '%h<b c>:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# array multiple existing keys
{
    is %h{@bc},                 (2,3), "$n array multi key existing: value";
    is %h{@bc}:k,               <b c>, "$n array multi key existing: :k";
    is %h{@bc}:k($ok),          <b c>, "$n array multi key existing: :k(\$ok)";
    is %h{@bc}:!k,              <b c>, "$n array multi key existing: :!k";
    is %h{@bc}:k($no),          <b c>, "$n array multi key existing: :k(\$no)";
    is %h{@bc}:v,               (2,3), "$n array multi key existing: :v";
    is %h{@bc}:v($ok),          (2,3), "$n array multi key existing: :v(\$ok)";
    is %h{@bc}:!v,              (2,3), "$n array multi key existing: :!v";
    is %h{@bc}:v($no),          (2,3), "$n array multi key existing: :v(\$no)";
    is %h{@bc}:kv,      ("b",2,"c",3), "$n array multi key existing: :kv";
    is %h{@bc}:kv($ok), ("b",2,"c",3), "$n array multi key existing: :kv(\$ok)";
    is %h{@bc}:!kv,     ("b",2,"c",3), "$n array multi key existing: :!kv";
    is %h{@bc}:kv($no), ("b",2,"c",3), "$n array multi key existing: :kv(\$no)";
    is %h{@bc}:p,         (b=>2,c=>3), "$n array multi key existing: :p";
    is %h{@bc}:p($ok),    (b=>2,c=>3), "$n array multi key existing: :p(\$ok)";
    is %h{@bc}:!p,        (b=>2,c=>3), "$n array multi key existing: :!p";
    is %h{@bc}:p($no),    (b=>2,c=>3), "$n array multi key existing: :p(\$no)";

    throws-like '%h{@bc}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{@bc}:omelet', X::AdHoc; # caught by MMD
    throws-like '%h{@bc}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# range multiple existing keys
{
    is %h{"b".."c"},                 (2,3), "$n range mult key exist: value";
    is %h{"b".."c"}:k,               <b c>, "$n range mult key exist: :k";
    is %h{"b".."c"}:k($ok),          <b c>, "$n range mult key exist: :k(\$ok)";
    is %h{"b".."c"}:!k,              <b c>, "$n range mult key exist: :!k";
    is %h{"b".."c"}:k($no),          <b c>, "$n range mult key exist: :k(\$no)";
    is %h{"b".."c"}:v,               (2,3), "$n range mult key exist: :v";
    is %h{"b".."c"}:v($ok),          (2,3), "$n range mult key exist: :v(\$ok)";
    is %h{"b".."c"}:!v,              (2,3), "$n range mult key exist: :!v";
    is %h{"b".."c"}:v($no),          (2,3), "$n range mult key exist: :v(\$no)";
    is %h{"b".."c"}:kv,      ("b",2,"c",3), "$n range mult key exist: :kv";
    is %h{"b".."c"}:kv($ok), ("b",2,"c",3), "$n range mult key exist: :kv(\$ok)";
    is %h{"b".."c"}:!kv,     ("b",2,"c",3), "$n range mult key exist: :!kv";
    is %h{"b".."c"}:kv($no), ("b",2,"c",3), "$n range mult key exist: :kv(\$no)";
    is %h{"b".."c"}:p,         (b=>2,c=>3), "$n range mult key exist: :p";
    is %h{"b".."c"}:p($ok),    (b=>2,c=>3), "$n range mult key exist: :p(\$ok)";
    is %h{"b".."c"}:!p,        (b=>2,c=>3), "$n range mult key exist: :!p";
    is %h{"b".."c"}:p($no),    (b=>2,c=>3), "$n range mult key exist: :p(\$no)";

    throws-like '%h{"b".."c"}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{"b".."c"}:rivet', X::AdHoc; # caught by MMD
    throws-like '%h{"b".."c"}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# multiple missing keys
{
    is %h<B C>,                 ($T,$T), "$n multiple key missing: value";
    is %h<B C>:k,                    (), "$n multiple key missing: :k";
    is %h<B C>:k($ok),               (), "$n multiple key missing: :k(\$ok)";
    is %h<B C>:!k,                <B C>, "$n multiple key missing: :!k";
    is %h<B C>:k($no),            <B C>, "$n multiple key missing: :k(\$no)";
    is %h<B C>:v,                    (), "$n multiple key missing: :v";
    is %h<B C>:v($ok),               (), "$n multiple key missing: :v(\$ok)";
    is %h<B C>:!v,              ($T,$T), "$n multiple key missing: :!v";
    is %h<B C>:v($no),          ($T,$T), "$n multiple key missing: :v(\$no)";
    is %h<B C>:kv,                   (), "$n multiple key missing: :kv(\$ok)";
    is %h<B C>:kv($ok),              (), "$n multiple key missing: :kv";
    is %h<B C>:!kv,     ("B",$T,"C",$T), "$n multiple key missing: :!kv";
    is %h<B C>:kv($no), ("B",$T,"C",$T), "$n multiple key missing: :kv(\$no)";
    is %h<B C>:p,                    (), "$n multiple key missing: :p(\$ok)";
    is %h<B C>:p($ok),               (), "$n multiple key missing: :p";
    is %h<B C>:!p,        (B=>$T,C=>$T), "$n multiple key missing: :!p";
    is %h<B C>:p($no),    (B=>$T,C=>$T), "$n multiple key missing: :p(\$no)";

    throws-like '%h<B C>:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h<B C>:echt', X::AdHoc; # caught by MMD
    throws-like '%h<B C>:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# array multiple missing keys
{
    is %h{@BC},                 ($T,$T), "$n array multi key missing: value";
    is %h{@BC}:k,                    (), "$n array multi key missing: :k";
    is %h{@BC}:k($ok),               (), "$n array multi key missing: :k(\$ok)";
    is %h{@BC}:!k,                <B C>, "$n array multi key missing: :!k";
    is %h{@BC}:k($no),            <B C>, "$n array multi key missing: :k(\$no)";
    is %h{@BC}:v,                    (), "$n array multi key missing: :v";
    is %h{@BC}:v($ok),               (), "$n array multi key missing: :v(\$ok)";
    is %h{@BC}:!v,              ($T,$T), "$n array multi key missing: :!v";
    is %h{@BC}:v($no),          ($T,$T), "$n array multi key missing: :v(\$no)";
    is %h{@BC}:kv,                   (), "$n array multi key missing: :kv(\$ok)";
    is %h{@BC}:kv($ok),              (), "$n array multi key missing: :kv";
    is %h{@BC}:!kv,     ("B",$T,"C",$T), "$n array multi key missing: :!kv";
    is %h{@BC}:kv($no), ("B",$T,"C",$T), "$n array multi key missing: :kv(\$no)";
    is %h{@BC}:p,                    (), "$n array multi key missing: :p(\$ok)";
    is %h{@BC}:p($ok),               (), "$n array multi key missing: :p";
    is %h{@BC}:!p,        (B=>$T,C=>$T), "$n array multi key missing: :!p";
    is %h{@BC}:p($no),    (B=>$T,C=>$T), "$n array multi key missing: :p(\$no)";

    throws-like '%h{@BC}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{@BC}:gaston', X::AdHoc; # caught by MMD
    throws-like '%h{@BC}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# range multiple missing keys
{
    is %h{"B".."C"},                 ($T,$T), "$n range mul key miss: value";
    is %h{"B".."C"}:k,                    (), "$n range mul key miss: :k";
    is %h{"B".."C"}:k($ok),               (), "$n range mul key miss: :k(\$ok)";
    is %h{"B".."C"}:!k,                <B C>, "$n range mul key miss: :!k";
    is %h{"B".."C"}:k($no),            <B C>, "$n range mul key miss: :k(\$no)";
    is %h{"B".."C"}:v,                    (), "$n range mul key miss: :v";
    is %h{"B".."C"}:v($ok),               (), "$n range mul key miss: :v(\$ok)";
    is %h{"B".."C"}:!v,              ($T,$T), "$n range mul key miss: :!v";
    is %h{"B".."C"}:v($no),          ($T,$T), "$n range mul key miss: :v(\$no)";
    is %h{"B".."C"}:kv,                   (), "$n range mul key miss: :kv(\$ok)";
    is %h{"B".."C"}:kv($ok),              (), "$n range mul key miss: :kv";
    is %h{"B".."C"}:!kv,     ("B",$T,"C",$T), "$n range mul key miss: :!kv";
    is %h{"B".."C"}:kv($no), ("B",$T,"C",$T), "$n range mul key miss: :kv(\$no)";
    is %h{"B".."C"}:p,                    (), "$n range mul key miss: :p(\$ok)";
    is %h{"B".."C"}:p($ok),               (), "$n range mul key miss: :p";
    is %h{"B".."C"}:!p,        (B=>$T,C=>$T), "$n range mul key miss: :!p";
    is %h{"B".."C"}:p($no),    (B=>$T,C=>$T), "$n range mul key miss: :p(\$no)";

    throws-like '%h{"B".."C"}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{"B".."C"}:noshit', X::AdHoc; # caught by MMD
    throws-like '%h{"B".."C"}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# mixed existing/missing keys
{
    is %h<b C>,                 (2,$T), "$n multiple key mixed: value";
    is %h<b C>:k,                  <b>, "$n multiple key mixed: :k";
    is %h<b C>:k($ok),             <b>, "$n multiple key mixed: :k(\$ok)";
    is %h<b C>:!k,               <b C>, "$n multiple key mixed: :!k";
    is %h<b C>:k($no),           <b C>, "$n multiple key mixed: :k(\$no)";
    is %h<b C>:v,                 (2,), "$n multiple key mixed: :v";
    is %h<b C>:v($ok),            (2,), "$n multiple key mixed: :v(\$ok)";
    is %h<b C>:!v,              (2,$T), "$n multiple key mixed: :!v";
    is %h<b C>:v($no),          (2,$T), "$n multiple key mixed: :v(\$no)";
    is %h<b C>:kv,             ("b",2), "$n multiple key mixed: :kv(\$ok)";
    is %h<b C>:kv($ok),        ("b",2), "$n multiple key mixed: :kv";
    is %h<b C>:!kv,     ("b",2,"C",$T), "$n multiple key mixed: :!kv";
    is %h<b C>:kv($no), ("b",2,"C",$T), "$n multiple key mixed: :kv(\$no)";
    is %h<b C>:p,               (b=>2), "$n multiple key mixed: :p(\$ok)";
    is %h<b C>:p($ok),          (b=>2), "$n multiple key mixed: :p";
    is %h<b C>:!p,        (b=>2,C=>$T), "$n multiple key mixed: :!p";
    is %h<b C>:p($no),    (b=>2,C=>$T), "$n multiple key mixed: :p(\$no)";

    throws-like '%h<b C>:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h<b C>:fnoppo', X::AdHoc; # caught by MMD
    throws-like '%h<b C>:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# array mixed existing/missing keys
{
    is %h{@bC},                 (2,$T), "$n array multiple key mixed: value";
    is %h{@bC}:k,                  <b>, "$n array multiple key mixed: :k";
    is %h{@bC}:k($ok),             <b>, "$n array multiple key mixed: :k(\$ok)";
    is %h{@bC}:!k,               <b C>, "$n array multiple key mixed: :!k";
    is %h{@bC}:k($no),           <b C>, "$n array multiple key mixed: :k(\$no)";
    is %h{@bC}:v,                 (2,), "$n array multiple key mixed: :v";
    is %h{@bC}:v($ok),            (2,), "$n array multiple key mixed: :v(\$ok)";
    is %h{@bC}:!v,              (2,$T), "$n array multiple key mixed: :!v";
    is %h{@bC}:v($no),          (2,$T), "$n array multiple key mixed: :v(\$no)";
    is %h{@bC}:kv,             ("b",2), "$n array multiple key mixed: :kv(\$ok)";
    is %h{@bC}:kv($ok),        ("b",2), "$n array multiple key mixed: :kv";
    is %h{@bC}:!kv,     ("b",2,"C",$T), "$n array multiple key mixed: :!kv";
    is %h{@bC}:kv($no), ("b",2,"C",$T), "$n array multiple key mixed: :kv(\$no)";
    is %h{@bC}:p,               (b=>2), "$n array multiple key mixed: :p(\$ok)";
    is %h{@bC}:p($ok),          (b=>2), "$n array multiple key mixed: :p";
    is %h{@bC}:!p,        (b=>2,C=>$T), "$n array multiple key mixed: :!p";
    is %h{@bC}:p($no),    (b=>2,C=>$T), "$n array multiple key mixed: :p(\$no)";

    throws-like '%h{@bC}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{@bC}:frits', X::AdHoc; # caught by MMD
    throws-like '%h{@bC}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# whatever
{
    is %h{*}.sort,                           (1,2,3,4), "$n whatever: value";
    is (%h{*}:k).sort,                       <a b c d>, "$n whatever: :k";
    is (%h{*}:k($ok)).sort,                  <a b c d>, "$n whatever: :k(\$ok)";
    is (%h{*}:!k).sort,                      <a b c d>, "$n whatever: :!k";
    is (%h{*}:k($no)).sort,                  <a b c d>, "$n whatever: :k(\$no)";
    is (%h{*}:v).sort,                       (1,2,3,4), "$n whatever: :v";
    is (%h{*}:v($ok)).sort,                  (1,2,3,4), "$n whatever: :v(\$ok)";
    is (%h{*}:!v).sort,                      (1,2,3,4), "$n whatever: :!v";
    is (%h{*}:v($no)).sort,                  (1,2,3,4), "$n whatever: :v(\$no)";
    is (%h{*}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$n whatever: :kv(\$ok)";
    is (%h{*}:kv($ok)).sort, (1,2,3,4,"a","b","c","d"), "$n whatever: :kv";
    is (%h{*}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$n whatever: :!kv";
    is (%h{*}:kv($no)).sort, (1,2,3,4,"a","b","c","d"), "$n whatever: :kv(\$no)";
    is (%h{*}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$n whatever: :p(\$ok)";
    is (%h{*}:p($ok)).sort(*.key),   (:1a,:2b,:3c,:4d), "$n whatever: :p";
    is (%h{*}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$n whatever: :!p";
    is (%h{*}:p($no)).sort(*.key),   (:1a,:2b,:3c,:4d), "$n whatever: :p(\$no)";

    throws-like '%h{*}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{*}:whatever', X::AdHoc; # caught by MMD
    throws-like '%h{*}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

# zen
{
    is %h{},                                       %h, "$n zen: value";
    is (%h{}:k).sort,                       <a b c d>, "$n zen: :k";
    is (%h{}:k($ok)).sort,                  <a b c d>, "$n zen: :k(\$ok)";
    is (%h{}:!k).sort,                      <a b c d>, "$n zen: :!k";
    is (%h{}:k($no)).sort,                  <a b c d>, "$n zen: :k(\$no)";
    is (%h{}:v).sort,                       (1,2,3,4), "$n zen: :v";
    is (%h{}:v($ok)).sort,                  (1,2,3,4), "$n zen: :v(\$ok)";
    is (%h{}:!v).sort,                      (1,2,3,4), "$n zen: :!v";
    is (%h{}:v($no)).sort,                  (1,2,3,4), "$n zen: :v(\$no)";
    is (%h{}:kv).sort,      (1,2,3,4,"a","b","c","d"), "$n zen: :kv(\$ok)";
    is (%h{}:kv($ok)).sort, (1,2,3,4,"a","b","c","d"), "$n zen: :kv";
    is (%h{}:!kv).sort,     (1,2,3,4,"a","b","c","d"), "$n zen: :!kv";
    is (%h{}:kv($no)).sort, (1,2,3,4,"a","b","c","d"), "$n zen: :kv(\$no)";
    is (%h{}:p).sort(*.key),        (:1a,:2b,:3c,:4d), "$n zen: :p(\$ok)";
    is (%h{}:p($ok)).sort(*.key),   (:1a,:2b,:3c,:4d), "$n zen: :p";
    is (%h{}:!p).sort(*.key),       (:1a,:2b,:3c,:4d), "$n zen: :!p";
    is (%h{}:p($no)).sort(*.key),   (:1a,:2b,:3c,:4d), "$n zen: :p(\$no)";

    throws-like '%h{}:foo', X::Adverb::Slice,
      :what(%h.name), :unexpected<foo>, :type<{}>;
    throws-like '%h{}:k:v', X::Adverb::Slice,
      :what(%h.name), :nogo(<k v>);
    throws-like '%h{}:kv:p:zip:zop', X::Adverb::Slice,
      :what(%h.name), :nogo(<kv p>), :unexpected(<zip zop>);
} #20

}

# vim: ft=perl6
