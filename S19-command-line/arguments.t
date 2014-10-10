use v6;

use Test;

plan 1;

use lib 't/spec/packages';
use Test::Util;

# RT #112988
{
    my Str $x;
    my $file = 'ThisDoesNotExistAtAll.p6';
    if $file.IO.e {
        skip "could not run test since file $file exists";
    }
    else {
        is_run( $x, :args[$file],
        {
            out => { .chars < 256 && m/"Could not open $file"/ },
            err => "",
        },
        'concise error message when called script not found' );
    }
}
