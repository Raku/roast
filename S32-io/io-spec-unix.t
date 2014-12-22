use v6;
use Test;
# L<S32::IO/IO::Spec>

plan 130;

my $Unix := IO::Spec::Unix;

my %canonpath = (
        'a/b/c'              => 'a/b/c',
        '//a//b//'           => '/a/b',
	'a/../../b/c'        => 'a/../../b/c',
	'/.'                 => '/',
	'/./'                => '/',
	'/a/./'              => '/a',
	'/a/.'               => '/a',
	'/../../'            => '/',
	'/../..'             => '/',
	'/..'                => '/',
        'a\\\\b'             => 'a\\\\b',
	''                   => '',
        '0'                  => '0',
	'///../../..//./././a//b/.././c/././' => '/a/b/../c',
);
for %canonpath.kv -> $get, $want {
	is $Unix.canonpath( $get ), $want, "canonpath: '$get' -> '$want'";
}
my %canonpath-parent = (
	"foo/bar/.."         => "foo",
	"foo/bar/baz/../.."  => "foo",
	"/foo/.."            => "/",
	"foo/.."             => '.',
	"foo/../bar/../baz"  => "baz",
	"foo/../../bar"      => "../bar",
	"foo/bar/baz/../.."  => "foo",
	"../../.."           => "../../..",
	"/../../.."          => "/",
	"/foo/../.."         => "/",
	"0"                  => "0",
        ''                   => '',
	"//../..usr/bin/../foo/.///ef"   => "/..usr/foo/ef",
	'///../../..//./././a//b/.././c/././' => '/a/c',
);
for %canonpath-parent.kv -> $get, $want {
	is $Unix.canonpath( $get , :parent ), $want, "canonpath(:parent): '$get' -> '$want'";
}
say "# warning expected here:";
is $Unix.canonpath( Any , :parent ), '', "canonpath(:parent): Any -> ''";

is $Unix.catdir( ),                      '',          "catdir: no arg -> ''";
is $Unix.catdir( '' ),                   '/',         "catdir: '' -> '/'";
is $Unix.catdir( '/' ),                  '/',         "catdir: '/' -> '/'";
is $Unix.catdir( '','d1','d2','d3','' ), '/d1/d2/d3', "catdir: ('','d1','d2','d3','') -> '/d1/d2/d3'";
is $Unix.catdir( 'd1','d2','d3','' ),    'd1/d2/d3',  "catdir: ('d1','d2','d3','') -> 'd1/d2/d3'";
is $Unix.catdir( '','d1','d2','d3' ),    '/d1/d2/d3', "catdir: ('','d1','d2','d3') -> '/d1/d2/d3'";
is $Unix.catdir( 'd1','d2','d3' ),       'd1/d2/d3',  "catdir: ('d1','d2','d3') -> 'd1/d2/d3'";
is $Unix.catdir( '/','d2/d3' ),          '/d2/d3',    "catdir: ('/','d2/d3') -> '/d2/d3'";

is $Unix.catfile('a','b','c'),   'a/b/c', "catfile: ('a','b','c') -> 'a/b/c'";
is $Unix.catfile('a','b','./c'), 'a/b/c', "catfile: ('a','b','./c') -> 'a/b/c'";
is $Unix.catfile('./a','b','c'), 'a/b/c', "catfile: ('./a','b','c') -> 'a/b/c'";
is $Unix.catfile('c'),           'c',     "catfile: 'c' -> 'c'";
is $Unix.catfile('./c'),         'c',     "catfile: './c' -> 'c'";

is $Unix.curdir,  '.',         'curdir is "."';
is $Unix.devnull, '/dev/null', 'devnull is /dev/null';
is $Unix.rootdir, '/',         'rootdir is "/"';

is $Unix.updir,   '..',        'updir is ".."';

isnt '.',    $Unix.curupdir,   "curupdir: '.'";
isnt '..',   $Unix.curupdir,   "curupdir: '..'";
is   '.git', $Unix.curupdir,   "curupdir: '.git'";
is   'file', $Unix.curupdir,   "curupdir: 'file'";

ok  $Unix.is-absolute( '/abcd/ef' ), 'is-absolute: ok "/abcd/ef"';
ok  $Unix.is-absolute( '/'    ),  'is-absolute: ok "/"';
nok $Unix.is-absolute( 'abcd/ef' ),  'is-absolute: nok "abcd"';
nok $Unix.is-absolute( '..' ),  'is-absolute: nok ".."';

my $path = %*ENV<PATH>;
%*ENV<PATH> = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:';
my @want         = </usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games .>;
is $Unix.path, @want, 'path';
%*ENV<PATH> = '';
my @empty;
is $Unix.path, @empty, 'no path';
%*ENV<PATH> = $path;

my %splitpath = (
	'file'            => ('', '',             'file'),
	'/d1/d2/d3/'      => ('', '/d1/d2/d3/',   ''),
	'd1/d2/d3/'       => ('', 'd1/d2/d3/',    ''),
	'/d1/d2/d3/.'     => ('', '/d1/d2/d3/.',  ''),
	'/d1/d2/d3/..'    => ('', '/d1/d2/d3/..', ''),
	'/d1/d2/d3/.file' => ('', '/d1/d2/d3/',   '.file'),
	'd1/d2/d3/file'   => ('', 'd1/d2/d3/',    'file'),
	'/../../d1/'      => ('', '/../../d1/',   ''),
	'/././d1/'        => ('', '/././d1/',     ''),
);
for %splitpath.kv -> $get, $want {
	is $Unix.splitpath( $get ), $want, "splitpath: '$get' -> '$want'";
}

my %split = (
	'/'               => ('', '/',             '/'),
	'.'               => ('', '.',             '.'),
	'file'            => ('', '.',          'file'),
        'dir/'            => ('', '.',           'dir'),
        '/dir/'           => ('', '/',           'dir'),
	'/d1/d2/d3/'      => ('', '/d1/d2',       'd3'),
	'd1/d2/d3/'       => ('', 'd1/d2',        'd3'),
	'/d1/d2/d3/.'     => ('', '/d1/d2/d3',     '.'),
	'/d1/d2/d3/..'    => ('', '/d1/d2/d3',    '..'),
	'/d1/d2/d3/.file' => ('', '/d1/d2/d3', '.file'),
	'd1/d2/d3/file'   => ('', 'd1/d2/d3',   'file'),
	'/../../d1/'      => ('', '/../..',       'd1'),
	'/././d1/'        => ('', '/./.',         'd1'),
);
for %split.kv -> $get, $want {
	is $Unix.split( $get ).hash.<volume dirname basename>, $want, "split: '$get' -> '$want'";
}

my @join = (
	$('','.','.'),              '.',
	$('','/','/'),              '/',
        $('','.','file'),           'file',
	$('','','file'),            'file',
        $('','dir','.'),            'dir/.',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d1','d2/d3/',''),        'd2/d3/',
	$('d1','d2','d3/'),         'd2/d3/'
);
for @join -> $get, $want {
	is $Unix.join( |$get ), $want, "join: '$get' -> '$want'";
}


my %splitdir = (
	''           => '',
	'/d1/d2/d3/' => ('', 'd1', 'd2', 'd3', ''),
	'd1/d2/d3/'  => ('d1', 'd2', 'd3', ''),
	'/d1/d2/d3'  => ('', 'd1', 'd2', 'd3'),
	'd1/d2/d3'   => ('d1', 'd2', 'd3'),
);
for %splitdir.kv -> $get, $want {
	is $Unix.splitdir( $get ), $want, "splitdir: '$get' -> '$want'";
}

is $Unix.catpath('','','file'),            'file',            "catpath: ('','','file') -> 'file'";
is $Unix.catpath('','/d1/d2/d3/',''),      '/d1/d2/d3/',      "catpath: ('','/d1/d2/d3/','') -> '/d1/d2/d3/'";
is $Unix.catpath('','d1/d2/d3/',''),       'd1/d2/d3/',       "catpath: ('','d1/d2/d3/','') -> 'd1/d2/d3/'";
is $Unix.catpath('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',     "catpath: ('','/d1/d2/d3/.','') -> '/d1/d2/d3/.'";
is $Unix.catpath('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',    "catpath: ('','/d1/d2/d3/..','') -> '/d1/d2/d3/..'";
is $Unix.catpath('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file', "catpath: ('','/d1/d2/d3/','.file') -> '/d1/d2/d3/.file'";
is $Unix.catpath('','d1/d2/d3/','file'),   'd1/d2/d3/file',   "catpath: ('','d1/d2/d3/','file') -> 'd1/d2/d3/file'";
is $Unix.catpath('','/../../d1/',''),      '/../../d1/',      "catpath: ('','/../../d1/','') -> '/../../d1/'";
is $Unix.catpath('','/././d1/',''),        '/././d1/',        "catpath: ('','/././d1/','') -> '/././d1/'";
is $Unix.catpath('d1','d2/d3/',''),        'd2/d3/',          "catpath: ('d1','d2/d3/','') -> 'd2/d3/'";
is $Unix.catpath('d1','d2','d3/'),         'd2/d3/',          "catpath: ('d1','d2','d3/') -> 'd2/d3/'";

is $Unix.abs2rel('/t1/t2/t3','/t1/t2/t3'),    '.',                  "abs2rel: ('/t1/t2/t3','/t1/t2/t3') -> '.'";
is $Unix.abs2rel('/t1/t2/t4','/t1/t2/t3'),    '../t4',              "abs2rel: ('/t1/t2/t4','/t1/t2/t3') -> '../t4'";
is $Unix.abs2rel('/t1/t2','/t1/t2/t3'),       '..',                 "abs2rel: ('/t1/t2','/t1/t2/t3') -> '..'";
is $Unix.abs2rel('/t1/t2/t3/t4','/t1/t2/t3'), 't4',                 "abs2rel: ('/t1/t2/t3/t4','/t1/t2/t3') -> 't4'";
is $Unix.abs2rel('/t4/t5/t6','/t1/t2/t3'),    '../../../t4/t5/t6',  "abs2rel: ('/t4/t5/t6','/t1/t2/t3') -> '../../../t4/t5/t6'";
is $Unix.abs2rel('/','/t1/t2/t3'),            '../../..',           "abs2rel: ('/','/t1/t2/t3') -> '../../..'";
is $Unix.abs2rel('///','/t1/t2/t3'),          '../../..',           "abs2rel: ('///','/t1/t2/t3') -> '../../..'";
is $Unix.abs2rel('/.','/t1/t2/t3'),           '../../..',           "abs2rel: ('/.','/t1/t2/t3') -> '../../..'";
is $Unix.abs2rel('/./','/t1/t2/t3'),          '../../..',           "abs2rel: ('/./','/t1/t2/t3') -> '../../..'";
# "Unix->abs2rel('../t4','/t1/t2/t3'),             '../t4',              "abs2rel: ('../t4','/t1/t2/t3') -> '../t4'";
is $Unix.abs2rel('/t1/t2/t3', '/'),           't1/t2/t3',           "abs2rel: ('/t1/t2/t3', '/') -> 't1/t2/t3'";
is $Unix.abs2rel('/t1/t2/t3', '/t1'),         't2/t3',              "abs2rel: ('/t1/t2/t3', '/t1') -> 't2/t3'";
is $Unix.abs2rel('t1/t2/t3', 't1'),           't2/t3',              "abs2rel: ('t1/t2/t3', 't1') -> 't2/t3'";
is $Unix.abs2rel('t1/t2/t3', 't4'),           '../t1/t2/t3',        "abs2rel: ('t1/t2/t3', 't4') -> '../t1/t2/t3'";

is $Unix.rel2abs('t4','/t1/t2/t3'),           '/t1/t2/t3/t4',    "rel2abs: ('t4','/t1/t2/t3') -> '/t1/t2/t3/t4'";
is $Unix.rel2abs('t4/t5','/t1/t2/t3'),        '/t1/t2/t3/t4/t5', "rel2abs: ('t4/t5','/t1/t2/t3') -> '/t1/t2/t3/t4/t5'";
is $Unix.rel2abs('.','/t1/t2/t3'),            '/t1/t2/t3',       "rel2abs: ('.','/t1/t2/t3') -> '/t1/t2/t3'";
is $Unix.rel2abs('..','/t1/t2/t3'),           '/t1/t2/t3/..',    "rel2abs: ('..','/t1/t2/t3') -> '/t1/t2/t3/..'";
is $Unix.rel2abs('../t4','/t1/t2/t3'),        '/t1/t2/t3/../t4', "rel2abs: ('../t4','/t1/t2/t3') -> '/t1/t2/t3/../t4'";
is $Unix.rel2abs('/t1','/t1/t2/t3'),          '/t1',             "rel2abs: ('/t1','/t1/t2/t3') -> '/t1'";

if $*DISTRO.name ~~ any(<mswin32 os2 netware symbian dos cygwin>) {
	skip_rest 'Unix on-platform tests'
}
else {
	isa_ok $*SPEC, IO::Spec::Unix, "unix: loads correct module";
	is $*SPEC.rel2abs( $*SPEC.curdir ), $*CWD.chop, "rel2abs: \$*CWD test";
	ok {.IO.d && .IO.w}.( $*SPEC.tmpdir ), "tmpdir: {$*SPEC.tmpdir} is a writable directory";
}
