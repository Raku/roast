use v6;
use Test;

plan 23;

my \PATH = 't-S32-io-open.tmp';
my \PATH-RX = rx/'t-S32-io-open.tmp'/;

LEAVE unlink PATH;

# cannot open nonexistent files without :create
{   unlink PATH;

    throws-like 'open PATH, :mode<ro>', Exception,
        'cannot open nonexistent file in mode ro', message => PATH-RX;

    throws-like 'open PATH, :mode<wo>', Exception,
        'cannot open nonexistent file in mode wo', message => PATH-RX;

    throws-like 'open PATH, :mode<rw>', Exception,
        'cannot open nonexistent file in mode rw', message => PATH-RX;
}

# can create, write to and read from file
{   unlink PATH;
    my $fh;

    $fh = open PATH, :mode<wo>, :create;
    ok defined($fh), 'can create file in mode wo';

    ok ?$fh.print('42'), 'can write to file in mode wo';

    $fh.close;

    $fh = open PATH, :mode<ro>;
    ok defined($fh), 'can open existing file in mode ro';

    is $fh.get, '42', 'can read from file in mode ro';

    $fh.close;

    $fh = open PATH, :mode<wo>;
    ok defined($fh), 'can open existing file in mode wo';

    throws-like '$fh.get', Exception, 'cannot read from file in mode wo';

    $fh.close;
}

# test :rw
{   unlink PATH;

    my $fh = open PATH, :rw;
    ok defined($fh), 'can use :rw to create file';

    $fh.print('cthulhu fhtagn');
    $fh.seek(0, SeekFromBeginning);

    is $fh.get, 'cthulhu fhtagn', 'can write to and read from :rw file';

    $fh.close;
}

# test :update
{   unlink PATH;
    my $fh;

    throws-like 'open PATH, :update', Exception,
        'cannot use :update on nonexistent file', message => PATH-RX;

    $fh = open PATH, :w;
    $fh.print('12x45');
    $fh.close;

    $fh = open PATH, :update;
    ok defined($fh), 'can use :update on existing file';

    $fh.seek(2, SeekFromBeginning);
    is $fh.getc, 'x', 'can use :update to read from file';

    $fh.seek(2, SeekFromBeginning);
    ok ?$fh.write('3'.encode), 'can use :update to write to file';

    $fh.seek(0, SeekFromBeginning);
    is $fh.get, '12345', 'have used :update successfully';

    $fh.close;
}

# check that :rw does not truncate
{   unlink PATH;
    my $fh;

    $fh = open PATH, :w;
    $fh.print('camelia');
    $fh.close;

    $fh = open PATH, :rw;
    is $fh.get, 'camelia', 'using :rw does not truncate';

    $fh.close;
}

# check that :w does truncate
{   unlink PATH;
    my $fh;

    $fh = open PATH, :w;
    $fh.print('camelia');
    $fh.close;

    $fh = open PATH, :w;
    $fh.close;

    $fh = open PATH, :r;
    ok !defined($fh.getc), 'using :w does truncate';

    $fh.close;
}

# test :x
{   unlink PATH;

    my $fh = open PATH, :x;
    ok defined($fh), 'can use :x to create file';

    $fh.close;

    throws-like 'open PATH, :x', Exception,
        'cannot use :x to open existing file', message => PATH-RX;
}

# test :rx
{   unlink PATH;

    my $fh = open PATH, :rx;
    ok defined($fh), 'can use :rx to create file';

    $fh.print('I <3 P6');
    $fh.seek(0, SeekFromBeginning);

    is $fh.get, 'I <3 P6', 'can write to and read from :rx file';

    $fh.close;

    throws-like 'open PATH, :rx', Exception,
        'cannot use :rx to open existing file', message => PATH-RX;
}

# vim: ft=perl6
