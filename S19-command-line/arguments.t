use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 6;

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
            out => '',
            err => { .chars < 256 && m/"Could not open $file"|"Can not run directory $file"/ },
        },
        'concise error message when called script not found' );
    }
}

# RT #77894
{
    my $cmd = $*DISTRO.is-win 
        ?? 'echo exit(42) | \qq[$*EXECUTABLE] -'
        !! 'echo "exit(42)" | \qq[$*EXECUTABLE] -';

    is shell($cmd).exitcode, 42, "'-' as argument means STDIN";
}

# RT #125600
{
    my $dir = 'omg-a-directory';
    mkdir $dir;
    LEAVE rmdir 'omg-a-directory';
    my Str $x;
    is_run( $x, :args[$dir],
    {
        out => '',
        err => { .chars < 256 && m/$dir/ && m/directory/ },
    },
    'concise error message when called script is a directory' );
}

{
    # MoarVM #482
    is run($*EXECUTABLE, '-e', ｢print '“Hello world”'｣, :out).out.slurp,
        '“Hello world”',
        'UTF-8 in arguments is decoded correctly';
}


# RT#127925
is_run ｢@*ARGS.head.print｣, :args[<yağmur>],
    { :err(''), :out<yağmur>, :0status },
    'printed chars match input';

# RT #130760
is_run(Str, :args['--nosucharg=foo', 'foo.p6'],
    { out => '' },
    'Unknown options do not spit warnings to stdout');
