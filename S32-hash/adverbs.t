use v6;

use Test;

plan 4 * ( 1 + 17 + 17 + 17 + 17 + 17 + 17 + 17 );

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
} #17

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
} #17

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
} #17

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
} #17

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
} #17

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
} #17

# zen
{
    is %h{}.sort,                   (:1a,:2b,:3c,:4d), "$n zen: value";
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
} #17

}

# vim: ft=perl6
