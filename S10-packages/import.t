use v6;

use Test;
plan 1;

if $?PUGS_BACKEND ne "BACKEND_PUGS" {
  skip_rest "PIL2JS and PIL-Run do not support eval() yet.";
  exit;
}

is(eval("use t::spec::packages::Import 'foo'; 123;"), 123, "import doesn't get called if it doesn't exist");
