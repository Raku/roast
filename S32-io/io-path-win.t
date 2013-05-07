use v6;
use Test;
# L<S32::IO/IO::Path>

plan 46;

my $relpath = IO::Path::Win32.new('foo\\bar' );
my $abspath = IO::Path::Win32.new('\\foo\\bar');

isa_ok $abspath, IO::Path::Win32, "Can create IO::Path::Win32";
is $abspath.volume,	"",		'volume "\\foo\\bar" -> ""';
is $abspath.directory, 	"\\foo",	'directory "\\foo\\bar" -> "\\foo"';
is $abspath.basename, 	"bar",		'basename "\\foo\\bar" -> "bar"';

my $path = IO::Path::Win32.new('C:foo//bar//');
is $path.volume,	"C:",	'volume "C:foo//bar//" -> "C:"';
is $path.directory, 	"foo",	'directory "C:foo//bar//" -> "foo"';
is $path.basename, 	"bar",	'basename "C:foo//bar//" -> "bar"';
isa_ok $path.path, IO::Path::Win32, ".path returns itself";
is $path.perl.eval, $path, ".perl loopback";

my $uncpath = IO::Path::Win32.new("\\\\server\\share\\");
is $uncpath.volume,	"\\\\server\\share",	'volume "\\\\server\\share\\" -> ""\\\\server\\share"';
is $uncpath.directory, 	"\\",	'directory "\\\\server\\share\\" -> "\\"';
is $uncpath.basename, 	"\\",	'basename "\\\\server\\share\\" -> "\\"';
is $uncpath.Str, "\\\\server\\share", '"\\\\server\\share" restringifies to itself';

my $uncpath2 = IO::Path::Win32.new("//server/share/a");
is $uncpath2.volume,	"//server/share",	'volume "//server/share/a" -> ""//server/share"';
is $uncpath2.directory, "/",	'directory "//server/share/a" -> "/"';
is $uncpath2.basename, 	"a",	'basename "//server/share/a" -> "a"';
is $uncpath2.Str, "//server/share/a", '"//server/share/a" restringifies to itself';

is IO::Path::Win32.new(".").Str,		".",		"current directory";
is IO::Path::Win32.new("..").Str,		"..",		"parent directory";
is IO::Path::Win32.new('').Str,			"",		"empty is empty";

is IO::Path::Win32.new("/usr/////local/./bin/././perl/").cleanup, "\\usr\\local\\bin\\perl",
	"cleanup '/usr/////local/./bin/././perl/' -> '\\usr\\local\\bin\\perl'";

ok $relpath.is-relative,	"relative path is-relative";
nok $relpath.is-absolute,	"relative path ! is-absolute";
nok $abspath.is-relative,	"absolute path ! is-relative";
ok $abspath.is-absolute,	"absolute path is-absolute";
ok $uncpath.is-absolute,	"UNC path is-absolute";
ok $uncpath2.is-absolute,	"UNC path with forward slash is-absolute";
ok IO::Path::Win32.new("/foo").is-absolute,	"path beginning with forward slash is absolute";
ok IO::Path::Win32.new("A:\\").is-absolute,	'"A:\\" is absolute';
ok IO::Path::Win32.new("A:b").is-relative,	'"A:b" is relative';

#?rakudo 5 skip '.absolute with no args causes infinite loop on windows'
is $relpath.absolute,		IO::Spec::Win32.canonpath("$*CWD\\foo\\bar"),	"absolute path from \$*CWD";
is $relpath.absolute("\\usr"),	"\\usr\\foo\\bar",		"absolute path specified";
is IO::Path::Win32.new("\\usr\\bin").relative("/usr"),	"bin",			"relative path specified";
is $relpath.absolute.relative,  "foo\\bar",		"relative inverts absolute";
is $relpath.absolute("/foo").relative("\\foo"), "foo\\bar","absolute inverts relative";
#?rakudo 1 skip 'resolve NYI, needs nqp::readlink'
is $abspath.relative.absolute.resolve, "\\foo\\bar",	"absolute inverts relative with resolve";

is IO::Path::Win32.new("foo/bar").parent,		"foo",			"parent of 'foo/bar' is 'foo'";
is IO::Path::Win32.new("foo").parent,			".",			"parent of 'foo' is '.'";
is IO::Path::Win32.new(".").parent,			"..",			"parent of '.' is '..'";
is IO::Path::Win32.new("..").parent,			"..\\..",		"parent of '..' is '../..'";
is IO::Path::Win32.new("\\foo").parent,			"\\",			"parent at top level is '/'";
is IO::Path::Win32.new("\\").parent,			"\\",			"parent of root is '/'";

is IO::Path::Win32.new("\\").child('foo'),	"\\foo",		"append to root";
is IO::Path::Win32.new(".").child('foo'),	"foo",		"append to cwd";

if IO::Spec.FSTYPE eq 'Win32' {
	ok IO::Path::Win32.new($*CWD).e,		"cwd exists, filetest inheritance ok";
	ok IO::Path::Win32.new($*CWD).d,		"cwd is a directory";
}
else {
	skip "On-system tests for filetest inheritance", 2;
}


done;

