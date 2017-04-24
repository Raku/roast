use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 10;

my $filename = 't/spec/S16-io/words.testing';
my @text  = <<zero " one" " two " "   three   " "four\n">>;
my @clean = <zero one two three four>;

unlink $filename;  # make sure spurt will work

ok $filename.IO.spurt(@text), "could we spurt a file";

# IO::Handle
my @words;
for open($filename).words(:close) -> $word {
    @words.push($word);
}
is @words.join, @clean.join, "Handle pull-one cycle";

@words = open($filename).words(:close);
is @words.join, @clean.join, "Handle push-all";

@words = open($filename).words(:close)[1,2];
is @words.join, @clean[1,2].join, "Handle push-exactly cycle";

my $elems = open($filename).words(:close).elems;
is $elems, +@clean, "Handle count-only";

# .IO
@words = ();
for $filename.IO.words -> $word {
    @words.push($word);
}
is @words.join, @clean.join, "IO pull-one cycle";

@words = $filename.IO.words;
is @words.join, @clean.join, "IO push-all";

@words = $filename.IO.words[1,2];
is @words.join, @clean[1,2].join, "IO push-exactly cycle";

$elems = $filename.IO.words.elems;
is $elems, +@clean, "IO count-only";

unlink $filename; # cleanup

{
    $*ARGFILES = IO::ArgFiles.new: :args[
        make-temp-file(:content<foo bar>), make-temp-file(:content<meow moo>),
        make-temp-file(:content<I ♥ Perl 6>),
    ];
    is-deeply words(), <foo bar meow moo I ♥ Perl 6>».Str.Seq,
        'words() without args uses $*ARGFILES';
}

# vim: ft=perl6
