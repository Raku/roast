use v6;

use Test;

=begin pod

  Infix comparison operators L<S03/"Changes to Perl operators"/"stealth postfix">

=end pod


plan 4;

# infix less-than requires whitespace; otherwise it's interpreted as
# a <...> hash subscript

eval-lives-ok "1 <2", "infix less-than (<) requires whitespace before.";
eval-lives-ok  "1 < 2" , "infix less-than (<) requires whitespace before.";
throws-like "1< 2", Exception, "infix less-than (<) requires whitespace before, so this is a parse error.";
throws-like "1<2", Exception, "infix less-than (<) requires whitespace before, so this is a parse error.";

# vim: ft=perl6
