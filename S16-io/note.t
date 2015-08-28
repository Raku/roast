use v6;

# L<S32::IO/IO/=item note>

use Test;

plan 5;

class FakeIO {
    has $.Str = '';
    method print(\arg) { $!Str ~= arg };
}

class InterestingGist {
    has $.x;
    multi method gist(InterestingGist:D:) { "[$.x]" };
}

sub cap(&code) {
    my  $*ERR = FakeIO.new;
    code();
    $*ERR.Str;
}

is cap({ note 42 }), "42\n", 'note(an integer)';
is cap({ note InterestingGist.new(x => "abc") }), "[abc]\n", "note() calls .gist method of a single argument";
is cap({ note InterestingGist.new(x => 1), "foo"}), "[1]foo\n", "note() joins multiple args with whitespace";

is cap({ "flurb".note }), "flurb\n", ".note as a method on Str (for example)";
is cap({ note Int}), "(Int)\n", "note Class name is ok";
