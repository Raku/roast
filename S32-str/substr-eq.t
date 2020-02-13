use v6;

use Test;

my $backend = $*RAKU.compiler.backend;

# L<S32::Str/Str/=item substr-eq>

dies-ok { 42.substr-eq: Str },
  "Cool.substr-eq with wrong args does not hang";

fails-like { "foo".substr-eq("o",-42) }, X::OutOfRange,
  "substr-eq with negative position fails";
fails-like { "foo".substr-eq("o",9999999999999999999999999999) }, X::OutOfRange,
  "substr-eq with very large positive position fails";

# tests with just lowercase and no markings
for
  "foobara", (
    \("bar",3),   True,
    \("foobar"),  True,
    \("goo",2),   False,
    \("foobarx"), False,
  ),
  342, (
    \(42,1), True,
    \(342),  True,
    \(43,2), False,
    \(3428), False,
  )
-> \invocant, @tests {
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
                is-deeply invocant.substr-eq(|c), result,
                  "{invocant.raku}.substr-eq{c.raku.substr(1)} is {result.gist}";
            }
        }
    }
}

# tests with uppercase and markings
for
  "foöbÀra", (
    \("bar", 3),                           False,
    \("bar", 3, :i),                       False,
    \("bar", "3", :ignorecase),            False,
    \("BAR", "3"),                         False,
    \("BÀR", 3, :i),                       True,
    \("BÀR", 3, :ignorecase),              True,
    \("bAr", "3", :m),                     True,
    \("bAr", "3", :ignoremark),            True,
    \("foobar"),                           False,
    \("foobar", :i),                       False,
    \("foobar", 0, :ignorecase),           False,
    \("foobar", "0", :m),                  False,
    \("foobar", :ignoremark),              False,
    \("foobar", "0", :i, :m),              True,
    \("foobar", :ignorecase, :ignoremark), True,
  )
-> \invocant, @tests {
    for @tests -> \c, \result {
        if $backend eq "moar"          # MoarVM supports all
          || !(c<m> || c<ignoremark>)  # no support ignoremark
        {
            is-deeply invocant.substr-eq(|c), result,
              "{invocant.raku}.substr-eq{c.raku.substr(1)} is {result.gist}";
        }
    }
}

done-testing;

# vim: ft=perl6
