use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 64;

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

    throws-like { open PATH, :mode<meows> }, Exception, :message(/meows/),
        'using an invalid mode throws';

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

# test default mode
{   unlink PATH;
    my $fh;

    fails-like { open PATH }, Exception,
        'opening nonexistent file in default mode fails';

    $fh = open PATH, :w;
    $fh.print('onions are tasty');
    $fh.close;

    $fh = open PATH;
    ok defined($fh), 'can open existing file in default mode';

    ok $fh.get eq 'onions are tasty', 'can read from file in default mode';

    throws-like '$fh.print("42")', Exception,
        'cannot write to file in default mode';

    $fh.close;
}

# test :r  mode
{   unlink PATH;
    my $fh;

    fails-like { open PATH, :r }, Exception,
        'opening non-existent file in :r mode fails';

    # fill file with data
    $fh = open PATH, :w; $fh.print('onions are tasty'); $fh.close;

    $fh = open PATH, :r;
    ok defined($fh), 'can open existing file in :r mode';
    is $fh.lines.join, 'onions are tasty', 'can read from file in :r mode';
    throws-like '$fh.print("42")', Exception, 'cannot write to file in :r mode';

    $fh.close;
}

# test :a  mode
{   unlink PATH;
    my $fh;

    $fh = open PATH, :a;
    ok defined($fh), 'can open non-existent file in :a mode';
    $fh.print('onions are tasty');
    $fh.close;

    $fh = open PATH, :a;
    ok defined($fh), 'can open existing file in :a mode';
    $fh.print('cats say meow');

    throws-like { $fh.get }, Exception, 'trying to read in :a mode throws';
    $fh.close;

    $fh = open PATH, :r;
    is $fh.lines.join, 'onions are tastycats say meow',
        ':a mode appends to existing data';

    $fh.close;
}

# test :append mode
#?rakudo.jvm skip '[io grant] IllegalArgumentException: READ + APPEND not allowed'
{   unlink PATH;
    my $mode = ':append';
    my $fh;

    fails-like { open PATH, :append }, Exception,
        "opening non-existent file in $mode mode fails";

    # create and fill file with data
    $fh = open PATH, :w; $fh.print('onions are tasty'); $fh.close;

    $fh = open PATH, :append;
    is $fh.lines.join, 'onions are tasty', "$mode can read from existing files";
    throws-like { $fh.say: 'foo' }, Exception,
        "trying to write in $mode mode throws";
    $fh.close;
}

# test :append, :create mode
#?rakudo.jvm skip '[io grant] IllegalArgumentException: READ + APPEND not allowed'
{   unlink PATH;
    my $mode = ':append, :create';
    my $fh;

    $fh = open PATH, :append, :create;
    ok defined($fh), "can open non-existent file in $mode mode";
    ok PATH.IO.e, "$mode mode creates non-existent files";
    $fh.close;

    # create and fill file with data
    $fh = open PATH, :w; $fh.print('onions are tasty'); $fh.close;

    $fh = open PATH, :append, :create;
    is $fh.lines.join, 'onions are tasty', "$mode can read from existing files";
    throws-like { $fh.say: 'foo' }, Exception,
        "trying to write in $mode mode throws";
    $fh.close;
}

# test :ra mode
#?rakudo.jvm skip '[io grant] IllegalArgumentException: READ + APPEND not allowed'
{   unlink PATH;
    my $fh;

    $fh = open PATH, :ra;
    ok defined($fh), 'can open non-existent file in :ra mode';
    $fh.print('onions are tasty');
    $fh.close;

    $fh = open PATH, :ra;
    ok defined($fh), 'can open existing file in :ra mode';
    $fh.print('cats say meow');

    $fh.seek(0, SeekFromBeginning);
    is $fh.lines.join, 'onions are tastycats say meow',
        'can read in :append mode and it appends to existing data';

    $fh.close;
}

# test :create mode
#?rakudo.jvm skip "[io grant] NoSuchFileException: t-32-io-open.tmp'"
{   unlink PATH;
    my $fh;

    $fh = open PATH, :create;
    ok defined($fh), 'can open non-existent file in :create mode';
    throws-like { $fh.say: 'foo' }, Exception,
        'trying to write in :create mode throws';

    is $fh.lines.join, '', 'file starts out empty when using :create';
    $fh.close;

    # fill file with data
    $fh = open PATH, :w; $fh.print('onions are tasty'); $fh.close;

    $fh = open PATH, :create;
    is $fh.lines.join, 'onions are tasty',
        ':create mode does not truncate existing files';

    $fh.close;
}

# test :truncate :create mode
#?rakudo.jvm skip "[io grant] NoSuchFileException: t-32-io-open.tmp"
{   unlink PATH;
    my $mode = ':truncate, :create';
    my $fh;

    $fh = open PATH, :truncate, :create;
    ok defined($fh), "can open non-existent file in $mode mode";
    ok PATH.IO.e, "$mode mode creates non-existent files";
    $fh.close;

    # create and fill file with data
    $fh = open PATH, :w; $fh.print('onions are tasty'); $fh.close;

    $fh = open PATH, :truncate, :create;
    is $fh.lines.join, '', "$mode mode truncates existing files";

    throws-like { $fh.say: 'foo' }, Exception,
        "trying to write in $mode mode throws";

    $fh.close;
}

# test :exclusive mode
{   unlink PATH;
    fails-like { open PATH, :exclusive }, Exception,
        "opening non-existent file in :exclusive mode fails";
}

# test attribute setting
{   unlink PATH;

    with open PATH, :w, :!chomp, :nl-in[<a b>], :nl-out<meow> {
        LEAVE .close;
        is-deeply .chomp,    False,   'can set $!chomp to False with open';
        is-deeply .nl-in,    [<a b>], 'can set $!nl-in to Array with open';
        is-deeply .nl-out,   'meow',  'can set $!nl-out with open';
    }

    with IO::Handle.new(:path(PATH.IO), :!chomp)
        .open: :w, :enc<iso-8859-1>, :chomp, :nl-in('a')
    {
        LEAVE .close;
        is-deeply .chomp,    True,         'can set $!chomp to True with open';
        is-deeply .nl-in,    'a',          'can set $!nl-in to Str with open';
        is-deeply .encoding, 'iso-8859-1', 'can set $!encoding with ';
    }
}

subtest '.open uses attributes by default' => {
    plan 8;
    my $content = "1foo2\nfoo3";
    my $path = make-temp-file :$content;
    my $fh = IO::Handle.new: :$path,
        :nl-in<foo>, :nl-out<meow>, :bin, :!chomp;
    $fh .= open: :rw;
    is-deeply $fh.nl-in,    'foo',        '.nl-in remains same after open';
    is-deeply $fh.nl-out,   'meow',       '.nl-out remains same after open';
    #?rakudo todo 'Un-todo after IO::Handle encoding refactor merge'
    is-deeply $fh.encoding, Nil,          '.encoding is Nil due to :bin';
    is-deeply $fh.chomp,    False,        '.chomp remains same after open';

    #?rakudo.jvm todo 'problem with Buf[uint8], probably related to RT #128041'
    is-deeply $fh.slurp, Buf[uint8].new($content.encode),
        '.encoding is respected';
    $fh.close;

    # XXX TODO 6.d: we have an inconsistency between, say, .encoding and .nl-in
    # the former takes new value as an arg, but the latter returns a Proxy and
    # can be assigned to
    $fh.encoding('utf8');
    $fh .= open: :rw;
    is-deeply $fh.lines.join, $content, '.chomp is respected';

    $fh.say: "hello world";
    $fh.close;
    is-deeply $path.slurp, $content ~ "hello worldmeow", '.nl-out is respected';

    $fh.chomp = True; # set chomp back on to test .nl-in;
    $fh .= open: :rw;
    #?rakudo.jvm todo 'got: "1foo2\nfoo3hello worldmeow"'
    is-deeply $fh.lines.join, "12\n3hello worldmeow", '.nl-in is respected';
    $fh.close;
}

# RT #131503
subtest '.open with "-" as path uses $*IN/$*OUT' => {
    plan 2;
    subtest 'STDOUT' => { plan 3;
        temp $*OUT = make-temp-file.open: :w;
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 3;
        temp $*IN = make-temp-file(:content<meows>).open;
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }
}

subtest '.open with "-" as path can open closed $*IN/$*OUT' => {
    plan 3;
    subtest 'STDOUT' => { plan 4;
        temp $*OUT = IO::Handle.new: :path(make-temp-file);
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.opened,   True, '$*OUT is now opened';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 4;
        temp $*IN = IO::Handle.new: :path(make-temp-file :content<meows>);
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.opened,   True, '$*IN is now opened';
        is-deeply $*IN.encoding, Nil,  'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }

    is_run ｢
        $*IN  = IO::Handle.new: :path('-'.IO);
        $*OUT = IO::Handle.new: :path('-'.IO);
        my $w = '-'.IO.open: :w;
        my $r = '-'.IO.open;
        $r.get.say;
        $*IN.slurp(:close).say;
        $w.put: 'meow $w';
        $*OUT.put: 'meow $*OUT';
    ｣, "foo\nbar\nber", {
        :out("foo\nbar\nber\nmeow \$w\nmeow \$*OUT\n"), :err(''), :0status
    }, ｢can use unopened handle with path '-'.IO｣;
}

# vim: ft=perl6
