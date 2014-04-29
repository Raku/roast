use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;

plan 2;

my $main = q:to"END-MAIN";
    use v6;
    use lib 'lib';

    # the main functionality of the script
    sub deduplicate(Str $s) {
        my %seen;
        $s.comb.grep({!%seen{ .lc }++}).join;
    }

    # normal call
    multi MAIN($phrase) {
        say deduplicate($phrase)
    }

    # if you call the script with --test, it runs its unit tests
    multi MAIN(Bool :$test!) {
        # imports &plan, &is etc. only into the lexical scope
        use Test;
        plan 2;
        is deduplicate('just some words'),
            'just omewrd', 'basic deduplication';
        is deduplicate('Abcabd'),
            'Abcd', 'case insensitivity';
    }
    END-MAIN

is_run $main, {out => "Duplicate hrmov\n", err => ''}, :args['Duplicate character removal'], 'normal main call';

is_run $main, {out => q:to"END-TEST-OUT", err => ''}, :args['--test'], 'test main call';
    1..2
    ok 1 - basic deduplication
    ok 2 - case insensitivity
    END-TEST-OUT
