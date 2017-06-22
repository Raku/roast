use v6;
use Test;
plan 11;

{
    my $stdin-file = 'bind-handles-in-' ~ $*PID;
    my $stdout-file = 'bind-handles-out-' ~ $*PID;
    my $stderr-file = 'bind-handles-err-' ~ $*PID;
    END for $stdin-file, $stdout-file, $stderr-file { try unlink $_ }

    spurt $stdin-file, "This is the first line\nThis is the second\n";

    my $fh-in = open $stdin-file, :r;
    my $fh-out = open $stdout-file, :w;
    my $fh-err = open $stderr-file, :w;
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'note $*IN.get; say $*IN.get');
    $proc.bind-stdin($fh-in);
    $proc.bind-stdout($fh-out);
    $proc.bind-stderr($fh-err);
    await $proc.start;
    .close for $fh-in, $fh-out, $fh-err;

    is slurp($stdout-file), "This is the second\n",
        'Handle bound to stdout got correct line from bound stdin';
    is slurp($stderr-file), "This is the first line\n",
        'Handle bound to stderr got correct line from bound stdin';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1', :w);
    throws-like { $proc.bind-stdin($*IN) },
        X::Proc::Async::BindOrUse, handle => 'stdin',
        'Cannot both open with :w and call bind-stdin';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $proc.stdout; $proc.bind-stdout($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot get stdout stream and then bind stdout';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $proc.Supply; $proc.bind-stdout($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot get merged stream and then bind stdout';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $proc.bind-stdout($*OUT); $ = $proc.stdout },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot bind-stdout then get stdout stream';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $proc.bind-stdout($*OUT); $ = $proc.Supply },
        X::Proc::Async::BindOrUse, handle => 'stdout',
        'Cannot bind-stdout then get merged stream';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $proc.stderr; $proc.bind-stderr($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot get stderr stream and then bind stderr';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $ = $proc.Supply; $proc.bind-stderr($*OUT) },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot get merged stream and then bind stderr';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $proc.bind-stderr($*OUT); $ = $proc.stderr },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot bind-stderr then get stderr stream';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', 'say 1');
    throws-like { $proc.bind-stderr($*OUT); $ = $proc.Supply },
        X::Proc::Async::BindOrUse, handle => 'stderr',
        'Cannot bind-stderr then get merged stream';
}
