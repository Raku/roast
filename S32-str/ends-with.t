use v6;

use Test;

# L<S32::Str/Str/=item ends-with>

my $backend = $*RAKU.compiler.backend;

dies-ok { 42.ends-with: Str },
  "Cool.ends-with with wrong args does not hang";

# tests with just lowercase and no markings
for
  ("foobar", "foobar".match(/\w+/)), (
    \("bar"),     True,
    \("foobar"),  True,
    \("goo"),     False,
    \("foobarx"), False,
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
                  || !(c<m> || c<ignoremark>)  # others do not support ignoremark
                {
                    is-deeply invocant.ends-with(|c), result,
                      "{invocantraku}.ends-with{c.raku.substr(1)} is {result.gist}";
                }
            }
        }
    }
}

# tests with uppercase and markings
for
  ("foöbÀr", "foöbÀr".match(/\w+/)), (
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
        my \invocantraku := invocant ~~ Match
          ?? invocant.gist !! invocant.raku;
        for @tests -> \c, \result {
            if $backend eq "moar"          # MoarVM supports all
              || !(c<m> || c<ignoremark>)  # others do not support ignoremark
            {
                is-deeply invocant.ends-with(|c), result,
                  "{invocantraku}.ends-with{c.raku.substr(1)} is {result.gist}";
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
