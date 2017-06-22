use v6;
use Test;

plan 25;

my $filename = 't/spec/S16-io/comb.testing';

#?DOES 1
sub test-comb($text,@result,|c) {
    subtest {
        plan 4;
        unlink $filename;
        ok spurt($filename,$text), "could we spurt $filename";
        my @got = open($filename).comb(|c,:close);
        is @got, @result, 'did we get expected result in array';

        @got = ();
        @got.push($_) for open($filename).comb(|c,:close);
        is @got, @result, 'did we get expected result in for loop';

        is open($filename).comb(|c,:close).elems, +@result, 'elems ok';
    }, "testing '$text.substr(^4)' with {c.perl}";
}

# standard text file
for "\n", /\n/ -> $sep {
    my $text  = "zero\none\ntwo\nthree\nfour";
    my @clean = "\n" xx 4;
    test-comb($text,@clean,$sep);
}

# multi char string sep with part head/tail
for "::", /\:\:/ -> $sep {
    my $text  = ":zero::one::two::three::four:";
    my @clean = "::" xx 4;
    test-comb($text,@clean,$sep);
}

# single star string sep
for "o", /o/ -> $sep {
    my $text  = "none\none\ntwo\nthree\nfour\n";
    my @clean = "o" xx 4;
    test-comb($text,@clean,$sep);
}

# nothing to comb
for "x",/x/ -> $sep {
    my $text  = "";
    my @clean;
    test-comb($text,@clean,$sep);
}

# nothing between separators at all
for "x",/x/ -> $sep {
    my $text  = "x" x 10;
    my @clean = "x" xx 10;
    test-comb($text,@clean,$sep);
}

# no separator found at all (small)
for "x",/x/ -> $sep {
    my $text  = "y" x 10;
    my @clean;
    test-comb($text,@clean,$sep);
}

# no separator found at all (more than one chunk)
for "x",/x/ -> $sep {
    my $text  = "z" x 100000;
    my @clean;
    test-comb($text,@clean,$sep);
}

# no separator found in first chunk
for "x",/x/ -> $sep {
    my $text  = "Z" x 100000 ~ "xa";
    my @clean = "x";
    test-comb($text,@clean,$sep);
}

# comb with nothing or a single char match
for "", /./ -> $sep {
    my $text  = "abcde";
    my @clean = <a b c d e>;
    #?rakudo.jvm skip 'Type check failed in binding to parameter "$size"; expected Int but got Str ("")'
    test-comb($text,@clean,$sep);
}

# comb with something around
for /.c./ -> $sep {
    my $text  = "abcde";
    my @clean = "bcd";
    test-comb($text,@clean,$sep);
}

# comb with nothing on nothing
for "" -> $sep {
    my $text  = "";
    my @clean;
    #?rakudo.jvm skip 'Type check failed in binding to parameter "$size"; expected Int but got Str ("")'
    test-comb($text,@clean,$sep);
}

# comb with small integer
for 1 -> $sep {
    my $text  = "abcde";
    my @clean = <a b c d e>;
    test-comb($text,@clean,$sep);
}

# comb with integer exceeding string
for 5, 10, 100000 -> $sep {
    my $text  = "abcde";
    my @clean = "abcde";
    test-comb($text,@clean,$sep);
}

# comb with large integer on large buffer
for 100000 -> $sep {
    my $text  = "defgh" x 100000;
    my @clean = ("defgh" x 20000) xx 5;
    test-comb($text,@clean,$sep);
}

unlink $filename; # cleanup

# vim: ft=perl6
