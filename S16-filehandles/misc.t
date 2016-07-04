use v6;
use Test;
plan 1;

# RT#126487
{
    my $printer = run $*EXECUTABLE, "-e",
            q{print "cat dog cat dog bird dog Snake snake Snake"},
        :out;

    my $reader  = run $*EXECUTABLE, "-e", q{say $*IN.words.unique},
        :out,
        :in($printer.out);
    
    is $reader.out.get, '(cat dog bird Snake snake)',
        '$*IN.words.unique with no new line at the end must NOT hang'
            ~ " [using `$*EXECUTABLE` as Perl 6 executable]";
}
