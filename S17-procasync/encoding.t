use v6;
use Test;

plan 4;

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $quit = False;
    my $oops = False;
    $proc.stdout.tap(quit => { $quit = True });
    $proc.stderr.tap(quit => { $oops = True });
    await $proc.start;
    ok $quit, 'stdout Supply quit on encoding error';
	#?rakudo todo 'Bug involving LAST phasers in whenever blocks'
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
	#?rakudo todo 'Bug involving LAST phasers in whenever blocks'
    nok $oops, 'No bogus quit on stdout Supply';
}

