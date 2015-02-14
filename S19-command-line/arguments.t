use v6;

use Test;

plan 2;

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

# RT #77894
{
    my $cmd = $*DISTRO.is-win 
        ?? 'echo exit(42) | \qq[$*EXECUTABLE] -'
        !! 'echo "exit(42)" | \qq[$*EXECUTABLE] -';

    is shell($cmd).exit, 42, "'-' as argument means STDIN";
}
