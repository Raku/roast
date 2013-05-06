use v6;
use Test;
# L<S32::IO/IO::Path>

plan 32;

my $relpath = IO::Path::Unix.new('foo/bar' );
my $abspath = IO::Path::Unix.new('/foo/bar');
isa_ok $abspath, IO::Path::Unix, "Can create IO::Path::Unix";
is $abspath.volume,	"",	"volume is empty on POSIX";
is $abspath.directory, 	"/foo",	'directory "/foo/bar" -> "/foo"';
is $abspath.basename, 	"bar",	'basename "/foo/bar" -> "bar"';

my $path = IO::Path::Unix.new('foo//bar//');
is $path.directory, 	"foo",	'directory "foo//bar//" -> "foo"';
is $path.basename, 	"bar",	'basename "foo//bar//" -> "bar"';
isa_ok $path.path, IO::Path::Unix, ".path returns itself";
is $path.perl.eval, $path, ".perl loopback";

is IO::Path::Unix.new(".").Str,			".",		"current directory";
is IO::Path::Unix.new("..").Str,		"..",		"parent directory";
is IO::Path::Unix.new('').Str,			"",		"empty is empty";

is IO::Path::Unix.new("/usr/////local/./bin/././perl/").cleanup, "/usr/local/bin/perl",
	"cleanup '/usr/////local/./bin/././perl/' -> '/usr/local/bin/perl'";

ok $relpath.is-relative,	"relative path is-relative";
nok $relpath.is-absolute,	"relative path ! is-absolute";
nok $abspath.is-relative,	"absolute path ! is-relative";
ok $abspath.is-absolute,	"absolute path is-absolute";

is $relpath.absolute,		IO::Spec::Unix.canonpath("$*CWD/foo/bar"),	"absolute path from \$*CWD";
is $relpath.absolute("/usr"),	"/usr/foo/bar",		"absolute path specified";
is IO::Path::Unix.new("/usr/bin").relative("/usr"),	"bin",			"relative path specified";
is $relpath.absolute.relative,  "foo/bar",		"relative inverts absolute";
is $relpath.absolute("/foo").relative("/foo"), "foo/bar","absolute inverts relative";
#?rakudo 1 skip 'resolve NYI, needs nqp::readlink'
is $abspath.relative.absolute.resolve, "/foo/bar",	"absolute inverts relative with resolve";

is IO::Path::Unix.new("foo/bar").parent,		"foo",			"parent of 'foo/bar' is 'foo'";
is IO::Path::Unix.new("foo").parent,			".",			"parent of 'foo' is '.'";
is IO::Path::Unix.new(".").parent,			"..",			"parent of '.' is '..'";
is IO::Path::Unix.new("..").parent,			"../..",		"parent of '..' is '../..'";
is IO::Path::Unix.new("/foo").parent,			"/",			"parent at top level is '/'";
is IO::Path::Unix.new("/").parent,			"/",			"parent of root is '/'";

is IO::Path::Unix.new("/").child('foo'),	"/foo",		"append to root";
is IO::Path::Unix.new(".").child('foo'),	"foo",		"append to cwd";

if IO::Spec.FSTYPE eq 'Unix' {
	ok IO::Path::Unix.new($*CWD).e,		"cwd exists, filetest inheritance ok";
	ok IO::Path::Unix.new($*CWD).d,		"cwd is a directory";
}
else {
	skip 2, "On-system tests for filetest inheritance";
}


done;

