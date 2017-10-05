use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;
plan 2;

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

my $self = "some text";

#?rakudo todo ''
is ~EVAL(q/"self is $self"/,:lang<Perl5>),"self is some text","lexical inside an EVAL";

subtest 'EVAL/EVALFILE evals Buf like perl would execute source file' => {
    plan 2;

    # The $result Buf was obtained by running:
    # perl -e 'no warnings; print qq|♥\x{26666}|; { use utf8; print qq|♥\x{26666}| }' |
    #    ./perl6 -e '$*IN.encoding(Nil); $*IN.slurp.perl.say'
    my $result = Buf[uint8].new(195,162,194,153,194,165,240,166,153,166,226,153,165,240,166,153,166);

    my $code = ｢no warnings; print qq|♥\x{26666}|; { use utf8; print qq|♥\x{26666}| }｣;

    subtest 'EVAL' => {
        plan 3;
        given run :out, :err, $*EXECUTABLE, '-e',
            'use MONKEY-SEE-NO-EVAL; EVAL :lang<Perl5>, \qq[$code.perl()]'
        {
            is-deeply .out.slurp-rest(:bin), $result, 'STDOUT has right data';
            is-deeply .err.slurp, '',      'STDERR is empty';
            is-deeply .exitcode,  0,       'exitcode is correct';
        }
    }

    subtest 'EVALFILE' => {
        plan 3;
        my $path = make-temp-file;
        $path.spurt: $code;
        given run :out, :err, $*EXECUTABLE, '-e',
            'use MONKEY-SEE-NO-EVAL; EVALFILE :lang<Perl5>,'
            ~ $path.absolute.perl
        {
            is-deeply .out.slurp-rest(:bin), $result, 'STDOUT has right data';
            is-deeply .err.slurp, '',      'STDERR is empty';
            is-deeply .exitcode,  0,       'exitcode is correct';
        }
    }
}

# vim: ft=perl6
