use v6;

use Test;
plan 1;

#?pugs emit if $?PUGS_BACKEND ne "BACKEND_PUGS" {
#?pugs emit  skip_rest "PIL2JS and PIL-Run do not support eval() yet.";
#?pugs emit  exit;
#?pugs emit }

is(eval("use t::spec::packages::Import 'foo'; 123;"), 123, "import doesn't get called if it doesn't exist");
