use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

# https://github.com/Raku/old-issue-tracker/issues/3435
{
    is_run( 'END exit(5)',
        {
            status => 5,
            out    => '',
            err    => '',
        },
        'can use &exit from END block' );
}

# https://github.com/Raku/old-issue-tracker/issues/2674
{
    {
        my $a = 42;
        END { is $a, 42, 'lexical lookup from END block works' };
    }
    {
        BEGIN {
            my $a = 43;
            END {
#?rakudo.js.browser todo "broken in all backend when precompiling"
                is $a, 43, 'lexical lookup from END block to surrounding BEGIN block works'
            };
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2713
lives-ok { EVAL 'my %rt112408 = END => "parsing clash with block-less END"' },
    'Can use END as a bareword hash key (RT #112408)';

lives-ok { EVAL 'my $x = 3; END { $x * $x }' },
    'outer lexicals are visible in END { ... } blocks';

my $a = 0;
lives-ok { EVAL 'my $x = 3; END { $a = $x * $x };' },
    'and those from EVAL as well';

is_run( 'use MONKEY-SEE-NO-EVAL; my $a = 2; EVAL q[my $x = 3; END { $a = $x * $x; print $a }]; print $a, ":"',
    {
        out => '2:9',
        err => '',
    },
    'and they really worked' );

END { pass("exit does not prevent running of END blocks"); }
exit;

# vim: expandtab shiftwidth=4
