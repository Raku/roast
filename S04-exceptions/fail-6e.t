use v6.e.PREVIEW;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

class X::Insignificant is Exception {
    has $.msg = "nothing serious";
    method message { $.msg }
}

try { X::Insignificant.new.throw };
ok Failure.new.exception.WHAT ~~ X::Insignificant, "Failure pick up exception from $! by default";;

sub foo {
    try { X::Insignificant.new( :msg<ignorable> ).throw }
    fail
}
my $f = foo;
ok $f.exception.WHAT ~~ X::Insignificant, "fail pick up exception from $! by default";;
is $f.exception.message, "ignorable", "fail picks up the right exception";

# vim: expandtab shiftwidth=4
