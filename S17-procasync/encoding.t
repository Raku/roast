use v6;
use Test;

plan 13;

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $quit = False;
    my $oops = False;
    $proc.stdout.tap(quit => { $quit = True });
    $proc.stderr.tap(quit => { $oops = True });
    await $proc.start;
    ok $quit, 'stdout Supply quit on encoding error';
    nok $oops, 'No bogus quit on stderr Supply';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $oops = False;
    my $quit = False;
    $proc.stdout.tap(quit => { $oops = True });
    $proc.stderr.tap(quit => { $quit = True });
    await $proc.start;
    ok $quit, 'stderr Supply quit on encoding error';
    nok $oops, 'No bogus quit on stdout Supply';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; print $*IN.slurp.bytes',
        :w, :enc('latin-1'));
    my $bytes = '';
    $proc.stdout.tap({ $bytes ~= $_ });
    my $exited = $proc.start;
    await $proc.print('Öl');
    $proc.close-stdin;
    await $exited;
    is +$bytes, 2, 'print sent data to process with correct encoding';
}

for <put say> -> $meth {
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; .say for $*IN.slurp.subbuf(0, 2).list',
        :w, :enc('latin-1'));
    my $got = '';
    $proc.stdout.tap({ $got ~= $_ });
    my $exited = $proc.start;
    await $proc."$meth"('Öl');
    $proc.close-stdin;
    await $exited;
    is +$got.lines[0], 214, "$meth sent data to process with correct encoding (1)";
    is +$got.lines[1], 108, "$meth sent data to process with correct encoding (2)";
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('latin-1'));
    my $got = '';
    $proc.stdout.tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öl', 'stdout Supply decoded with encoding set in constructor';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('latin-1'));
    my $got = '';
    $proc.stderr.tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öl', 'stderr Supply decoded with encoding set in constructor';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('utf-8'));
    my $got = '';
    $proc.stdout(:enc('latin-1')).tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öl', 'stdout Supply decoded with encoding set in constructor';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('utf-8'));
    my $got = '';
    $proc.stderr(:enc('latin-1')).tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öl', 'stderr Supply decoded with encoding set in constructor';
}
