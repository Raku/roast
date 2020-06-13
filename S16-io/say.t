use v6;

# L<S32::IO/IO/=item say>

use Test;

plan 6;

class FakeIO {
    has $.Str = '';
    method print(\arg) { $!Str ~= arg };
}

class InterestingGist {
    has $.x;
    multi method gist(InterestingGist:D:) { "[$.x]" };
}

sub cap(&code) {
    my  $*OUT = FakeIO.new;
    code();
    $*OUT.Str;
}

is cap({ say 42 }), "42\n", 'say(an integer)';
is cap({ say InterestingGist.new(x => "abc") }), "[abc]\n", "say() calls .gist method of a single argument";
is cap({ say InterestingGist.new(x => 1), "foo"}), "[1]foo\n", "say() joins multiple args with whitespace";

is cap({ "flurb".say }), "flurb\n", ".say as a method on Str (for example)";
is cap({ say Int}), "(Int)\n", "say Class name is ok";

my int $seen;
say "" but role { method gist() { $seen = 1; "" } };
is $seen, 1, 'did say() call .gist even when given a Str';

# vim: expandtab shiftwidth=4
