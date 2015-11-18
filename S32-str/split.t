use v6;

use Test;

# L<S32-setting-library/Str"=item split">

plan 57;

# Legend:
# r   result
# l   with limit
# v   with :v
# k   with :k
# kv  with :kv
# p   with :p
# se  with :skip-empty
sub test($string,$splitter,$limit,$comment,
  $r, $rv, $rk, $rkv, $rp, $rse, $rvse, $rkse, $rkvse, $rpse,
  $rl,$rlv,$rlk,$rlkv,$rlp,$rlse,$rlvse,$rlkse,$rlkvse,$rlpse,
) {
    subtest {
        plan 41;

        my $original = $string;

        is split($splitter,$string), $r,
          "split($splitter.perl(),$string.perl())";
        is $string.split($splitter), $r,
          "{$string.perl}.split($splitter.perl())";

        is split($splitter,$string,:v), $rv,
          "split($splitter.perl(),$string.perl(),:v)";
        is $string.split($splitter,:v), $rv,
          "{$string.perl}.split($splitter.perl(),:v)";

        is split($splitter,$string,:k), $rk,
          "split($splitter.perl(),$string.perl(),:k)";
        is $string.split($splitter,:k), $rk,
          "{$string.perl}.split($splitter.perl(),:k)";

        is split($splitter,$string,:kv), $rkv,
          "split($splitter.perl(),$string.perl(),:kv)";
        is $string.split($splitter,:kv), $rkv,
          "{$string.perl}.split($splitter.perl(),:kv)";

        is split($splitter,$string,:p), $rp,
          "split($splitter.perl(),$string.perl(),:p)";
        is $string.split($splitter,:p), $rp,
          "{$string.perl}.split($splitter.perl(),:p)";

        is split($splitter,$string,:skip-empty), $rse,
          "split($splitter.perl(),$string.perl(),:skip-empty)";
        is $string.split($splitter,:skip-empty), $rse,
          "{$string.perl}.split($splitter.perl(),:skip-empty)";

        is split($splitter,$string,:v,:skip-empty), $rvse,
          "split($splitter.perl(),$string.perl(),:v,:skip-empty)";
        is $string.split($splitter,:v,:skip-empty), $rvse,
          "{$string.perl}.split($splitter.perl(),:v,:skip-empty)";

        is split($splitter,$string,:k,:skip-empty), $rkse,
          "split($splitter.perl(),$string.perl(),:k,:skip-empty)";
        is $string.split($splitter,:k,:skip-empty), $rkse,
          "{$string.perl}.split($splitter.perl(),:k,:skip-empty)";

        is split($splitter,$string,:kv,:skip-empty), $rkvse,
          "split($splitter.perl(),$string.perl(),:kv,:skip-empty)";
        is $string.split($splitter,:kv,:skip-empty), $rkvse,
          "{$string.perl}.split($splitter.perl(),:kv,:skip-empty)";

        is split($splitter,$string,:p,:skip-empty), $rpse,
          "split($splitter.perl(),$string.perl(),:p,:skip-empty)";
        is $string.split($splitter,:p,:skip-empty), $rpse,
          "{$string.perl}.split($splitter.perl(),:p,:skip-empty)";

        is split($splitter,$string,$limit), $rl,
          "split($splitter.perl(),$string.perl(),$limit)";
        is $string.split($splitter,$limit), $rl,
          "{$string.perl}.split($splitter.perl(),$limit)";

        is split($splitter,$string,$limit,:v), $rlv,
          "split($splitter.perl(),$string.perl(),$limit,:v)";
        is $string.split($splitter,$limit,:v), $rlv,
          "{$string.perl}.split($splitter.perl(),$limit,:v)";

        is split($splitter,$string,$limit,:k), $rlk,
          "split($splitter.perl(),$string.perl(),$limit,:k)";
        is $string.split($splitter,$limit,:k), $rlk,
          "{$string.perl}.split($splitter.perl(),$limit,:k)";

        is split($splitter,$string,$limit,:kv), $rlkv,
          "split($splitter.perl(),$string.perl(),$limit,:kv)";
        is $string.split($splitter,$limit,:kv), $rlkv,
          "{$string.perl}.split($splitter.perl(),$limit,:kv)";

        is split($splitter,$string,$limit,:p), $rlp,
          "split($splitter.perl(),$string.perl(),$limit,:p)";
        is $string.split($splitter,$limit,:p), $rlp,
          "{$string.perl}.split($splitter.perl(),$limit,:p)";

        is split($splitter,$string,$limit,:skip-empty), $rlse,
          "split($splitter.perl(),$string.perl(),$limit,:split-empty)";
        is $string.split($splitter,$limit,:skip-empty), $rlse,
          "{$string.perl}.split($splitter.perl(),$limit,:split-empty)";

        is split($splitter,$string,$limit,:v,:skip-empty), $rlvse,
          "split($splitter.perl(),$string.perl(),$limit,:v,:skip-empty)";
        is $string.split($splitter,$limit,:v,:skip-empty), $rlvse,
          "{$string.perl}.split($splitter.perl(),$limit,:v,:skip-empty)";

        is split($splitter,$string,$limit,:k,:skip-empty), $rlkse,
          "split($splitter.perl(),$string.perl(),$limit,:k,:skip-empty)";
        is $string.split($splitter,$limit,:k,:skip-empty), $rlkse,
          "{$string.perl}.split($splitter.perl(),$limit,:k,:skip-empty)";

        is split($splitter,$string,$limit,:kv,:skip-empty), $rlkvse,
          "split($splitter.perl(),$string.perl(),$limit,:kv,:skip-empty)";
        is $string.split($splitter,$limit,:kv,:skip-empty), $rlkvse,
          "{$string.perl}.split($splitter.perl(),$limit,:kv,:skip-empty)";

        is split($splitter,$string,$limit,:p,:skip-empty), $rlpse,
          "split($splitter.perl(),$string.perl(),$limit,:p,:skip-empty)";
        is $string.split($splitter,$limit,:p,:skip-empty), $rlpse,
          "{$string.perl}.split($splitter.perl(),$limit,:p,:skip-empty)";

        is $string, $original, "string did not get changed";
    }, "tested $string.perl() with $comment.perl()";
}

test( "abcde","",3,"empty string",
  <<"" a b c d e "">>, # r
  <<"" a b c d e "">>, # rv
  <<"" a b c d e "">>, # rk
  <<"" a b c d e "">>, # rkv
  <<"" a b c d e "">>, # rp
  <a b c d e>,         # rse
  <a b c d e>,         # rvse
  <a b c d e>,         # rkse
  <a b c d e>,         # rkvse
  <a b c d e>,         # rpse

  <<"" a bcde>>, # rl
  <<"" a bcde>>, # rlv
  <<"" a bcde>>, # rlk
  <<"" a bcde>>, # rlkv
  <<"" a bcde>>, # rlp
  <a bcde>,      # rlse
  <a bcde>,      # rlvse
  <a bcde>,      # rlkse
  <a bcde>,      # rlkvse
  <a bcde>,      # rlpse
);

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 1
test( "abcd",/./,3,"any character",
  <<"" "" "" "" "">>,                           # r
  <<"" a "" b "" c "" d "">>,                   # rv
  <<"" 0 "" 0 "" 0 "" 0 "">>,                   # rk
  <<"" 0 a "" 0 b "" 0 c "" 0 d "">>,           # rkv
  ("",0=>"a","",0=>"b","",0=>"c","",0=>"d",""), # rp
  (),                                           # rse
  <a b c d>,                                    # rvse
  <0 0 0 0>,                                    # rkse
  <0 a 0 b 0 c 0 d>,                            # rkvse
  (0=>"a",0=>"b",0=>"c",0=>"d"),                # rpse

  <<"" "" cd>>,               # rl
  <<"" a "" b cd>>,           # rlv
  <<"" 0 "" 0 cd>>,           # rlk
  <<"" 0 a "" 0 b cd>>,       # rlkv
  ("",0=>"a","",0=>"b","cd"), # rlp
  <cd>,                       # rlse
  <a b cd>,                   # rlvse
  <0 0 cd>,                   # rlkse
  <0 a 0 b cd>,               # rlkvse
  (0=>"a",0=>"b","cd"),       # rlpse
);

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 3
test( "aaaa",$_,3,"only chars matching $_.perl()",
  <<"" "" "" "" "">>,                           # r
  <<"" a "" a "" a "" a "">>,                   # rv
  <<"" 0 "" 0 "" 0 "" 0 "">>,                   # rk
  <<"" 0 a "" 0 a "" 0 a "" 0 a "">>,           # rkv
  ("",0=>"a","",0=>"a","",0=>"a","",0=>"a",""), # rp
  (),                                           # rse
  <a a a a>,                                    # rvse
  <0 0 0 0>,                                    # rkse
  <0 a 0 a 0 a 0 a>,                            # rkvse
  (0=>"a",0=>"a",0=>"a",0=>"a"),                # rpse

  <<"" "" aa>>,               # rl
  <<"" a "" a aa>>,           # rlv
  <<"" 0 "" 0 aa>>,           # rlk
  <<"" 0 a "" 0 a aa>>,       # rlkv
  ("",0=>"a","",0=>"a","aa"), # rlp
  <aa>,                       # rlse
  <a a aa>,                   # rlvse
  <0 0 aa>,                   # rlkse
  <0 a 0 a aa>,               # rlkvse
  (0=>"a",0=>"a","aa"),       # rlpse
) for "a", /a/, rx:Perl5/a/;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 7
test( "foo bar baz",$_,2,$_,
  <foo bar baz>,                     # r
  <<foo " " bar " " baz>>,           # rv
  <foo 0 bar 0 baz>,                 # rk
  <<foo 0 " " bar 0 " " baz>>,       # rkv
  ("foo",0=>" ","bar",0=>" ","baz"), # rp
  <foo bar baz>,                     # rse
  <<foo " " bar " " baz>>,           # rvse
  <foo 0 bar 0 baz>,                 # rkse
  <<foo 0 " " bar 0 " " baz>>,       # rkvse
  ("foo",0=>" ","bar",0=>" ","baz"), # rpse

  <<foo "bar baz">>,        # rl
  <<foo " " "bar baz">>,    # rlv
  <<foo 0 "bar baz">>,      # rlk
  <<foo 0 " " "bar baz">>,  # rlkv
  ("foo",0=>" ","bar baz"), # rlp
  <<foo "bar baz">>,        # rlse
  <<foo " " "bar baz">>,    # rlvse
  <<foo 0 "bar baz">>,      # rlkse
  <<foo 0 " " "bar baz">>,  # rlkvse
  ("foo",0=>" ","bar baz"), # rlpse
) for " ", / " " /, / \s /, / \s+ /, rx:Perl5/ /, rx:Perl5/\s/, rx:Perl5/\s+/;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 2
test( "thisisit",$_,2,$_,
  <thi i it>,                     # r
  <thi s i s it>,                 # rv
  <thi 0 i 0 it>,                 # rk
  <thi 0 s i 0 s it>,             # rkv
  ("thi",0=>"s","i",0=>"s","it"), # rp
  <thi i it>,                     # rse
  <thi s i s it>,                 # rvse
  <thi 0 i 0 it>,                 # rkse
  <thi 0 s i 0 s it>,             # rkvse
  ("thi",0=>"s","i",0=>"s","it"), # rpse

  <thi isit>,            # rl
  <thi s isit>,          # rlv
  <thi 0 isit>,          # rlk
  <thi 0 s isit>,        # rlkv
  ("thi",0=>"s","isit"), # rlp
  <thi isit>,            # rlse
  <thi s isit>,          # rlvse
  <thi 0 isit>,          # rlkse
  <thi 0 s isit>,        # rlkvse
  ("thi",0=>"s","isit"), # rlpse
) for "s", /s/;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 2
test( "|foo|bar|baz|zoo",$_,3,$_,
  <<"" foo bar baz zoo>>,                                   # r
  <<"" | foo | bar | baz | zoo>>,                           # rv
  <<"" 0 foo 0 bar 0 baz 0 zoo>>,                           # rk
  <<"" 0 | foo 0 | bar 0 | baz 0 | zoo>>,                   # rkv
  ("",0=>"|","foo",0=>"|","bar",0=>"|","baz",0=>"|","zoo"), # rp
  <foo bar baz zoo>,                                        # rse
  <| foo | bar | baz | zoo>,                                # rvse
  <0 foo 0 bar 0 baz 0 zoo>,                                # rkse
  <0 | foo 0 | bar 0 | baz 0 | zoo>,                        # rkvse
  (0=>"|","foo",0=>"|","bar",0=>"|","baz",0=>"|","zoo"),    # rpse

  <<"" foo bar|baz|zoo>>,                 # rl
  <<"" | foo | bar|baz|zoo>>,             # rlv
  <<"" 0 foo 0 bar|baz|zoo>>,             # rlk
  <<"" 0 | foo 0 | bar|baz|zoo>>,         # rlkv
  ("",0=>"|","foo",0=>"|","bar|baz|zoo"), # rlp
  <foo bar|baz|zoo>,                      # rlse
  <| foo | bar|baz|zoo>,                  # rlvse
  <0 foo 0 bar|baz|zoo>,                  # rlkse
  <0 | foo 0 | bar|baz|zoo>,              # rlkvse
  (0=>"|","foo",0=>"|","bar|baz|zoo"),    # rlpse
) for "|", / \| /;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 3
test( "foo|bar|baz|zoo|",$_,2,$_,
  <<foo bar baz zoo "">>,                                   # r
  <<foo | bar | baz | zoo | "">>,                           # rv
  <<foo 0 bar 0 baz 0 zoo 0 "">>,                           # rk
  <<foo 0 | bar 0 | baz 0 | zoo 0 | "">>,                   # rkv
  ("foo",0=>"|","bar",0=>"|","baz",0=>"|","zoo",0=>"|",""), # rp
  <foo bar baz zoo>,                                        # rse
  <foo | bar | baz | zoo |>,                                # rvse
  <foo 0 bar 0 baz 0 zoo 0>,                                # rkse
  <foo 0 | bar 0 | baz 0 | zoo 0 |>,                        # rkvse
  ("foo",0=>"|","bar",0=>"|","baz",0=>"|","zoo",0=>"|"),    # rpse

  <<foo bar|baz|zoo|>>,          # rl
  <<foo | bar|baz|zoo|>>,        # rlv
  <<foo 0 bar|baz|zoo|>>,        # rlk
  <<foo 0 | bar|baz|zoo|>>,      # rlkv
  ("foo",0=>"|","bar|baz|zoo|"), # rlp
  <foo bar|baz|zoo|>,            # rlse
  <foo | bar|baz|zoo|>,          # rlvse
  <foo 0 bar|baz|zoo|>,          # rlkse
  <foo 0 | bar|baz|zoo|>,        # rlkvse
  ("foo",0=>"|","bar|baz|zoo|"), # rlpse
) for "|", / \| /, rx:Perl5/\|/;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 7
test( "comma, separated, values",$_,2,$_,
  <comma separated values>,                       # r
  <<comma ", " separated ", " values>>,           # rv
  <comma 0 separated 0 values>,                   # rk
  <<comma 0 ", " separated 0 ", " values>>,       # rkv
  ("comma",0=>", ","separated",0=>", ","values"), # rp
  <comma separated values>,                       # rse
  <<comma ", " separated ", " values>>,           # rvse
  <comma 0 separated 0 values>,                   # rkse
  <<comma 0 ", " separated 0 ", " values>>,       # rkvse
  ("comma",0=>", ","separated",0=>", ","values"), # rpse

  <<comma "separated, values">>,         # rl
  <<comma ", " "separated, values">>,    # rlv
  <<comma 0 "separated, values">>,       # rlk
  <<comma 0 ", " "separated, values">>,  # rlkv
  ("comma",0=>", ","separated, values"), # rlp
  <<comma "separated, values">>,         # rlse
  <<comma ", " "separated, values">>,    # rlvse
  <<comma 0 "separated, values">>,       # rlkse
  <<comma 0 ", " "separated, values">>,  # rlkvse
  ("comma",0=>", ","separated, values"), # rlpse
) for ", ", / ", " /, / "," \s /, / "," \s+ /,
    rx:Perl5/, /, rx:Perl5/,\s/, rx:Perl5/,\s+/;

# blessed by $Larry at Message-ID: <20060118191046.GB32562@wall.org>
test("",$_,2,$_, |("" xx 20)
) for "a", /a/, "ab", /ab/, <a b>, /a|b/, /\s/, rx:Perl5/\s/;

test("","",2,"empty string", |(() xx 20));
test("","foo",2,"empty string", |(() xx 20));
test("zzzzz","a",2,"no match",|(("zzzzz",) xx 20));

test( "hello world",<a e i o u>,3,<a e i o u>,
  <<h ll " w" rld>>,                          # r
  <<h e ll o " w" o rld>>,                    # rv
  <<h 1 ll 3 " w" 3 rld>>,                    # rk
  <<h 1 e ll 3 o " w" 3 o rld>>,              # rkv
  ("h",1=>"e","ll",3=>"o"," w",3=>"o","rld"), # rp
  <<h ll " w" rld>>,                          # rse
  <<h e ll o " w" o rld>>,                    # rvse
  <<h 1 ll 3 " w" 3 rld>>,                    # rkse
  <<h 1 e ll 3 o " w" 3 o rld>>,              # rkvse
  ("h",1=>"e","ll",3=>"o"," w",3=>"o","rld"), # rpse

  <<h ll " world">>,                 # rl
  <<h e ll o " world">>,             # rlv
  <<h 1 ll 3 " world">>,             # rlk
  <<h 1 e ll 3 o " world">>,         # rlkv
  ("h",1=>"e","ll",3=>"o"," world"), # rlp
  <<h ll " world">>,                 # rlse
  <<h e ll o " world">>,             # rlvse
  <<h 1 ll 3 " world">>,             # rlkse
  <<h 1 e ll 3 o " world">>,         # rlkvse
  ("h",1=>"e","ll",3=>"o"," world"), # rlpse
);

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 2
test( "hello world",$_,3,$_,
  <<h ll " w" rld>>,                          # r
  <<h e ll o " w" o rld>>,                    # rv
  <<h 0 ll 0 " w" 0 rld>>,                    # rk
  <<h 0 e ll 0 o " w" 0 o rld>>,              # rkv
  ("h",0=>"e","ll",0=>"o"," w",0=>"o","rld"), # rp
  <<h ll " w" rld>>,                          # rse
  <<h e ll o " w" o rld>>,                    # rvse
  <<h 0 ll 0 " w" 0 rld>>,                    # rkse
  <<h 0 e ll 0 o " w" 0 o rld>>,              # rkvse
  ("h",0=>"e","ll",0=>"o"," w",0=>"o","rld"), # rpse

  <<h ll " world">>,                 # rl
  <<h e ll o " world">>,             # rlv
  <<h 0 ll 0 " world">>,             # rlk
  <<h 0 e ll 0 o " world">>,         # rlkv
  ("h",0=>"e","ll",0=>"o"," world"), # rlp
  <<h ll " world">>,                 # rlse
  <<h e ll o " world">>,             # rlvse
  <<h 0 ll 0 " world">>,             # rlkse
  <<h 0 e ll 0 o " world">>,         # rlkvse
  ("h",0=>"e","ll",0=>"o"," world"), # rlpse
) for /<[aeiou]>/, rx:Perl5/[aeiou]/;

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
{
    my @a = "hello world".split(/<[aeiou]>/, :v);
    is +@a, 7, "split:v resulted in seven pieces";
    isa-ok @a[1], Match, "second is a Match object";
    isa-ok @a[3], Match, "fourth is a Match object";
    isa-ok @a[5], Match, "sixth is a Match object";
}

#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
{
    my @a = "hello world".split(/(<[aeiou]>)(.)/, :v);
    is +@a, 7, "split:v resulted in seven pieces";
    is @a[1][0], "e", "First capture worked";
    is @a[1][1], "l", "Second capture worked";
    is @a[3][0], "o", "Third capture worked";
    is @a[3][1], " ", "Fourth capture worked";
}

# RT #63066
#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 2
test( "hello-world",$_,3,$_,
  <<"" hello - world "">>,                             # r
  <<"" "" hello "" - "" world "" "">>,                 # rv
  <<"" 0 hello 0 - 0 world 0 "">>,                     # rk
  <<"" 0 "" hello 0 "" - 0 "" world 0 "" "">>,         # rkv
  ("",0=>"","hello",0=>"","-",0=>"","world",0=>"",""), # rp
  <hello - world>,                               # rse
  <<"" hello "" - "" world "">>,                 # rvse
  <<0 hello 0 - 0 world 0>>,                     # rkse
  <<0 "" hello 0 "" - 0 "" world 0 "">>,         # rkvse
  (0=>"","hello",0=>"","-",0=>"","world",0=>""), # rpse

  <<"" hello -world>>,               # rl
  <<"" "" hello "" -world>>,         # rlv
  <<"" 0 hello 0 -world>>,           # rlk
  <<"" 0 "" hello 0 "" -world>>,     # rlkv
  ("",0=>"","hello",0=>"","-world"), # rlp
  <hello -world>,                 # rlse
  <<"" hello "" -world>>,         # rlvse
  <0 hello 0 -world>,             # rlkse
  <<0 "" hello 0 "" -world>>,     # rlkvse
  (0=>"","hello",0=>"","-world"), # rlpse
) for /<.ws>/, /<.wb>/;

# RT #63066
my $p = 0=>"";
#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 1
test( "-a-b-c-",/<.ws>/,4,/<.ws>/,
  <<"" - a - b - c - "">>,                                         # r
  <<"" "" - "" a "" - "" b "" - "" c "" - "" "">>,                 # rv
  <<"" 0 - 0 a 0 - 0 b 0 - 0 c 0 - 0 "">>,                         # rk
  <<"" 0 "" - 0 "" a 0 "" - 0 "" b 0 "" - 0 "" c 0 "" - 0 "" "">>, # rkv
  ("",$p,"-",$p,"a",$p,"-",$p,"b",$p,"-",$p,"c",$p,"-",$p,""),     # rp
  <- a - b - c ->,                                                 # rse
  <<"" - "" a "" - "" b "" - "" c "" - "">>,                       # rvse
  <<0 - 0 a 0 - 0 b 0 - 0 c 0 - 0>>,                               # rkse
  <<0 "" - 0 "" a 0 "" - 0 "" b 0 "" - 0 "" c 0 "" - 0 "">>,       # rkvse
  ($p,"-",$p,"a",$p,"-",$p,"b",$p,"-",$p,"c",$p,"-",$p),           # rpse

  <<"" - a -b-c->>,                # rl
  <<"" "" - "" a "" -b-c->>,       # rlv
  <<"" 0 - 0 a 0 -b-c->>,          # rlk
  <<"" 0 "" - 0 "" a 0 "" -b-c->>, # rlkv
  ("",$p,"-",$p,"a",$p,"-b-c-"),   # rlp
  <- a -b-c->,                     # rlse
  <<"" - "" a "" -b-c->>,          # rlvse
  <<0 - 0 a 0 -b-c->>,             # rlkse
  <<0 "" - 0 "" a 0 "" -b-c->>,    # rlkvse
  ($p,"-",$p,"a",$p,"-b-c-"),      # rlpse
);

# RT #63066
#?rakudo.jvm skip 'Cannot access a native attribute as a reference attribute, RT #126679'
#?DOES 1
test( "-a-b-c-",/<.wb>/,4,/<.wb>/,
  <- a - b - c ->,                                 # r
  <<- "" a "" - "" b "" - "" c "" ->>,             # rv
  <<- 0 a 0 - 0 b 0 - 0 c 0 ->>,                   # rk
  <<- 0 "" a 0 "" - 0 "" b 0 "" - 0 "" c 0 "" ->>, # rkv
  ("-",$p,"a",$p,"-",$p,"b",$p,"-",$p,"c",$p,"-"), # rp
  <- a - b - c ->,                                 # rse
  <<- "" a "" - "" b "" - "" c "" ->>,             # rvse
  <<- 0 a 0 - 0 b 0 - 0 c 0 ->>,                   # rkse
  <<- 0 "" a 0 "" - 0 "" b 0 "" - 0 "" c 0 "" ->>, # rkvse
  ("-",$p,"a",$p,"-",$p,"b",$p,"-",$p,"c",$p,"-"), # rpse

  <- a - b-c->,                  # rl
  <<- "" a "" - "" b-c->>,       # rlv
  <<- 0 a 0 - 0 b-c->>,          # rlk
  <<- 0 "" a 0 "" - 0 "" b-c->>, # rlkv
  ("-",$p,"a",$p,"-",$p,"b-c-"), # rlp
  <- a - b-c->,                  # rlse
  <<- "" a "" - "" b-c->>,       # rlvse
  <<- 0 a 0 - 0 b-c->>,          # rlkse
  <<- 0 "" a 0 "" - 0 "" b-c->>, # rlkvse
  ("-",$p,"a",$p,"-",$p,"b-c-"), # rlpse
);

#L<S32::Str/Str/"no longer has a default delimiter">
dies-ok {"  abc  def  ".split()}, q/Str.split() disallowed/;

# using /.../
is "a.b".split(/\./).join(','), <a b>.join(','),
   q{"a.b".split(/\./)};

#?rakudo skip 'No such method null for invocant of type Cursor RT #124685'
#?niecza skip 'Unable to resolve method null in class Cursor'
{
    is "abcd".split(/<null>/).join(','), <a b c d>.join(','),
       q{"abcd".split(/<null>/)};()
}

{
    throws-like { "foobar".split(<a o>,:k, :v) }, X::Adverb,
      what   => 'split',
      source => 'Str',
      nogo   => <v k>,
      'clashing named parameters';
}

# vim: ft=perl6
