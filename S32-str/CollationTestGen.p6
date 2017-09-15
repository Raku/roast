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
my %todo = (25560, 25873, 25904, 47677, 47715, 47760, 47774, 47794, 47838,
51526, 52483, 52545, 52565, 52605, 54537, 55881, 57453, 57481, 57525, 57545,
57575, 57589, 57603, 57643, 57689, 59168, 59723, 59743, 59769, 60775, 60819,
60839, 60871, 63806, 63868, 64506, 64528, 64858, 64920, 65426, 65457, 65515,
66177, 66199, 66840, 66858, 66920, 67401, 67464, 73347, 73353, 73362, 73371,
73670, 73695, 73740, 73808, 99002, 99025, 99048, 99052, 99063, 99067, 99092,
99103, 99107, 120267, 120321, 120741, 120752, 156894, 156899, 156904, 156909).antipairs;
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
        $uninames .= trans( Q[\u] => 'U+', Q[\U] => 'U+');
        #say $line-no;
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
}
sub quote-it (Str:D $str = "") {
    "Q««" ~ $str ~ "»»";
}
