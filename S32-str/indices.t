use v6;
use Test;

# L<S32::Str/Str/"=item indices">

my $backend = $*RAKU.compiler.backend;

# Type of return value
isa-ok 'abc'.indices('b')[0], Int;
isa-ok 'abc'.indices('d'), List;
is 'abc'.indices('d').elems, 0, "method did not find anything";
isa-ok indices('abc','b')[0], Int;
isa-ok indices('abc','d'), List;
is indices('abc','d').elems, 0, "sub did not find anything";

is "foo".indices("o"),              (1,2), "meth o simple test, no overlap";
is "foo".indices("oo"),              (1,), "meth oo simple test, no overlap";
is "foo".indices("o", :overlap),    (1,2), "meth o simple test, overlap";
is "foo".indices("oo", :overlap),    (1,), "meth oo simple test, overlap";
is "foo".indices("", ),         (0,1,2,3), "meth empty simple test, no overlap";
is "foo".indices("", :overlap), (0,1,2,3), "meth empty simple test, no overlap";

is indices("foo","o"),              (1,2), "sub o simple test, no overlap";
is indices("foo","oo"),              (1,), "sub oo simple test, no overlap";
is indices("foo","o", :overlap),    (1,2), "sub o simple test, overlap";
is indices("foo","oo", :overlap),    (1,), "sub oo simple test, overlap";
is indices("foo",""),           (0,1,2,3), "sub empty simple test, no overlap";
is indices("foo","", :overlap), (0,1,2,3), "sub empty simple test, no overlap";

is 422.indices(2), (1,2), "coercion with sub";
is indices(422,2), (1,2), "coercion with method";

is indices("uuúuúuùù", "úuù"), (4,), "Accented chars sub";
is indices("Ümlaut", "Ü"),     (0,), "Umlaut sub";
is "uuúuúuùù".indices("úuù"),  (4,), "Accented chars meth";
is "Ümlaut".indices("Ü"),      (0,), "Umlaut meth";

is "blablabla".indices("b", 2),   (3, 6),    "Str, Str, Int";
is "blablabla".indices("b", 2.0), (3, 6),    "Str, Str, Rat";
is "42424242".indices(4, 2),      (2, 4, 6), "Str, Int, Int";
is "42424242".indices(4, 2.0),    (2, 4, 6), "Str, Int, Rat";
is 42424242.indices(4, 2),        (2, 4, 6), "Int, Int, Int";
is 42424242.indices(4, 2.0),      (2, 4, 6), "Int, Int, Rat";

dies-ok { 42.indices: Str }, "Cool.indices with wrong args does not hang";

# work on variables

# index with negative start position not allowed
fails-like { indices("xxy", "y", -1) }, X::OutOfRange,
  got => -1,
  'indices with negative start position fails';

# https://github.com/Raku/old-issue-tracker/issues/4466
{
    for -1e34, -1e35 -> $pos {
        fails-like { indices( 'xxy','y', $pos ) }, X::OutOfRange,
          got => $pos,
          "sub does $pos fails";
        fails-like { 'xxy'.indices( 'y', $pos ) }, X::OutOfRange,
          got => $pos,
          "method does $pos fails";
    }
    for 1e34, 1e35 -> $pos {
        fails-like { indices( 'xxy','y', $pos ) }, X::OutOfRange,
          got => $pos,
          "sub does $pos fails";
        fails-like { 'xxy'.indices( 'y', $pos ) }, X::OutOfRange,
          got => $pos,
          "method does $pos fails";
    }
}

fails-like { "foo".substr-eq("o",-42) }, X::OutOfRange,
  "substr-eq with negative position fails";
fails-like { "foo".substr-eq("o",9999999999999999999999999999) }, X::OutOfRange,
  "substr-eq with very large positive position fails";

# tests with just lowercase and no markings
for
  ("foobara", "foobara".match(/\w+/)), (
    \("a",3),   (4,6),
    \("foobar"),  (0,),
    \("goo",2),   (),
    \("foobarx"), (),
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku := invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \capture, \result {
            for (
              \(|capture, :!i),
              \(|capture, :!ignorecase),
              \(|capture, :!m),
              \(|capture, :!ignoremark),
              \(|capture, :!i, :!m),
              \(|capture, :!ignorecase, :!ignoremark),
              \(|capture, :i),
              \(|capture, :ignorecase),
              \(|capture, :m),
              \(|capture, :ignoremark),
              \(|capture, :i, :m),
              \(|capture, :ignorecase, :ignoremark),
            ) -> \c {
                if $backend eq "moar"          # MoarVM supports all
                  || !(c<m> || c<ignoremark>)  # no support ignoremark
                {
                    is-deeply invocant.indices(|c), result,
                      "{invocantraku}.index{c.raku.substr(1)} is {result.gist}";
                    is-deeply indices(invocant, |c), result,
                      "index({invocantraku}, {c.raku.substr(2,*-1)}) is {result.gist}";
                }
            }
        }
    }
}

# tests with uppercase and markings
for
  ("foöbÀra", "foöbÀra".match(/\w+/)), (
    \("bar", 3),                           (),
    \("bar", 3, :i),                       (),
    \("bar", "3", :ignorecase),            (),
    \("BAR", "3"),                         (),
    \("BÀR", 3, :i),                       (3,),
    \("BÀR", :ignorecase),                 (3,),
    \("bAr", "3", :m),                     (3,),
    \("bAr", "0", :ignoremark),            (3,),
    \("foobar"),                           (),
    \("foobar", :i),                       (),
    \("foobar", 0, :ignorecase),           (),
    \("foobar", "0", :m),                  (),
    \("foobar", :ignoremark),              (),
    \("foobar", "0", :i, :m),              (0,),
    \("foobar", :ignorecase, :ignoremark), (0,),
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        my \invocantraku = invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \c, \result {
            if $backend eq "moar"          # MoarVM supports all
              || !(c<m> || c<ignoremark>)  # no support ignoremark
            {
                is-deeply invocant.indices(|c), result,
                  "{invocantraku}.indices{c.raku.substr(1)} is {result.gist}";
                is-deeply indices(invocant, |c), result,
                  "indices({invocantraku}, {c.raku.substr(2,*-1)}) is {result.gist}";
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
