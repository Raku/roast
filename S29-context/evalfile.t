use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

plan 3;

# L<S29/Context/"=item EVALFILE">

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }

{
    my $tmpfile = "temp-evalfile" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: "32 + 10";
        close $fh;
    }
    is EVALFILE($tmpfile), 42, "EVALFILE() works";
    END { unlink $tmpfile }
}

{
    my $tmpfile = "temp-evalfile-lexical" ~ nonce();
    {
        my $fh = open("$tmpfile", :w);
        say $fh: '$some_var';
        close $fh;
    }
    my $some_var = 'samovar';
    is EVALFILE($tmpfile), 'samovar', "EVALFILE() evaluated code can see lexicals";
    END { unlink $tmpfile }
}

subtest '&EVALFILE respects compiler encoding options' => {
    plan 3;
    my $path = make-temp-file;
    $path.spurt: :enc<iso-8859-1>, 'print "I ® U"';
    # The $result Buf was obtained by running:
    # perl6 -e '"foo".IO.spurt: q|print "I ® U"|, :enc<iso-8859-1>' |
    #   perl6 -e 'run(:out, «perl6 --encoding=iso-8859-1 foo»).out.slurp-rest(:bin).perl.say'

    my $result = Buf[uint8].new(73,32,194,174,32,85);
    given run :out, :err, $*EXECUTABLE, '--encoding=iso-8859-1', '-e',
        'use MONKEY-SEE-NO-EVAL; EVALFILE \qq[$path.absolute.perl()]'
    {
        is-deeply .out.slurp-rest(:bin), $result, 'STDOUT has right data';
        is-deeply .err.slurp, '',      'STDERR is empty';
        is-deeply .exitcode,  0,       'exitcode is correct';
    }
}

# vim: ft=perl6
