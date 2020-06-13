use v6.e.PREVIEW;
use Test;

plan 1;

# GH rakudo/rakudo#3132
eval-lives-ok q<grammar Grammar {  }>, "we can create grammar named Grammar";

# vim: expandtab shiftwidth=4
