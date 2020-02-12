use v6;

use Test;

# L<S32::Str/Str/=item starts-with>

my $backend = $*RAKU.compiler.backend;

dies-ok { 42.starts-with: Str },
  "Cool.starts-with with wrong args does not hang";

# tests with just lowercase and no markings
for
  "foobar", (
    \("foo"),     True,
    \("foobar"),  True,
    \("goo"),     False,
    \("foobarx"), False,
  ),
  342, (
    \(34),   True,
    \(342),  True,
    \(43),   False,
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
              || !(c<m> || c<ignoremark>)  # others do not support ignoremark
            {
                is-deeply invocant.starts-with(|c), result,
                  "{invocant.raku}.starts-with{c.raku.substr(1)} is {result.gist}";
            }
        }
    }
}

# tests with uppercase and markings
for
  "foöbÀr", (
    \("foo"),                              False,
    \("foo", :i),                          False,
    \("foo", :ignorecase),                 False,
    \("FOO"),                              False,
    \("FOÖ", :i),                          True,
    \("FOÖ", :ignorecase),                 True,
    \("foo", :m),                          True,
    \("foo", :ignoremark),                 True,
    \("foobar"),                           False,
    \("foobar", :i),                       False,
    \("foobar", :ignorecase),              False,
    \("foobar", :m),                       False,
    \("foobar", :ignoremark),              False,
    \("foobar", :i, :m),                   True,
    \("foobar", :ignorecase, :ignoremark), True,
  )
-> \invocant, @tests {
    for @tests -> \c, \result {
        if $backend eq "moar"          # MoarVM supports all
          || !(c<m> || c<ignoremark>)  # others do not support ignoremark
        {
            is-deeply invocant.starts-with(|c), result,
              "{invocant.raku}.starts-with{c.raku.substr(1)} is {result.gist}";
        }
    }
}

done-testing;

# vim: ft=perl6
