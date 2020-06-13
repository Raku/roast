use v6;

use Test;

my $backend = $*RAKU.compiler.backend;

dies-ok { 42.contains: Str },
  "Cool.contains with wrong args does not hang";

fails-like { "foo".contains("o",-42) }, X::OutOfRange,
  "contains with negative position fails";
fails-like { "foo".contains("o",99999999999999999999999999999) }, X::OutOfRange,
  "contains with very large positive position fails";

# L<S32::Str/Str/=item contains>

# tests with just lowercase and no markings
for
  ("foobara", "foobara".match(/\w+/)), (
    \("bar"),     True,
    \("foobar"),  True,
    \("goo"),     False,
    \("foobarx"), False,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
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
            ) -> \capture {
                if $backend eq "moar"                      # MoarVM supports all
                  || !(capture<m> || capture<ignoremark>)  # no support ignoremark
                {
                    for (
                      capture,
                      \(|capture, 0),
                      \(|capture, "0"),
                    ) -> \c {
                        is-deeply invocant.contains(|c), result,
                          "{invocant.raku}.contains{c.raku.substr(1)} is {result.gist}";
                    }
                }
            }
        }
    }
}

# tests with uppercase and markings
for
  ("foöbÀra", "foöbÀra".match(/\w+/)), (
    \("bar"),                              False,
    \("bar", :i),                          False,
    \("bar", :ignorecase),                 False,
    \("BAR"),                              False,
    \("BÀR", :i),                          True,
    \("BÀR", :ignorecase),                 True,
    \("bAr", :m),                          True,
    \("bAr", :ignoremark),                 True,
    \("foobar"),                           False,
    \("foobar", :i),                       False,
    \("foobar", :ignorecase),              False,
    \("foobar", :m),                       False,
    \("foobar", :ignoremark),              False,
    \("foobar", :i, :m),                   True,
    \("foobar", :ignorecase, :ignoremark), True,
  )
-> @invocants, @tests {
    for @invocants -> \invocant {
        for @tests -> \capture, \result {
            if $backend eq "moar"                      # MoarVM supports all
              || !(capture<m> || capture<ignoremark>)  # no support ignoremark
            {
                for (
                  capture,
                  \(|capture, 0),
                  \(|capture, "0"),
                  \(capture[0].substr(1), 1, |capture.hash),
                  \(capture[0].substr(1), "1", |capture.hash),
                ) -> \c {
                    is-deeply invocant.contains(|c), result,
                      "{invocant.raku}.contains{c.raku.substr(1)} is {result.gist}";
                }
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
