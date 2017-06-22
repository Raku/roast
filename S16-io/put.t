use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

# Tests for &put and IO::Handle.put

my @tests = () => "\n", 'a' => "a\n", 42 => "42\n", [<a b c>] => "a b c\n",
    [<a b>, (42, (3, 5))] => "a b 42 3 5\n",
    class { method Str { "pass" } }.new => "pass\n";

plan 1 + 2*@tests;

{
    my $file = make-temp-file;
    for @tests -> (:key($in), :value($out)) {
        subtest "$in.perl() (sub form)" => {
            temp $*OUT = $file.open: :w;
            is-deeply put($in<>), True, 'return value';
            $*OUT.close;
            is-deeply $file.slurp, $out, 'put content';
        }
        subtest "$in.perl() (sub form)" => {
            my $fh = $file.open: :w;
            is-deeply $fh.put($in<>), True, 'return value';
            $fh.close;
            is-deeply $file.slurp, $out, 'put content';
        }
    }
}

throws-like 'put', Exception, 'bare &put throws (telling to use parens)';

# vim: ft=perl6
