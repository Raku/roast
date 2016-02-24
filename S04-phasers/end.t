use v6.c;
use Test;

use lib 't/spec/packages';
use Test::Util;

plan 8;

# RT #122355
{
    is_run( 'END exit(5)',
        {
            status => 5 +< 8, ## exit status 5 shifted right by 8 bits
            out    => '',
            err    => '',
        },
        'can use &exit from END block' );
}

# RT #111766
{
    {
        my $a = 42;
        END { is $a, 42, 'lexical lookup from END block works' };
    }
    {
        BEGIN {
            my $a = 43;
            END { is $a, 43, 'lexical lookup from END block to surrounding BEGIN block works' };
        }
    }
}

# RT #112408
lives-ok { EVAL 'my %rt112408 = END => "parsing clash with block-less END"' },
    'Can use END as a bareword hash key (RT #112408)';

lives-ok { EVAL 'my $x = 3; END { $x * $x }' },
    'outer lexicals are visible in END { ... } blocks';

my $a = 0;
#?niecza todo
lives-ok { EVAL 'my $x = 3; END { $a = $x * $x };' },
    'and those from EVAL as well';

#?niecza todo
is_run( 'use MONKEY-SEE-NO-EVAL; my $a = 2; EVAL q[my $x = 3; END { $a = $x * $x; print $a }]; print $a, ":"',
    {
        out => '2:9',
        err => '',
    },
    'and they really worked' );

END { pass("exit does not prevent running of END blocks"); }
exit;

# vim: ft=perl6
