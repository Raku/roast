#!/usr/bin/env perl6
sub is-surrogate (Int:D $cp) {
    return True
        if $cp >= 0xDC00 && $cp <= 0xDFFF #`( <Low Surrogate> )
        or $cp >= 0xD800 && $cp <= 0xDB7F #`( <Non Private Use High Surrogate> )
    ;
    False;
}
my Str $default-folder = "UNIDATA/UCA/CollationTest";
my Int:D $line-no = 0;
my @lines;
use Test;
my @failed;
my %todo = (26199, 26512, 26543, 50808, 50846, 50891, 50905, 50925, 50969, 54795, 55762, 55824, 55844, 55884, 57816, 59170, 60747, 60775, 60819, 60839, 60869, 60883, 60897, 60937, 60983, 62467, 63022, 63042, 63068, 64084, 64128, 64148, 64180, 67150, 67212, 67850, 67872, 68202, 68264, 68770, 68801, 68859, 69521, 69543, 70184, 70202, 70264, 70745, 70808, 76936, 76942, 76951, 76960, 77259, 77284, 77329, 77397, 104119, 104142, 104165, 104169, 104180, 104184, 104209, 104220, 104224, 126039, 126093, 126513, 126524).antipairs;
sub MAIN (Bool :$should-test = False, Bool :$should-generate = True, Bool :$test-only = False, Str:D :$folder = $default-folder) {
    my $file = "$folder/CollationTest_NON_IGNORABLE.txt".IO;
    my $last-chrs;
    my $last-uninames;
    for $file.lines -> $line {
        $line-no++;
        next if $line eq '' or $line.starts-with('#');
        my ($code-str, $uninames, $collation) = $line.split([';', "\t", "#"], :skip-empty);
        my $codes = $code-str.split(' ').map(*.parse-base(16)).list;
        next if $codes.first({is-surrogate($_)});
        $uninames .= trans( [Q[\u]] => ['U+'], [Q[\U]] => ['U+']);
        my $chrs = $codes.chrs;
        if $last-chrs && $last-chrs eq $chrs {
            next;
        }
        my $failed-it = False;
        if $should-test and $last-chrs {
            if %todo{$line-no}:exists {
                todo 1;
            }
            is-deeply $last-chrs unicmp $chrs, Less, "$last-uninames unicmp $uninames | Line {$line-no-1}..$line-no"
                or do { @failed.push: $line-no; $failed-it = True }
        }
        elsif $last-chrs {
            $last-chrs unicmp $chrs === Less or do { @failed.push: $line-no; $failed-it = True }
        }
        if $test-only or !$chrs.uniprop('MVM_COLLATION_QC') or $failed-it {
            @lines.push: ($chrs, $uninames, $collation, $line-no.Int);
        }
        $last-chrs = $chrs;
        $last-uninames = $uninames;
        #last if 20000 < $line-no;
    }
    if $should-test {
        note "Failed: ", (@failed ?? @failed.join(', ') !! "none");
        if !@lines {
            exit done-testing;
        }
        else {
            done-testing;
        }
    }
    my $fatal = False;
    my @failed-numbers;
    my @out;
    my $tail = Q:to/END/;
    use Test;
    my @failed;
    for ^(@a - 1) {
        todo 1 if !@a[$_][3];
        is-deeply Uni.new(@a[$_][0]).Str unicmp Uni.new(@a[$_+1][0]).Str, Less, "{@a[$_][1]} Line {@a[$_][2]} <=> {@a[$_+1][1]} Line {@a[$_+1][2]}" or @failed.push: ($_+1);
    }
    say "Failed: ", (@failed.join(", ") or "none");
    END
    my @thing;
    my $i = 0;
    my $files = 0;
    for ^@lines -> $line-no {
        my $line = @lines[$line-no];
        $i++;
        my $ans = $line-no != (@lines.elems - 1) ?? @lines[$line-no][0] unicmp @lines[$line-no + 1][0] === Less !! True;
        @thing[$files].push: "( ($line[0].ords.fmt("0x%X, ")), {quote-it($line[1])}, $line[3], $ans ),";
        if $i > 2000 {
            @thing[++$files].push: "( ($line[0].ords.fmt("0x%X, ")), {quote-it($line[1])}, $line[3], $ans ),";
            $i = 0;
        }
    }
    for ^@thing {
        "{$file.basename.subst(/'.txt'$/, '')}-$_.t".IO.spurt:
            [~] "# Generated with GenerateCollationTest.p6\n",
            'my @a = ', "\n", @thing[$_].join("\n"), ";\n",
            "use Test;\n", "plan {@thing[$_].elems - 1};\n", $tail, "\n";
    }
    note "\n>>> Make sure to update docs/unicode-generated-tests.asciidoc when you update the unicode version of these tests";
}
sub quote-it (Str:D $str = "") {
    "Q««" ~ $str ~ "»»";
}
