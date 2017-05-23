use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

# Tests for &prompt

my @tests = () => "", 'a' => "a", 42 => "42", [<a b c>] => "a b c",
    [<a b>, (42, (3, 5))] => "a b 42 3 5",
    class { method Str { "pass" } }.new => "pass";

plan 3*@tests;

{
    for @tests -> (:key($prompt), :value($out)) {
        subtest "default handle attributes" => {
            plan 2;
            my $file-in  = make-temp-file :content("foobar\nbarbar\nberbar");
            my $file-out = make-temp-file;
            temp $*OUT = $file-out.open: :w;
            temp $*IN  = $file-in.open;
            is-deeply prompt($prompt<>), 'foobar', 'return value';
            $*OUT.close; $*IN.close;
            is-deeply $file-out.slurp, $out, 'printed content';
        }

        subtest "changed handle attributes" => {
            plan 2;
            my $file-in  = make-temp-file :content("foobar\nbarbar\nberbar");
            my $file-out = make-temp-file;
            temp $*OUT = $file-out.open: :w, :nl-out<MEOW>;
            temp $*IN  = $file-in.open: :!chomp, :nl-in<oba>;
            is-deeply prompt($prompt<>), 'fooba', 'return value';
            $*OUT.close; $*IN.close;
            is-deeply $file-out.slurp, $out, 'printed content';
        }

        subtest "no-arg prompt" => {
            plan 1;
            temp $*OUT = class :: is IO::Handle {
                method opened   { True }
                method print    { die "Method must not be called" }
                method print-nl { die "Method must not be called" }
                method say      { die "Method must not be called" }
                method put      { die "Method must not be called" }
                method printf   { die "Method must not be called" }
            }.new;

            my $file-in = make-temp-file :content("foobar\nbarbar\nberbar");
            temp $*IN   = $file-in.open: :nl-in<oba>;
            #?rakudo.jvm todo '[io grant] got: "fooba"'
            is-deeply prompt(), 'fo', 'return value';
            $*IN.close;
        }
    }
}

# vim: ft=perl6
