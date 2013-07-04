use v6;
use Test;
# L<S32::IO/IO::Spec>

plan 206;
my $win32 = IO::Spec::Win32;

my @canonpath = 
	'',               '',
	'a:',             'A:',
	'A:f',            'A:f',
	'A:/',            'A:\\',
	'a\\..\\..\\b\\c','a\\..\\..\\b\\c',
	'//a\\b//c',      '\\\\a\\b\\c',
	'/a/..../c',      '\\a\\....\\c',
	'//a/b\\c',       '\\\\a\\b\\c',
	'////',           '\\',
	'//',             '\\',
	'/.',             '\\',
	'//a/b/../../c',  '\\\\a\\b\\c',
	'\\../temp\\',    '\\temp',
	'\\../',          '\\',
	'\\..\\',         '\\',
	'/../',           '\\',
	'/..\\',          '\\',
	'd1/../foo',      'd1\\..\\foo';
for @canonpath -> $in, $out {
	is $win32.canonpath($in), $out, "canonpath: '$in' -> '$out'";
}
my @canonpath-parent = 
	"foo\\bar\\..",          "foo",
	"foo/bar/baz/../..",     "foo",
	"/foo/..",               "\\",
	"foo/..",                '.',
	"foo/../bar/../baz",     "baz",
	"foo/../../bar",         "..\\bar",
	"foo/bar/baz/../..",     "foo",
	"../../..",              "..\\..\\..",
	"\\..\\..\\..",          "\\",
	"/foo/../..",            "\\",
	"C:\\..\\foo",           "C:\\foo",
	"C:..",                  "C:..",
	"\\\\server\\share\\..", "\\\\server\\share", 
	"0",                     "0",
	"/..//..usr/bin/../foo/.///ef", "\\..usr\\foo\\ef",
;
for @canonpath-parent -> $in, $out {
	is $win32.canonpath($in, :parent), $out,
           "canonpath(:parent): '$in' -> '$out'";
}
print "# Warning expected here: ";
is $win32.canonpath( Any, :parent ), '', "canonpath: Any -> ''";

my @splitdir = 
	'',              '',
	'\\d1/d2\\d3/',  ',d1,d2,d3,',
	'd1/d2\\d3/',    'd1,d2,d3,',
	'\\d1/d2\\d3',   ',d1,d2,d3',
	'd1/d2\\d3',     'd1,d2,d3';

for @splitdir -> $in, $out {
	is $win32.splitdir(|$in).join(','), $out, "splitdir: '$in' -> '$out'"
}

is $win32.catdir(),                        '', "No argument returns empty string";
my @catdir = 
	('/').item,                     '\\',
	('/', '../').item,              '\\',
	('/', '..\\').item,             '\\',
	('\\', '../').item,             '\\',
	('\\', '..\\').item,            '\\',
	('//d1','d2').item,             '\\\\d1\\d2',
	('\\d1\\','d2').item,           '\\d1\\d2',
	('\\d1','d2').item,             '\\d1\\d2',
	('\\d1','\\d2').item,           '\\d1\\d2',
	('\\d1','\\d2\\').item,         '\\d1\\d2',
	('','/d1','d2').item,           '\\d1\\d2',
	('','','/d1','d2').item,        '\\d1\\d2',
	('','//d1','d2').item,          '\\d1\\d2',
	('','','//d1','d2').item,       '\\d1\\d2',
	('','d1','','d2','').item,      '\\d1\\d2',
	('','d1','d2','d3','').item,    '\\d1\\d2\\d3',
	('d1','d2','d3','').item,       'd1\\d2\\d3',
	('','d1','d2','d3').item,       '\\d1\\d2\\d3',
	('d1','d2','d3').item,          'd1\\d2\\d3',
	('A:/d1','d2','d3').item,       'A:\\d1\\d2\\d3',
	('A:/d1','d2','d3','').item,    'A:\\d1\\d2\\d3',
	('A:/d1','B:/d2','d3','').item, 'A:\\d1\\B:\\d2\\d3',
	('A:/').item,                   'A:\\',
	('\\', 'foo').item,             '\\foo',
	('','','..').item,              '\\',
	('A:', 'foo').item,             'A:foo';
for @catdir -> $in, $out {
	is $win32.catdir(|$in), $out, "catdir: {$in.perl} -> '$out'";
}

my @splitpath = 
	'file',                            ',,file',
	'\\d1/d2\\d3/',                    ',\\d1/d2\\d3/,',
	'd1/d2\\d3/',                      ',d1/d2\\d3/,',
	'\\d1/d2\\d3/.',                   ',\\d1/d2\\d3/.,',
	'\\d1/d2\\d3/..',                  ',\\d1/d2\\d3/..,',
	'\\d1/d2\\d3/.file',               ',\\d1/d2\\d3/,.file',
	'\\d1/d2\\d3/file',                ',\\d1/d2\\d3/,file',
	'd1/d2\\d3/file',                  ',d1/d2\\d3/,file',
	'C:\\d1/d2\\d3/',                  'C:,\\d1/d2\\d3/,',
	'C:d1/d2\\d3/',                    'C:,d1/d2\\d3/,',
	'C:\\d1/d2\\d3/file',              'C:,\\d1/d2\\d3/,file',
	'C:d1/d2\\d3/file',                'C:,d1/d2\\d3/,file',
	'C:\\../d2\\d3/file',              'C:,\\../d2\\d3/,file',
	'C:../d2\\d3/file',                'C:,../d2\\d3/,file',
	'\\../..\\d1/',                    ',\\../..\\d1/,',
	'\\./.\\d1/',                      ',\\./.\\d1/,',
	'\\\\node\\share\\d1/d2\\d3/',     '\\\\node\\share,\\d1/d2\\d3/,',
	'\\\\node\\share\\d1/d2\\d3/file', '\\\\node\\share,\\d1/d2\\d3/,file',
	'\\\\node\\share\\d1/d2\\file',    '\\\\node\\share,\\d1/d2\\,file',
	\('file', :nofile),                ',file,',
	\('\\d1/d2\\d3/', :nofile),           ',\\d1/d2\\d3/,',
	\('d1/d2\\d3/', :nofile),             ',d1/d2\\d3/,',
	\('\\\\node\\share\\d1/d2\\d3/', :nofile),   '\\\\node\\share,\\d1/d2\\d3/,';

for @splitpath -> $in, $out {
	is $win32.splitpath(|$in).join(','), $out, "splitpath: {$in.perl} -> '$out'"
}

my @catpath = 
	('','','file').item,                            'file',
	('','\\d1/d2\\d3/','').item,                    '\\d1/d2\\d3/',
	('','d1/d2\\d3/','').item,                      'd1/d2\\d3/',
	('','\\d1/d2\\d3/.','').item,                   '\\d1/d2\\d3/.',
	('','\\d1/d2\\d3/..','').item,                  '\\d1/d2\\d3/..',
	('','\\d1/d2\\d3/','.file').item,               '\\d1/d2\\d3/.file',
	('','\\d1/d2\\d3/','file').item,                '\\d1/d2\\d3/file',
	('','d1/d2\\d3/','file').item,                  'd1/d2\\d3/file',
	('C:','\\d1/d2\\d3/','').item,                  'C:\\d1/d2\\d3/',
	('C:','d1/d2\\d3/','').item,                    'C:d1/d2\\d3/',
	('C:','\\d1/d2\\d3/','file').item,              'C:\\d1/d2\\d3/file',
	('C:','d1/d2\\d3/','file').item,                'C:d1/d2\\d3/file',
	('C:','\\../d2\\d3/','file').item,              'C:\\../d2\\d3/file',
	('C:','../d2\\d3/','file').item,                'C:../d2\\d3/file',
	('','\\../..\\d1/','').item,                    '\\../..\\d1/',
	('','\\./.\\d1/','').item,                      '\\./.\\d1/',
	('C:','foo','bar').item,                        'C:foo\\bar',
	('\\\\node\\share','\\d1/d2\\d3/','').item,     '\\\\node\\share\\d1/d2\\d3/',
	('\\\\node\\share','\\d1/d2\\d3/','file').item, '\\\\node\\share\\d1/d2\\d3/file',
	('\\\\node\\share','\\d1/d2\\','file').item,    '\\\\node\\share\\d1/d2\\file';

for @catpath -> $in, $out {
	is $win32.catpath(|$in), $out, "catpath: {$in.perl} -> '$out'"
}

say "# split tests";
my @split = 
        '\\',                               ',\\,\\',
        '.',                               ',.,.',
	'file',                            ',.,file',
	'\\d1/d2\\d3/',                    ',\\d1/d2,d3',
	'd1/d2\\d3/',                      ',d1/d2,d3',
	'\\d1/d2\\d3/.',                   ',\\d1/d2\\d3,.',
	'\\d1/d2\\d3/..',                  ',\\d1/d2\\d3,..',
	'\\d1/d2\\d3/.file',               ',\\d1/d2\\d3,.file',
	'\\d1/d2\\d3/file',                ',\\d1/d2\\d3,file',
	'd1/d2\\d3/file',                  ',d1/d2\\d3,file',
	'C:\\d1/d2\\d3/',                  'C:,\\d1/d2,d3',
	'C:d1/d2\\d3/',                    'C:,d1/d2,d3',
	'C:\\d1/d2\\d3/file',              'C:,\\d1/d2\\d3,file',
	'C:d1/d2\\d3/file',                'C:,d1/d2\\d3,file',
	'C:\\../d2\\d3/file',              'C:,\\../d2\\d3,file',
	'C:../d2\\d3/file',                'C:,../d2\\d3,file',
	'\\../..\\d1/',                    ',\\../..,d1',
	'\\./.\\d1/',                      ',\\./.,d1',
	'//unc/share',                     '//unc/share,\\,\\',
	'\\\\node\\share\\d1/d2\\d3/',     '\\\\node\\share,\\d1/d2,d3',
	'\\\\node\\share\\d1/d2\\d3/file', '\\\\node\\share,\\d1/d2\\d3,file',
	'\\\\node\\share\\d1/d2\\file',    '\\\\node\\share,\\d1/d2,file',
;
for @split -> $in, $out {
	is $win32.split(|$in).hash.<volume directory basename>.join(','),
          $out, "split: {$in.perl} -> '$out'"
}

say "# join tests";
my @join = 
	('','\\','\\').item,                            '\\',
	('','/','\\').item,                             '/',
	('','\\','/').item,                             '\\',
	('','.','.').item,                              '.',
	('','','file').item,                            'file',
	('','.','file').item,                           'file',
	('','\\d1/d2\\d3/','').item,                    '\\d1/d2\\d3/',
	('','d1/d2\\d3/','').item,                      'd1/d2\\d3/',
	('','\\d1/d2\\d3/.','').item,                   '\\d1/d2\\d3/.',
	('','\\d1/d2\\d3/..','').item,                  '\\d1/d2\\d3/..',
	('','\\d1/d2\\d3/','.file').item,               '\\d1/d2\\d3/.file',
	('','\\d1/d2\\d3/','file').item,                '\\d1/d2\\d3/file',
	('','d1/d2\\d3/','file').item,                  'd1/d2\\d3/file',
	('C:','\\d1/d2\\d3/','').item,                  'C:\\d1/d2\\d3/',
	('C:','d1/d2\\d3/','').item,                    'C:d1/d2\\d3/',
	('C:','\\d1/d2\\d3/','file').item,              'C:\\d1/d2\\d3/file',
	('C:','d1/d2\\d3/','file').item,                'C:d1/d2\\d3/file',
	('C:','\\../d2\\d3/','file').item,              'C:\\../d2\\d3/file',
	('C:','../d2\\d3/','file').item,                'C:../d2\\d3/file',
	('','\\../..\\d1/','').item,                    '\\../..\\d1/',
	('','\\./.\\d1/','').item,                      '\\./.\\d1/',
	('C:','foo','bar').item,                        'C:foo\\bar',
        ('\\\\server\\share', '\\', '\\').item,		'\\\\server\\share',
	('\\\\node\\share','\\d1/d2\\d3/','').item,     '\\\\node\\share\\d1/d2\\d3/',
	('\\\\node\\share','\\d1/d2\\d3/','file').item, '\\\\node\\share\\d1/d2\\d3/file',
	('\\\\node\\share','\\d1/d2\\','file').item,    '\\\\node\\share\\d1/d2\\file';

for @join -> $in, $out {
	is $win32.join(|$in), $out, "join: {$in.perl} -> '$out'"
}

ok $win32.is-absolute( "/" ), 'is-absolute: ok "/"';
ok $win32.is-absolute( "\\" ), 'is-absolute: ok "\\"';
ok $win32.is-absolute( "C:\\" ), 'is-absolute: ok "C:\\"';
ok $win32.is-absolute( "C:\\foo/bar" ), 'is-absolute: ok "C:\\foo/bar"';
ok $win32.is-absolute( "\\\\server\\share" ), 'is-absolute: ok "\\\\server\\share"';

nok $win32.is-absolute( "foo/bar" ), 'is-absolute: nok "foo/bar"';
nok $win32.is-absolute( "." ), 'is-absolute: nok "."';
nok $win32.is-absolute( "C:" ), 'is-absolute: nok "C:"';
nok $win32.is-absolute( "C:dir\\file.txt" ), 'is-absolute: nok "C:dir\\file.txt"';

my @catfile = 
	('a','b','c').item,        'a\\b\\c',
	('a','b','.\\c').item,      'a\\b\\c' ,
	('.\\a','b','c').item,      'a\\b\\c' ,
	('c').item,                'c',
	('.\\c').item,              'c',
	('a/..','../b').item,       'a\\..\\..\\b',
	('A:', 'foo').item,         'A:foo';

for @catfile -> $in, $out {
	is $win32.catfile(|$in), $out, "catfile: {$in.perl} -> '$out'"
}

my @abs2rel = 
	('/t1/t2/t3','/t1/t2/t3').item,     '.',
	('/t1/t2/t4','/t1/t2/t3').item,     '..\\t4',
	('/t1/t2','/t1/t2/t3').item,        '..',
	('/t1/t2/t3/t4','/t1/t2/t3').item,  't4',
	('/t4/t5/t6','/t1/t2/t3').item,     '..\\..\\..\\t4\\t5\\t6',
	('/','/t1/t2/t3').item,             '..\\..\\..',
	('///','/t1/t2/t3').item,           '..\\..\\..',
	('/.','/t1/t2/t3').item,            '..\\..\\..',
	('/./','/t1/t2/t3').item,           '..\\..\\..',
	('\\\\a/t1/t2/t4','/t2/t3').item,   '\\\\a\\t1\\t2\\t4',
	('//a/t1/t2/t4','/t2/t3').item,     '\\\\a\\t1\\t2\\t4',
	('A:/t1/t2/t3','A:/t1/t2/t3').item,     '.',
	('A:/t1/t2/t3/t4','A:/t1/t2/t3').item,  't4',
	('A:/t1/t2/t3','A:/t1/t2/t3/t4').item,  '..',
	('A:/t1/t2/t3','B:/t1/t2/t3').item,     'A:\\t1\\t2\\t3',
	('A:/t1/t2/t3/t4','B:/t1/t2/t3').item,  'A:\\t1\\t2\\t3\\t4',
	('E:/foo/bar/baz').item,            'E:\\foo\\bar\\baz',
	('C:\\Windows\\System32', 'C:\\').item,  'Windows\System32',
	('\\\\computer2\\share3\\foo.txt', '\\\\computer2\\share3').item,  'foo.txt';
	#('C:/one/two/three').item,          'three',
	#('../t4','/t1/t2/t3').item,         '..\\..\\..\\one\\t4',  # Uses _cwd()
	#('C:\\one\\two\\t\\asd1\\', 't\\asd\\').item, '..\\asd1',
	#('\\one\\two', 'A:\\foo').item,     'C:\\one\\two';

for @abs2rel -> $in, $out {
	is $win32.abs2rel(|$in), $out, "abs2rel: {$in.perl} -> '$out'"
}

my @rel2abs = 
	$('temp','C:/'),                       'C:\\temp',
	$('temp','C:/a'),                      'C:\\a\\temp',
	$('temp','C:/a/'),                     'C:\\a\\temp',
	$('../','C:/'),                        'C:\\',
	$('../','C:/a'),                       'C:\\a\\..',
	$('\\foo','C:/a'),                     'C:\\foo',
	$('temp','//prague_main/work/'),       '\\\\prague_main\\work\\temp',
	$('../temp','//prague_main/work/'),    '\\\\prague_main\\work\\temp',
	$('temp','//prague_main/work'),        '\\\\prague_main\\work\\temp',
	$('../','//prague_main/work'),         '\\\\prague_main\\work';
	#$('D:foo.txt'),                        'D:\\alpha\\beta\\foo.txt';

for @rel2abs -> $in, $out {
	is $win32.rel2abs(|$in), $out, "rel2abs: {$in.perl} -> '$out'"
}


is $win32.curdir,  '.',   'curdir is "."';
is $win32.devnull, 'nul', 'devnull is nul';
is $win32.rootdir, '\\',  'rootdir is "\\"';
is $win32.updir,   '..',  'updir is ".."';


if $*OS !~~ any(<MSWin32 NetWare symbian os2 dos>) {
	skip_rest 'Win32ish on-platform tests'
}
else {
	# double check a couple of things to see if IO::Spec loaded correctly
	is IO::Spec.devnull, 'nul', 'devnull is nul';
	is IO::Spec.rootdir, '\\',  'rootdir is "\\"';
	ok {.IO.d && .IO.w}.(IO::Spec.tmpdir), "tmpdir: {IO::Spec.tmpdir} is a writable directory";
}

done;
