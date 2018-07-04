use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

# Tests for &prompt

my @tests = () => "", 'a' => "a", 42 => "42", [<a b c>] => "a b c",
    [<a b>, (42, (3, 5))] => "a b 42 3 5",
    class { method Str { "pass" } }.new => "pass";

plan 3*@tests + 10;

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
            is-deeply prompt(), 'fo', 'return value';
            $*IN.close;
        }
    }
}

# Tests for rakudo/rakudo#1906:
{
    sub simulate-prompt($prompt, $input) {
        my $file-in  = make-temp-file :content($input);
        my $file-out = make-temp-file;

        temp $*OUT = $file-out.open: :w;
        temp $*IN  = $file-in.open;

        my $result = $prompt.defined ?? prompt($prompt) !! prompt;

        $*OUT.close; $*IN.close;

        return $result;
    }

    my @tests = (
        [ "42", IntStr ],
        [ "42e0", NumStr ],
        [ "42.0", RatStr ],
        [ "42+0i", ComplexStr ],
    );

    for @tests {
        isa-ok(simulate-prompt('input please:', .[0]), .[1], "input passed through &val (with prompt)");
        isa-ok(simulate-prompt(Any, .[0]), .[1], "input passed through &val (w/o prompt)");
    }

    nok(simulate-prompt('input please:', '').defined, "prompt result on EOF not defined (with prompt)");
    nok(simulate-prompt(Any, '').defined, "prompt result on EOF not defined (w/o prompt)");
}

# vim: ft=perl6
