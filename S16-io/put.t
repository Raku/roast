use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for &put and IO::Handle.put

my @tests := () => "\n", 'a' => "a\n", 42 => "42\n", [<a b c>] => "abc\n",
    [<a b>, (42, (3, 5))] => "a b42 3 5\n",
    class { method Str { "pass" } }.new => "pass\n";

plan 1 + 2*@tests;

{
    my $file = make-temp-file;
    for @tests -> (:key($in), :value($out)) {
        group-of 2 => "$in.raku() (sub form)" => {
            temp $*OUT = $file.open: :w;
            is-deeply put(|$in), True, 'return value';
            $*OUT.close;
            is-deeply $file.slurp, $out, 'put content';
        }
        group-of 2 => "$in.raku() (sub form)" => {
            my $fh = $file.open: :w;
            is-deeply $fh.put(|$in), True, 'return value';
            $fh.close;
            is-deeply $file.slurp, $out, 'put content';
        }
    }
}

throws-like 'put', Exception, 'bare &put throws (telling to use parens)';

# vim: expandtab shiftwidth=4
