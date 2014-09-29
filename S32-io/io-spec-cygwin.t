use v6;
use Test;
# L<S32::IO/IO::Spec>

plan 102;
my $cygwin = IO::Spec::Cygwin;

my @canonpath =
	'///../../..//./././a//b/.././c/././',   '/a/b/../c',
	'',                       '',
	'a/../../b/c',            'a/../../b/c',
	'/.',                     '/',
	'/./',                    '/',
	'/a/./',                  '/a',
	'/a/.',                   '/a',
	'/../../',                '/',
	'/../..',                 '/',
        'a:\\b\\c',               'a:/b/c',
	'c:a\\.\\b',              'c:a/b';
for @canonpath -> $in, $out {
	is $cygwin.canonpath($in), $out, "canonpath: '$in' -> '$out'";
}

my @splitdir =
	'',           '',
	'/d1/d2/d3/', ',d1,d2,d3,',
	'd1/d2/d3/',  'd1,d2,d3,',
	'/d1/d2/d3',  ',d1,d2,d3',
	'd1/d2/d3',   'd1,d2,d3';

for @splitdir -> $in, $out {
	is $cygwin.splitdir(|$in).join(','), $out, "splitdir: '$in' -> '$out'"
}

is $cygwin.catdir(),                        '', "No argument returns empty string";
my @catdir =
	$( ),                    '',
	$('/'),                  '/',
	$('','d1','d2','d3',''), '/d1/d2/d3',
	$('d1','d2','d3',''),    'd1/d2/d3',
	$('','d1','d2','d3'),    '/d1/d2/d3',
	$('d1','d2','d3'),       'd1/d2/d3',
	$('/','d2/d3'),          '/d2/d3',
        $('/','/d1/d2'),         '/d1/d2',
        $('//notreally','/UNC'), '/notreally/UNC';
for @catdir -> $in, $out {
	is $cygwin.catdir(|$in), $out, "catdir: {$in.perl} -> '$out'";
}

my @split = 
	'/',               ',/,/',
	'.',               ',.,.',
	'file',            ',.,file',
	'/dir',            ',/,dir',
	'/d1/d2/d3/',      ',/d1/d2,d3',
	'd1/d2/d3/',       ',d1/d2,d3',
	'/d1/d2/d3/.',     ',/d1/d2/d3,.',
	'/d1/d2/d3/..',    ',/d1/d2/d3,..',
	'/d1/d2/d3/.file', ',/d1/d2/d3,.file',
	'd1/d2/d3/file',   ',d1/d2/d3,file',
	'/../../d1/',      ',/../..,d1',
	'/././d1/',        ',/./.,d1',
	'c:/d1\\d2\\',    'c:,/d1,d2',
        '//unc/share',     '//unc/share,/,/';
for @split -> $in, $out {
	is $cygwin.split(|$in).hash.<volume dirname basename>.join(','),
            $out, "split: {$in.perl} -> '$out'"
}

my @join = 
	$('','','file'),            'file',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d:','d2/d3/',''),        'd:d2/d3/',
	$('d:/','d2','d3/'),        'd:/d2/d3/';
for @join -> $in, $out {
	is $cygwin.join(|$in), $out, "join: {$in.perl} -> '$out'"
}


my @splitpath = 
	'file',            ',,file',
	'/d1/d2/d3/',      ',/d1/d2/d3/,',
	'd1/d2/d3/',       ',d1/d2/d3/,',
	'/d1/d2/d3/.',     ',/d1/d2/d3/.,',
	'/d1/d2/d3/..',    ',/d1/d2/d3/..,',
	'/d1/d2/d3/.file', ',/d1/d2/d3/,.file',
	'd1/d2/d3/file',   ',d1/d2/d3/,file',
	'/../../d1/',      ',/../../d1/,',
	'/././d1/',        ',/././d1/,';
for @splitpath -> $in, $out {
	is $cygwin.splitpath(|$in).join(','), $out, "splitpath: {$in.perl} -> '$out'"
}

my @catpath = 
	$('','','file'),            'file',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d:','d2/d3/',''),        'd:d2/d3/',
	$('d:/','d2','d3/'),        'd:/d2/d3/';
for @catpath -> $in, $out {
	is $cygwin.catpath(|$in), $out, "catpath: {$in.perl} -> '$out'"
}

my @catfile = 
	$('a','b','c'),         'a/b/c',
	$('a','b','./c'),       'a/b/c',
	$('./a','b','c'),       'a/b/c',
	$('c'),                 'c',
	$('./c'),               'c';
for @catfile -> $in, $out {
	is $cygwin.catfile(|$in), $out, "catfile: {$in.perl} -> '$out'"
}


my @abs2rel = 
	$('/t1/t2/t3','/t1/t2/t3'),          '.',
	$('/t1/t2/t4','/t1/t2/t3'),          '../t4',
	$('/t1/t2','/t1/t2/t3'),             '..',
	$('/t1/t2/t3/t4','/t1/t2/t3'),       't4',
	$('/t4/t5/t6','/t1/t2/t3'),          '../../../t4/t5/t6',
#	$('../t4','/t1/t2/t3'),              '../t4',
	$('/','/t1/t2/t3'),                  '../../..',
	$('///','/t1/t2/t3'),                '../../..',
	$('/.','/t1/t2/t3'),                 '../../..',
	$('/./','/t1/t2/t3'),                '../../..',
	$('/t1/t2/t3', '/'),                 't1/t2/t3',
	$('/t1/t2/t3', '/t1'),               't2/t3',
	$('t1/t2/t3', 't1'),                 't2/t3',
	$('t1/t2/t3', 't4'),                 '../t1/t2/t3';
for @abs2rel -> $in, $out {
	is $cygwin.abs2rel(|$in), $out, "abs2rel: {$in.perl} -> '$out'"
}

my @rel2abs = 
	$('t4','/t1/t2/t3'),             '/t1/t2/t3/t4',
	$('t4/t5','/t1/t2/t3'),          '/t1/t2/t3/t4/t5',
	$('.','/t1/t2/t3'),              '/t1/t2/t3',
	$('..','/t1/t2/t3'),             '/t1/t2/t3/..',
	$('../t4','/t1/t2/t3'),          '/t1/t2/t3/../t4',
	$('/t1','/t1/t2/t3'),            '/t1',
	$('//t1/t2/t3','/foo'),          '//t1/t2/t3';
for @rel2abs -> $in, $out {
	is $cygwin.rel2abs(|$in), $out, "rel2abs: {$in.perl} -> '$out'"
}


is $cygwin.curdir,  '.',   'curdir is "."';
is $cygwin.devnull, '/dev/null', 'devnull is /dev/null';
is $cygwin.rootdir, '/',  'rootdir is "\\"';
is $cygwin.updir,   '..',  'updir is ".."';


if $*DISTRO.name !~~ any(<cygwin>) {
	skip_rest 'cygwin on-platform tests'
}
else {
	# double check a couple of things to see if IO::Spec loaded correctly
	is IO::Spec.rootdir, '\\',  'IO::Spec loads Cygwin';
	ok {.IO.d && .IO.w}.(IO::Spec.tmpdir), "tmpdir: {IO::Spec.tmpdir} is a writable directory";
}

done;
