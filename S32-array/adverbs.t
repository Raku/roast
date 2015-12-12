use v6;

use Test;

plan 2 * ( 1 + 15 * 20 ) + 4;

#-------------------------------------------------------------------------------
# initialisations

my $ok = True;
my $no = False;

sub gen(\a) {
    my Int $i = 0;
    a[$i++] = $_ for 'a'..'d';
    is a.elems, 4, "{a.^name} basic sanity";
}

gen my @n;
gen my Str @s;

my @b  =  1;
my @B  = 11;
my @bc =  1,  2;
my @BC = 11, 12;
my @bC =  1, 12;

#-------------------------------------------------------------------------------
# Array

for $@n, Any, $@s, Str -> @a, $T {
    my $n = @a.VAR.name;

# single existing element
{
    is @a[1],             "b", "$n single elem existing: value";
    is @a[1]:k,             1, "$n single elem existing: :k";
    is @a[1]:k($ok),        1, "$n single elem existing: :k(\$ok)";
    is @a[1]:!k,            1, "$n single elem existing: :!k";
    is @a[1]:k($no),        1, "$n single elem existing: :k(\$no)";
    is @a[1]:v,           "b", "$n single elem existing: :v";
    is @a[1]:v($ok),      "b", "$n single elem existing: :v(\$ok)";
    is @a[1]:!v,          "b", "$n single elem existing: :!v";
    is @a[1]:v($no),      "b", "$n single elem existing: :v(\$no)";
    is @a[1]:kv,      (1,"b"), "$n single elem existing: :kv";
    is @a[1]:kv($ok), (1,"b"), "$n single elem existing: :kv(\$ok)";
    is @a[1]:!kv,     (1,"b"), "$n single elem existing: :!kv";
    is @a[1]:kv($no), (1,"b"), "$n single elem existing: :kv(\$no)";
    is @a[1]:p,      (1=>"b"), "$n single elem existing: :p";
    is @a[1]:p($ok), (1=>"b"), "$n single elem existing: :p(\$ok)";
    is @a[1]:!p,     (1=>"b"), "$n single elem existing: :!p";
    is @a[1]:p($no), (1=>"b"), "$n single elem existing: :p(\$no)";

    throws-like '@a[1]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1]:zorp', Exception; # caught by MMD
    throws-like '@a[1]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single existing element
{
    is @a[@b],          ("b",), "$n array single elem existing: value";
    is @a[@b]:k,          (1,), "$n array single elem existing: :k";
    is @a[@b]:k($ok),     (1,), "$n array single elem existing: :k(\$ok)";
    is @a[@b]:!k,         (1,), "$n array single elem existing: :!k";
    is @a[@b]:k($no),     (1,), "$n array single elem existing: :k(\$no)";
    is @a[@b]:v,        ("b",), "$n array single elem existing: :v";
    is @a[@b]:v($ok),   ("b",), "$n array single elem existing: :v(\$ok)";
    is @a[@b]:!v,       ("b",), "$n array single elem existing: :!v";
    is @a[@b]:v($no),   ("b",), "$n array single elem existing: :v(\$no)";
    is @a[@b]:kv,      (1,"b"), "$n array single elem existing: :kv";
    is @a[@b]:kv($ok), (1,"b"), "$n array single elem existing: :kv(\$ok)";
    is @a[@b]:!kv,     (1,"b"), "$n array single elem existing: :!kv";
    is @a[@b]:kv($no), (1,"b"), "$n array single elem existing: :kv(\$no)";
    is @a[@b]:p,      (1=>"b"), "$n array single elem existing: :p";
    is @a[@b]:p($ok), (1=>"b"), "$n array single elem existing: :p(\$ok)";
    is @a[@b]:!p,     (1=>"b"), "$n array single elem existing: :!p";
    is @a[@b]:p($no), (1=>"b"), "$n array single elem existing: :p(\$no)";

    throws-like '@a[@b]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@b]:zippo', Exception;  # caught by MMD
    throws-like '@a[@b]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# single missing element
{
    is @a[11],              $T, "$n single elem missing: value";
    is @a[11]:k,            (), "$n single elem missing: :k";
    is @a[11]:k($ok),       (), "$n single elem missing: :k(\$ok)";
    is @a[11]:!k,           11, "$n single elem missing: :!k";
    is @a[11]:k($no),       11, "$n single elem missing: :k(\$no)";
    is @a[11]:v,            (), "$n single elem missing: :v";
    is @a[11]:v($ok),       (), "$n single elem missing: :v(\$ok)";
    is @a[11]:!v,           $T, "$n single elem missing: :!v";
    is @a[11]:v($no),       $T, "$n single elem missing: :v(\$no)";
    is @a[11]:kv,           (), "$n single elem missing: :kv(\$ok)";
    is @a[11]:kv($ok),      (), "$n single elem missing: :kv";
    is @a[11]:!kv,     (11,$T), "$n single elem missing: :!kv";
    is @a[11]:kv($no), (11,$T), "$n single elem missing: :kv(\$no)";
    is @a[11]:p,            (), "$n single elem missing: :p(\$ok)";
    is @a[11]:p($ok),       (), "$n single elem missing: :p";
    is @a[11]:!p,     (11=>$T), "$n single elem missing: :!p";
    is @a[11]:p($no), (11=>$T), "$n single elem missing: :p(\$no)";

    throws-like '@a[11]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11]:kabam', Exception;  # caught by MMD
    throws-like '@a[11]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array single missing element
{
    is @a[@B],           ($T,), "$n array single elem missing: value";
    is @a[@B]:k,            (), "$n array single elem missing: :k";
    is @a[@B]:k($ok),       (), "$n array single elem missing: :k(\$ok)";
    is @a[@B]:!k,        (11,), "$n array single elem missing: :!k";
    is @a[@B]:k($no),    (11,), "$n array single elem missing: :k(\$no)";
    is @a[@B]:v,            (), "$n array single elem missing: :v";
    is @a[@B]:v($ok),       (), "$n array single elem missing: :v(\$ok)";
    is @a[@B]:!v,        ($T,), "$n array single elem missing: :!v";
    is @a[@B]:v($no),    ($T,), "$n array single elem missing: :v(\$no)";
    is @a[@B]:kv,           (), "$n array single elem missing: :kv(\$ok)";
    is @a[@B]:kv($ok),      (), "$n array single elem missing: :kv";
    is @a[@B]:!kv,     (11,$T), "$n array single elem missing: :!kv";
    is @a[@B]:kv($no), (11,$T), "$n array single elem missing: :kv(\$no)";
    is @a[@B]:p,            (), "$n array single elem missing: :p(\$ok)";
    is @a[@B]:p($ok),       (), "$n array single elem missing: :p";
    is @a[@B]:!p,     (11=>$T), "$n array single elem missing: :!p";
    is @a[@B]:p($no), (11=>$T), "$n array single elem missing: :p(\$no)";

    throws-like '@a[@B]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@B]:zlonk', Exception;  # caught by MMD
    throws-like '@a[@B]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple existing elems
{
    is @a[1,2],                  <b c>, "$n multiple elem existing: value";
    is @a[1,2]:k,                (1,2), "$n multiple elem existing: :k";
    is @a[1,2]:k($ok),           (1,2), "$n multiple elem existing: :k(\$ok)";
    is @a[1,2]:!k,               (1,2), "$n multiple elem existing: :!k";
    is @a[1,2]:k($no),           (1,2), "$n multiple elem existing: :k(\$no)";
    is @a[1,2]:v,                <b c>, "$n multiple elem existing: :v";
    is @a[1,2]:v($ok),           <b c>, "$n multiple elem existing: :v(\$ok)";
    is @a[1,2]:!v,               <b c>, "$n multiple elem existing: :!v";
    is @a[1,2]:v($no),           <b c>, "$n multiple elem existing: :v(\$no)";
    is @a[1,2]:kv,       (1,"b",2,"c"), "$n multiple elem existing: :kv";
    is @a[1,2]:kv($ok),  (1,"b",2,"c"), "$n multiple elem existing: :kv(\$ok)";
    is @a[1,2]:!kv,      (1,"b",2,"c"), "$n multiple elem existing: :!kv";
    is @a[1,2]:kv($no),  (1,"b",2,"c"), "$n multiple elem existing: :kv(\$no)";
    is @a[1,2]:p,      (1=>"b",2=>"c"), "$n multiple elem existing: :p";
    is @a[1,2]:p($ok), (1=>"b",2=>"c"), "$n multiple elem existing: :p(\$ok)";
    is @a[1,2]:!p,     (1=>"b",2=>"c"), "$n multiple elem existing: :!p";
    is @a[1,2]:p($no), (1=>"b",2=>"c"), "$n multiple elem existing: :p(\$no)";

    throws-like '@a[1,2]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,2]:dirgo', Exception;  # caught by MMD
    throws-like '@a[1,2]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple existing elems
{
    is @a[@bc],                  <b c>, "$n arr multi elem existing: value";
    is @a[@bc]:k,                (1,2), "$n arr multi elem existing: :k";
    is @a[@bc]:k($ok),           (1,2), "$n arr multi elem existing: :k(\$ok)";
    is @a[@bc]:!k,               (1,2), "$n arr multi elem existing: :!k";
    is @a[@bc]:k($no),           (1,2), "$n arr multi elem existing: :k(\$no)";
    is @a[@bc]:v,                <b c>, "$n arr multi elem existing: :v";
    is @a[@bc]:v($ok),           <b c>, "$n arr multi elem existing: :v(\$ok)";
    is @a[@bc]:!v,               <b c>, "$n arr multi elem existing: :!v";
    is @a[@bc]:v($no),           <b c>, "$n arr multi elem existing: :v(\$no)";
    is @a[@bc]:kv,       (1,"b",2,"c"), "$n arr multi elem existing: :kv";
    is @a[@bc]:kv($ok),  (1,"b",2,"c"), "$n arr multi elem existing: :kv(\$ok)";
    is @a[@bc]:!kv,      (1,"b",2,"c"), "$n arr multi elem existing: :!kv";
    is @a[@bc]:kv($no),  (1,"b",2,"c"), "$n arr multi elem existing: :kv(\$no)";
    is @a[@bc]:p,      (1=>"b",2=>"c"), "$n arr multi elem existing: :p";
    is @a[@bc]:p($ok), (1=>"b",2=>"c"), "$n arr multi elem existing: :p(\$ok)";
    is @a[@bc]:!p,     (1=>"b",2=>"c"), "$n arr multi elem existing: :!p";
    is @a[@bc]:p($no), (1=>"b",2=>"c"), "$n arr multi elem existing: :p(\$no)";

    throws-like '@a[@bc]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bc]:fnarg', Exception;  # caught by MMD
    throws-like '@a[@bc]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple existing elems
{
    is @a[1..2],                  <b c>, "$n arr multi elem existing: value";
    is @a[1..2]:k,                (1,2), "$n arr multi elem existing: :k";
    is @a[1..2]:k($ok),           (1,2), "$n arr multi elem existing: :k(\$ok)";
    is @a[1..2]:!k,               (1,2), "$n arr multi elem existing: :!k";
    is @a[1..2]:k($no),           (1,2), "$n arr multi elem existing: :k(\$no)";
    is @a[1..2]:v,                <b c>, "$n arr multi elem existing: :v";
    is @a[1..2]:v($ok),           <b c>, "$n arr multi elem existing: :v(\$ok)";
    is @a[1..2]:!v,               <b c>, "$n arr multi elem existing: :!v";
    is @a[1..2]:v($no),           <b c>, "$n arr multi elem existing: :v(\$no)";
    is @a[1..2]:kv,       (1,"b",2,"c"), "$n arr multi elem existing: :kv";
    is @a[1..2]:kv($ok),  (1,"b",2,"c"), "$n arr multi elem existing: :kv(\$ok)";
    is @a[1..2]:!kv,      (1,"b",2,"c"), "$n arr multi elem existing: :!kv";
    is @a[1..2]:kv($no),  (1,"b",2,"c"), "$n arr multi elem existing: :kv(\$no)";
    is @a[1..2]:p,      (1=>"b",2=>"c"), "$n arr multi elem existing: :p";
    is @a[1..2]:p($ok), (1=>"b",2=>"c"), "$n arr multi elem existing: :p(\$ok)";
    is @a[1..2]:!p,     (1=>"b",2=>"c"), "$n arr multi elem existing: :!p";
    is @a[1..2]:p($no), (1=>"b",2=>"c"), "$n arr multi elem existing: :p(\$no)";

    throws-like '@a[1..2]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1..2]:fnarg', Exception;  # caught by MMD
    throws-like '@a[1..2]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# multiple missing elems
{
    is @a[11,12],                 ($T,$T), "$n multiple elem missing: value";
    is @a[11,12]:k,                    (), "$n multiple elem missing: :k";
    is @a[11,12]:k($ok),               (), "$n multiple elem missing: :k(\$ok)";
    is @a[11,12]:!k,              (11,12), "$n multiple elem missing: :!k";
    is @a[11,12]:k($no),          (11,12), "$n multiple elem missing: :k(\$no)";
    is @a[11,12]:v,                    (), "$n multiple elem missing: :v";
    is @a[11,12]:v($ok),               (), "$n multiple elem missing: :v(\$ok)";
    is @a[11,12]:!v,              ($T,$T), "$n multiple elem missing: :!v";
    is @a[11,12]:v($no),          ($T,$T), "$n multiple elem missing: :v(\$no)";
    is @a[11,12]:kv,                   (), "$n multiple elem missing: :kv(\$ok)";
    is @a[11,12]:kv($ok),              (), "$n multiple elem missing: :kv";
    is @a[11,12]:!kv,       (11,$T,12,$T), "$n multiple elem missing: :!kv";
    is @a[11,12]:kv($no),   (11,$T,12,$T), "$n multiple elem missing: :kv(\$no)";
    is @a[11,12]:p,                    (), "$n multiple elem missing: :p(\$ok)";
    is @a[11,12]:p($ok),               (), "$n multiple elem missing: :p";
    is @a[11,12]:!p,      (11=>$T,12=>$T), "$n multiple elem missing: :!p";
    is @a[11,12]:p($no),  (11=>$T,12=>$T), "$n multiple elem missing: :p(\$no)";

    throws-like '@a[11,12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11,12]:zniknop', Exception;  # caught by MMD
    throws-like '@a[11,12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array multiple missing elems
{
    is @a[@BC],                 ($T,$T), "$n arr multi elem missing: value";
    is @a[@BC]:k,                    (), "$n arr multi elem missing: :k";
    is @a[@BC]:k($ok),               (), "$n arr multi elem missing: :k(\$ok)";
    is @a[@BC]:!k,              (11,12), "$n arr multi elem missing: :!k";
    is @a[@BC]:k($no),          (11,12), "$n arr multi elem missing: :k(\$no)";
    is @a[@BC]:v,                    (), "$n arr multi elem missing: :v";
    is @a[@BC]:v($ok),               (), "$n arr multi elem missing: :v(\$ok)";
    is @a[@BC]:!v,              ($T,$T), "$n arr multi elem missing: :!v";
    is @a[@BC]:v($no),          ($T,$T), "$n arr multi elem missing: :v(\$no)";
    is @a[@BC]:kv,                   (), "$n arr multi elem missing: :kv(\$ok)";
    is @a[@BC]:kv($ok),              (), "$n arr multi elem missing: :kv";
    is @a[@BC]:!kv,       (11,$T,12,$T), "$n arr multi elem missing: :!kv";
    is @a[@BC]:kv($no),   (11,$T,12,$T), "$n arr multi elem missing: :kv(\$no)";
    is @a[@BC]:p,                    (), "$n arr multi elem missing: :p(\$ok)";
    is @a[@BC]:p($ok),               (), "$n arr multi elem missing: :p";
    is @a[@BC]:!p,      (11=>$T,12=>$T), "$n arr multi elem missing: :!p";
    is @a[@BC]:p($no),  (11=>$T,12=>$T), "$n arr multi elem missing: :p(\$no)";

    throws-like '@a[@BC]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@BC]:lotne', Exception;  # caught by MMD
    throws-like '@a[@BC]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# range multiple missing elems
{
    # lazy ranges *always* auto-truncate
    is @a[lazy 11..12],                      (), "$n ran multi elem miss: value";
    is @a[lazy 11..12]:k,                    (), "$n ran multi elem miss: :k";
    is @a[lazy 11..12]:k($ok),               (), "$n ran multi elem miss: :k(\$ok)";
    is @a[lazy 11..12]:!k,                   (), "$n ran multi elem miss: :!k";
    is @a[lazy 11..12]:k($no),               (), "$n ran multi elem miss: :k(\$no)";
    is @a[lazy 11..12]:v,                    (), "$n ran multi elem miss: :v";
    is @a[lazy 11..12]:v($ok),               (), "$n ran multi elem miss: :v(\$ok)";
    is @a[lazy 11..12]:!v,                   (), "$n ran multi elem miss: :!v";
    is @a[lazy 11..12]:v($no),               (), "$n ran multi elem miss: :v(\$no)";
    is @a[lazy 11..12]:kv,                   (), "$n ran multi elem miss: :kv(\$ok)";
    is @a[lazy 11..12]:kv($ok),              (), "$n ran multi elem miss: :kv";
    is @a[lazy 11..12]:!kv,                  (), "$n ran multi elem miss: :!kv";
    is @a[lazy 11..12]:kv($no),              (), "$n ran multi elem miss: :kv(\$no)";
    is @a[lazy 11..12]:p,                    (), "$n ran multi elem miss: :p(\$ok)";
    is @a[lazy 11..12]:p($ok),               (), "$n ran multi elem miss: :p";
    is @a[lazy 11..12]:!p,                   (), "$n ran multi elem miss: :!p";
    is @a[lazy 11..12]:p($no),               (), "$n ran multi elem miss: :p(\$no)";

    throws-like '@a[11..12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[11..12]:bolton', Exception;  # caught by MMD
    throws-like '@a[11..12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# mixed existing/missing elems
{
    is @a[1,12],               ("b",$T), "$n multiple elem mixed: value";
    is @a[1,12]:k,                 (1,), "$n multiple elem mixed: :k";
    is @a[1,12]:k($ok),            (1,), "$n multiple elem mixed: :k(\$ok)";
    is @a[1,12]:!k,              (1,12), "$n multiple elem mixed: :!k";
    is @a[1,12]:k($no),          (1,12), "$n multiple elem mixed: :k(\$no)";
    is @a[1,12]:v,               ("b",), "$n multiple elem mixed: :v";
    is @a[1,12]:v($ok),          ("b",), "$n multiple elem mixed: :v(\$ok)";
    is @a[1,12]:!v,            ("b",$T), "$n multiple elem mixed: :!v";
    is @a[1,12]:v($no),        ("b",$T), "$n multiple elem mixed: :v(\$no)";
    is @a[1,12]:kv,             (1,"b"), "$n multiple elem mixed: :kv(\$ok)";
    is @a[1,12]:kv($ok),        (1,"b"), "$n multiple elem mixed: :kv";
    is @a[1,12]:!kv,      (1,"b",12,$T), "$n multiple elem mixed: :!kv";
    is @a[1,12]:kv($no),  (1,"b",12,$T), "$n multiple elem mixed: :kv(\$no)";
    is @a[1,12]:p,             (1=>"b"), "$n multiple elem mixed: :p(\$ok)";
    is @a[1,12]:p($ok),        (1=>"b"), "$n multiple elem mixed: :p";
    is @a[1,12]:!p,     (1=>"b",12=>$T), "$n multiple elem mixed: :!p";
    is @a[1,12]:p($no), (1=>"b",12=>$T), "$n multiple elem mixed: :p(\$no)";

    throws-like '@a[1,12]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[1,12]:notlob', Exception;  # caught by MMD
    throws-like '@a[1,12]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# array mixed existing/missing elems
{
    is @a[@bC],               ("b",$T), "$n arr multi elem mixed: value";
    is @a[@bC]:k,                 (1,), "$n arr multi elem mixed: :k";
    is @a[@bC]:k($ok),            (1,), "$n arr multi elem mixed: :k(\$ok)";
    is @a[@bC]:!k,              (1,12), "$n arr multi elem mixed: :!k";
    is @a[@bC]:k($no),          (1,12), "$n arr multi elem mixed: :k(\$no)";
    is @a[@bC]:v,               ("b",), "$n arr multi elem mixed: :v";
    is @a[@bC]:v($ok),          ("b",), "$n arr multi elem mixed: :v(\$ok)";
    is @a[@bC]:!v,            ("b",$T), "$n arr multi elem mixed: :!v";
    is @a[@bC]:v($no),        ("b",$T), "$n arr multi elem mixed: :v(\$no)";
    is @a[@bC]:kv,             (1,"b"), "$n arr multi elem mixed: :kv(\$ok)";
    is @a[@bC]:kv($ok),        (1,"b"), "$n arr multi elem mixed: :kv";
    is @a[@bC]:!kv,      (1,"b",12,$T), "$n arr multi elem mixed: :!kv";
    is @a[@bC]:kv($no),  (1,"b",12,$T), "$n arr multi elem mixed: :kv(\$no)";
    is @a[@bC]:p,             (1=>"b"), "$n arr multi elem mixed: :p(\$ok)";
    is @a[@bC]:p($ok),        (1=>"b"), "$n arr multi elem mixed: :p";
    is @a[@bC]:!p,     (1=>"b",12=>$T), "$n arr multi elem mixed: :!p";
    is @a[@bC]:p($no), (1=>"b",12=>$T), "$n arr multi elem mixed: :p(\$no)";

    throws-like '@a[@bC]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[@bC]:cheese', Exception;  # caught by MMD
    throws-like '@a[@bC]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# Callable
{
    is @a[*-1],                                  <d>, "$n callable: value";
    is @a[*-1]:k,                                (3), "$n callable: :k";
    is @a[*-1]:k($ok),                           (3), "$n callable: :k(\$ok)";
    is @a[*-1]:!k,                               (3), "$n callable: :!k";
    is @a[*-1]:k($no),                           (3), "$n callable: :k(\$no)";
    is @a[*-1]:v,                                <d>, "$n callable: :v";
    is @a[*-1]:v($ok),                           <d>, "$n callable: :v(\$ok)";
    is @a[*-1]:!v,                               <d>, "$n callable: :!v";
    is @a[*-1]:v($no),                           <d>, "$n callable: :v(\$no)";
    is @a[*-1]:kv,                           (3,"d"), "$n callable: :kv(\$ok)";
    is @a[*-1]:kv($ok),                      (3,"d"), "$n callable: :kv";
    is @a[*-1]:!kv,                          (3,"d"), "$n callable: :!kv";
    is @a[*-1]:kv($no),                      (3,"d"), "$n callable: :kv(\$no)";
    is @a[*-1]:p,                           (3=>"d"), "$n callable: :p(\$ok)";
    is @a[*-1]:p($ok),                      (3=>"d"), "$n callable: :p";
    is @a[*-1]:!p,                          (3=>"d"), "$n callable: :!p";
    is @a[*-1]:p($no),                      (3=>"d"), "$n callable: :p(\$no)";

    throws-like '@a[*-1]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[*-1]:callable', Exception;  # caught by MMD
    throws-like '@a[*-1]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# whatever
{
    is @a[*],                            <a b c d>, "$n whatever: value";
    is @a[*]:k,                          (0,1,2,3), "$n whatever: :k";
    is @a[*]:k($ok),                     (0,1,2,3), "$n whatever: :k(\$ok)";
    is @a[*]:!k,                         (0,1,2,3), "$n whatever: :!k";
    is @a[*]:k($no),                     (0,1,2,3), "$n whatever: :k(\$no)";
    is @a[*]:v,                          <a b c d>, "$n whatever: :v";
    is @a[*]:v($ok),                     <a b c d>, "$n whatever: :v(\$ok)";
    is @a[*]:!v,                         <a b c d>, "$n whatever: :!v";
    is @a[*]:v($no),                     <a b c d>, "$n whatever: :v(\$no)";
    is @a[*]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$n whatever: :kv(\$ok)";
    is @a[*]:kv($ok),    (0,"a",1,"b",2,"c",3,"d"), "$n whatever: :kv";
    is @a[*]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$n whatever: :!kv";
    is @a[*]:kv($no),    (0,"a",1,"b",2,"c",3,"d"), "$n whatever: :kv(\$no)";
    is @a[*]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$n whatever: :p(\$ok)";
    is @a[*]:p($ok), (0=>"a",1=>"b",2=>"c",3=>"d"), "$n whatever: :p";
    is @a[*]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$n whatever: :!p";
    is @a[*]:p($no), (0=>"a",1=>"b",2=>"c",3=>"d"), "$n whatever: :p(\$no)";

    throws-like '@a[*]:k:v', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<k v>);
    throws-like '@a[*]:sourceever', Exception;  # caught by MMD
    throws-like '@a[*]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

# zen
{
    is @a[],                                   @a, "$n zen: value";
    is @a[]:k,                          (0,1,2,3), "$n zen: :k";
    is @a[]:k($ok),                     (0,1,2,3), "$n zen: :k(\$ok)";
    is @a[]:!k,                         (0,1,2,3), "$n zen: :!k";
    is @a[]:k($no),                     (0,1,2,3), "$n zen: :k(\$no)";
    is @a[]:v,                          <a b c d>, "$n zen: :v";
    is @a[]:v($ok),                     <a b c d>, "$n zen: :v(\$ok)";
    is @a[]:!v,                         <a b c d>, "$n zen: :!v";
    is @a[]:v($no),                     <a b c d>, "$n zen: :v(\$no)";
    is @a[]:kv,         (0,"a",1,"b",2,"c",3,"d"), "$n zen: :kv(\$ok)";
    is @a[]:kv($ok),    (0,"a",1,"b",2,"c",3,"d"), "$n zen: :kv";
    is @a[]:!kv,        (0,"a",1,"b",2,"c",3,"d"), "$n zen: :!kv";
    is @a[]:kv($no),    (0,"a",1,"b",2,"c",3,"d"), "$n zen: :kv(\$no)";
    is @a[]:p,      (0=>"a",1=>"b",2=>"c",3=>"d"), "$n zen: :p(\$ok)";
    is @a[]:p($ok), (0=>"a",1=>"b",2=>"c",3=>"d"), "$n zen: :p";
    is @a[]:!p,     (0=>"a",1=>"b",2=>"c",3=>"d"), "$n zen: :!p";
    is @a[]:p($no), (0=>"a",1=>"b",2=>"c",3=>"d"), "$n zen: :p(\$no)";

    throws-like '@a[]:foo', X::Adverb,
      :source(@a.name), :what('[] slice'), :unexpected<foo>,
    throws-like '@a[]:k:v', X::Adverb,
      :source(@a.name), :nogo(<k v>);
    throws-like '@a[]:kv:p:zip:zop', X::Adverb,
      :source(@a.name), :what<slice>, :nogo(<kv p>), :unexpected({m/"zip"/ && m/"zop"/});
} #20

}

# RT #126507
{
    my @a;
    @a[$(7,8,9)] = 101;
    is @a.elems, 4, 'container respected in array assign';
    is @a[$(7,8,9)], 101, 'container respected in array access';
    is @a[$(7,8,9)]:exists, True, 'container respected in array :exists';
    @a[$(7,8,9)]:delete;
    is @a[$(7,8,9)]:exists, False, 'container respected in array :delete';
}

# vim: ft=perl6
