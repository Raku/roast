use v6;
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

eval_lives_ok 'my $x = 3; END { $x * $x }',
    'outer lexicals are visible in END { ... } blocks';

# RT #112408
eval_lives_ok 'my %rt112408 = END => "parsing clash with block-less END"',
    'Can use END as a bareword hash key (RT 112408)';

my $a = 0;
#?rakudo 2 todo 'lexicals and EVAL()'
#?niecza todo
eval_lives_ok 'my $x = 3; END { $a = $x * $x };',
              'and those from eval as well';

#?niecza todo
is $a, 9, 'and they really worked';

END { pass("exit does not prevent running of END blocks"); }
exit;

# vim: ft=perl6
