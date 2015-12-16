use v6;
use Test;

plan 18;

my $filename = 't/spec/S16-io/split.testing';

sub test-split($text,@result,|c) {
    subtest {
        plan 4;
        unlink $filename;
        ok spurt($filename,$text), "could we spurt $filename";
        my @got = open($filename).split(|c,:close);
        is @got, @result, 'did we get expected result in array';

        @got = ();
        @got.push($_) for open($filename).split(|c,:close);
        is @got, @result, 'did we get expected result in for loop';

        is open($filename).split(|c,:close).elems, +@result, 'elems ok';
    }, "testing '$text.substr(^4)' with {c.list[0].^name}";
}

# standard text file
for "\n", /\n/ -> $sep {
    my $text  = "zero\none\ntwo\nthree\nfour";
    my @clean = <zero one two three four>;
    test-split($text,@clean,$sep);
}

# multi char string sep with part head/tail
for "::", /\:\:/ -> $sep {
    my $text  = ":zero::one::two::three::four:";
    my @clean = <:zero one two three four:>;
    test-split($text,@clean,$sep);
}

# single star string sep
for "o", /o/ -> $sep {
    my $text  = "none\none\ntwo\nthree\nfour\n";
    my @clean = <<n "ne\n" "ne\ntw" "\nthree\nf" "ur\n">>;
    test-split($text,@clean,$sep);
}

# nothing to split
for "x",/x/ -> $sep {
    my $text  = "";
    my @clean = "";
    test-split($text,@clean,$sep);
}

# nothing between separators at all
for "x",/x/ -> $sep {
    my $text  = "x" x 10;
    my @clean = "" xx 11;
    test-split($text,@clean,$sep);
}

# no separator found at all (small)
for "x",/x/ -> $sep {
    my $text  = "y" x 10;
    my @clean = "y" x 10;
    test-split($text,@clean,$sep);
}

# no separator found at all (more than one chunk)
for "x",/x/ -> $sep {
    my $text  = "z" x 100000;
    my @clean = "z" x 100000;
    test-split($text,@clean,$sep);
}

# no separator found in first chunk
for "x",/x/ -> $sep {
    my $text  = "Z" x 100000 ~ "xa";
    my @clean = "Z" x 100000, "a";
    test-split($text,@clean,$sep);
}

# split with nothing
for "" -> $sep {
    my $text  = "abcde";
    my @clean = flat "", <a b c d e>, "";
    test-split($text,@clean,$sep);
}

# split with nothing on nothing
for "" -> $sep {
    my $text  = "";
    my @clean;
    test-split($text,@clean,$sep);
}

unlink $filename; # cleanup

# vim: ft=perl6
