#!/usr/bin/env raku
my @lines;
use Test;
my @failed;
my @unexpected-failures;
my $max-lines-per-file = 2300;
my $todo = ["119128,820,119141<=>119128,820,119141,119150", "119225,820,119141<=>119225,820,119141,119150", "119226,820,119141<=>119226,119141,820,119150", "65,774,820<=>259,769,820", "65,770,820<=>97,770,769,820", "65,778,820<=>97,778,820,769", "65,776,820<=>97,776,772,820", "65,775,820<=>97,775,772,820", "65,803,820<=>97,774,803,820", "67,807,820<=>99,807,820,769", "69,770,820<=>101,770,820,769", "69,807,820<=>101,820,807,774", "69,772,820<=>275,769,820", "69,803,820<=>101,770,820,803", "73,776,820<=>105,776,769,820", "76,803,820<=>108,772,803,820", "216,769,820<=>111,769,820", "79,770,820<=>244,769,820", "79,776,820<=>111,776,772,820", "79,771,820<=>111,771,769,820", "79,775,820<=>111,775,772,820", "79,808,820<=>111,772,820,808", "79,772,820<=>111,772,769,820", "79,795,820<=>111,795,769,820", "79,803,820<=>111,820,770,803", "82,803,820<=>114,820,772,803", "83,769,820<=>115,769,775,820", "83,780,820<=>115,780,775,820", "83,803,820<=>115,803,820,775", "85,776,820<=>117,776,769,820", "85,771,820<=>117,771,769,820", "85,772,820<=>117,772,820,776", "85,795,820<=>117,769,795,820", "913,787,820<=>945,835,820,769", "913,788,820<=>945,788,820,769", "917,787,820<=>949,820,835,769", "917,788,820<=>949,788,820,769", "919,787,820<=>951,835,769,820", "919,788,820<=>951,788,820,769", "921,787,820<=>953,820,835,769", "921,788,820<=>7985,820,769", "921,776,820<=>912,820", "927,787,820<=>959,820,787,769", "927,788,820<=>959,820,788,769", "965,787,820<=>965,787,769,820", "933,788,820<=>965,788,769,820", "978,776,820<=>944,820", "937,787,820<=>969,835,820,769", "937,788,820<=>8033,769,820", "64298,33<=>64329,33", "64298,63<=>64329,63", "64298,65<=>64329,97", "64298,98<=>64329,98", "1575,1425,1619,97<=>1570,97", "1575,1425,1620,97<=>1571,97", "1608,1425,1620,97<=>1572,97", "1610,1425,1620,97<=>1574,97", "3953,119141,3954,97<=>3953,3954,65", "3953,119141,3968,97<=>3953,3968,65", "3953,119141,3956,97<=>3953,3956,65", "3953,3956,98<=>3958,820", "4018,119141,3968,97<=>3958,65", "3958,98<=>3958,3953,820", "4018,3953,3968,98<=>3960,820", "4019,119141,3968,97<=>3960,65", "3960,98<=>3960,3953,820", "4352,4449,97<=>4352,119141,4449,97", "4352,4469,97<=>4352,119141,4469,97", "4370,4449,97<=>4370,119141,4449,97", "4370,4469,97<=>4370,119141,4469,97", "101662,98<=>100352,33", "101874,98<=>110960,33", "101631,98<=>19968,33"];
my %todo = $todo.antipairs;
sub MAIN (Bool :$test = False, Str:D :$folder) {
    my Str:D $filename = "CollationTest_NON_IGNORABLE.txt";
    my IO::Path $file = "$folder/$filename".IO;
    my Str $last-chrs;
    my Str $last-label;
    my Int $last-line-no;
    my Int:D $line-no = 0;
    my $last-codes;
    my Str ($uca-version, $ucd-version);
    say ">>> Starting generation. Please be patient";
    for $file.lines -> $line {
        #last if $line-no > 30000;
        $line-no++;
        next if $line eq '';
        if $line.starts-with: '#' {
            $uca-version = ~$0 if $line ~~ / 'UCA Version: ' (\S+) /;
            $ucd-version = ~$0 if $line ~~ / 'UCD Version: ' (\S+) /;
            next;
        }
        my ($code-str, $label, $collation) = $line.split([';', "\t", '#'], :skip-empty);
        my $codes = $code-str.split(' ').map(*.parse-base(16)).list;
        # surrogates are only used in UTF-16, so we cannot test with these with NFG representation
        next if $codes.first({is-surrogate($_)});
        $label .= trans( [Q[\u]] => ['U+'], [Q[\U]] => ['U+']);
        my $chrs = $codes.chrs;
        my $failed-it = False;
        # sometimes they are equal, due to normalization of the original codepoints listed in the UCA test file, just skip it
        next if $last-chrs and $last-chrs eq $chrs;
        if $last-chrs {
            $last-chrs unicmp $chrs === Less or do { add-failure($last-codes, $codes, $last-line-no, $line-no); $failed-it = True };
        }
        # We decide here if we want to put the codepoint sequence into the test file
        my $should-include = (!$last-chrs # always ensure we push the first thing in the collation test file
            or $failed-it # push if we failed the comparison. We will then notice if we start passing it again
            # Characters with MVM_COLLATION_QC property value of 0 means they *could* start a multi-codepoint collation grouping
            or !$chrs.uniprop('MVM_COLLATION_QC') or ($last-chrs and !$last-chrs.uniprop('MVM_COLLATION_QC')));
        if $should-include {
            @lines.push: ($chrs, $label, $collation, $line-no.Int);
            if $test and 2 <= @lines {
                my ($this-line, $last-line) = (@lines[*-1], @lines[*-2]);
                do-test($last-line[0], $this-line[0], $last-line[1], $this-line[1], $last-line[3], $this-line[3], False);
            }
        }
        $last-codes   = $codes;
        $last-chrs    = $chrs;
        $last-label   = $label;
        $last-line-no = $line-no;
    }

    if $test {
        done-testing;
    } else {
        my Str:D $tail = Q:to/END/;
        use Test;
        # Iterate from 0 to one before the last index
        for ^(@a-1) {
            todo 1 if !@a[$_][3];
            is-deeply Uni.new(@a[$_][0]).Str unicmp Uni.new(@a[$_+1][0]).Str, Less, "{@a[$_][1]} Line {@a[$_][2]} <=> {@a[$_+1][1]} Line {@a[$_+1][2]}";
        }
        END
        my @output-files;
        my Int:D $lines-in-file = 0;
        my Int:D $file-num      = 0;
        for ^@lines -> $line-no {
            my $line = @lines[$line-no];
            $lines-in-file++;
            my $ans = $line-no != (@lines.elems - 1) ?? @lines[$line-no][0] unicmp @lines[$line-no + 1][0] === Less !! True;
            @output-files[$file-num].push: "( ($line[0].ords.fmt("0x%X, ")), {quote-it($line[1])}, $line[3], $ans ),";
            if $max-lines-per-file < $lines-in-file {
                @output-files[++$file-num].push: "( ($line[0].ords.fmt("0x%X, ")), {quote-it($line[1])}, $line[3], $ans ),";
                $lines-in-file = 0;
            }
        }
        for ^@output-files {
            "{$file.basename.subst(/'.txt'$/, '')}-$_.t".IO.spurt:
            [~] "# Test created with $*PROGRAM-NAME on {Date.today.yyyy-mm-dd} from $filename UCA version $uca-version UCD version $ucd-version\n",
            "# ( (codepoints), description, line-num-from-UCA-file, expect-success )\n\n",
            'my @a = ', "\n", @output-files[$_].join("\n"), ";\n",
            "plan {@output-files[$_].elems - 1};\n", $tail, "\n";
        }
        say "\n>>> Generated tests into output files";
    }

    if @unexpected-failures {
        say '@unexpected-failures.gist: ' ~ @unexpected-failures.gist;
        say '=' x 70;
        # TODO explain how to inspect the failures
        say "OH NO. We had {@unexpected-failures.elems} unexpected failures, which are not previously todo'd.";
        say "Please ensure you check the failures, and make sure there are not too many of them";
        say '=' x 70;
        say "\n>>> If (and only if) all the unexpected failures look ok, use the todo string below and put it into CollationTestGen.raku";
        say "my \$todo = {create-todo-string};";
    }
    else {
        say "YAY. No unexpected failures :)";
    }
    say "\n>>> Make sure to update docs/unicode-generated-tests.asciidoc when you update the unicode version of these tests";
}

sub is-surrogate (Int:D $cp) {
         (0xDC00 <= $cp && $cp <= 0xDFFF) #`( <Low Surrogate> )
      or (0xD800 <= $cp && $cp <= 0xDB7F) #`( <Non Private Use High Surrogate> )
}

sub quote-it (Str:D $str = "") {
    "Q««" ~ $str ~ "»»";
}

sub do-test ($last-chrs, $chrs, $last-label, $label, $last-line-no, $line-no, $todo) {
    todo 1 if $todo;
    is-deeply $last-chrs unicmp $chrs, Less, "$last-label unicmp $label | Line $last-line-no <=> Line $line-no";
}

sub is-todo ($last-codes, $codes) {
    my $key = create-todo-key($last-codes, $codes);
    return %todo{$key}:exists;
}

sub add-failure ($last-codes, $codes, $last-line, $line) {
    my %failure-details =
        leftside-codes  => $last-codes,
        rightside-codes => $codes,
        leftside-line   => $last-line,
        rightside-line  => $line;
    if !is-todo($last-codes, $codes) {
        @unexpected-failures.push: %failure-details;
    }
    @failed.push: %failure-details;
}

sub create-todo-key ($leftside-codes, $rightside-codes) {
    $leftside-codes.join(',') ~ '<=>' ~ $rightside-codes.join(',');
}

sub create-todo-string {
    my @for-todo;
    for @failed -> $f {
        @for-todo.push: create-todo-key($f<leftside-codes>, $f<rightside-codes>);
    }
    return @for-todo.raku;
}
