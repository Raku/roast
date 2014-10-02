use v6;
use Test;
# L<S32::IO/IO::Path>

plan 51;

my $relpath = IO::Path::Win32.new('foo\\bar' );
my $abspath = IO::Path::Win32.new('\\foo\\bar');

isa_ok $abspath, IO::Path, "Can create IO::Path::Win32";
is $abspath.volume,   "",      'volume "\\foo\\bar" -> ""';
is $abspath.dirname,  "\\foo", 'dirname "\\foo\\bar" -> "\\foo"';
is $abspath.basename, "bar",   'basename "\\foo\\bar" -> "bar"';

my $path = IO::Path::Win32.new('C:foo//bar//');
is $path.volume,   "C:",  'volume "C:foo//bar//" -> "C:"';
is $path.dirname,  "foo", 'dirname "C:foo//bar//" -> "foo"';
is $path.basename, "bar", 'basename "C:foo//bar//" -> "bar"';
isa_ok $path.path, Str, ".path returns Str";
is $path.perl.EVAL, $path, ".perl loopback";

my $uncpath = IO::Path::Win32.new("\\\\server\\share\\");
is $uncpath.volume,   "\\\\server\\share",
  'volume "\\\\server\\share\\" -> ""\\\\server\\share"';
is $uncpath.dirname,  "\\", 'dirname "\\\\server\\share\\" -> "\\"';
is $uncpath.basename, "\\", 'basename "\\\\server\\share\\" -> "\\"';
is $uncpath.Str, "\\\\server\\share\\",
  '"\\\\server\\share\\" restringifies to itself';

my $uncpath2 = IO::Path::Win32.new("//server/share/a");
is $uncpath2.volume,   "//server/share",
  'volume "//server/share/a" -> ""//server/share"';
is $uncpath2.dirname,  "/", 'directory "//server/share/a" -> "/"';
is $uncpath2.basename, "a", 'basename "//server/share/a" -> "a"';
is $uncpath2.Str, "//server/share/a", '"//server/share/a" restringifies to itself';

is IO::Path::Win32.new(".").Str,  ".",  "current directory";
is IO::Path::Win32.new("..").Str, "..", "parent directory";
is IO::Path::Win32.new('').Str,   "",   "empty is empty";

is IO::Path::Win32.new("/usr/////local/./bin/././perl/").cleanup,
  "\\usr\\local\\bin\\perl",
  "cleanup '/usr/////local/./bin/././perl/' -> '\\usr\\local\\bin\\perl'";

ok $relpath.is-relative,  "relative path is-relative";
nok $relpath.is-absolute, "relative path ! is-absolute";
nok $abspath.is-relative, "absolute path ! is-relative";
ok $abspath.is-absolute,  "absolute path is-absolute";
ok $uncpath.is-absolute,  "UNC path is-absolute";
ok $uncpath2.is-absolute, "UNC path with forward slash is-absolute";
ok IO::Path::Win32.new("/foo").is-absolute, "path beginning with forward slash is absolute";
ok IO::Path::Win32.new("A:\\").is-absolute, '"A:\\" is absolute';
ok IO::Path::Win32.new("A:b").is-relative,  '"A:b" is relative';

is $relpath.absolute,        IO::Spec::Win32.canonpath("$*CWD\\foo\\bar"),    "absolute path from \$*CWD";
is $relpath.absolute("\\usr"),    "\\usr\\foo\\bar",        "absolute path specified";
is IO::Path::Win32.new("\\usr\\bin").relative("/usr"),    "bin",            "relative path specified";
{
    my $*SPEC = IO::Spec::Win32;  # .IO needs to have IO::Spec::Win32
    is $relpath.absolute.IO.relative,  "foo\\bar", "relative inverts absolute";
    is $relpath.absolute("/foo").IO.relative("\\foo"), "foo\\bar","absolute inverts relative";
    #?rakudo 1 todo 'resolve NYI, needs nqp::readlink'
    is $abspath.relative.IO.absolute.IO.resolve, "\\foo\\bar",    "absolute inverts relative with resolve";
}

is IO::Path::Win32.new("foo/bar").parent, "foo",    "parent of 'foo/bar' is 'foo'";
is IO::Path::Win32.new("foo").parent,     ".",      "parent of 'foo' is '.'";
is IO::Path::Win32.new(".").parent,       "..",     "parent of '.' is '..'";
is IO::Path::Win32.new("..").parent,      "..\\..", "parent of '..' is '../..'";
is IO::Path::Win32.new("\\foo").parent,   "\\",     "parent at top level is '/'";
is IO::Path::Win32.new("\\").parent,      "\\",     "parent of root is '/'";

is IO::Path::Win32.new("\\").child('foo'), "\\foo", "append to root";
is IO::Path::Win32.new(".").child('foo'),  "foo",   "append to cwd";

my $numfile = IO::Path::Win32.new("foo\\file01.txt");
is $numfile.succ,    "foo\\file02.txt", "succ basic";
is $numfile.succ.succ,    "foo\\file03.txt", "succ x 2";
is $numfile.pred,    "foo\\file00.txt", "pred basic";
is IO::Path::Win32.new("foo\\()").succ, "foo\\()", "succ only effects basename";
is IO::Path::Win32.new("foo\\()").succ, "foo\\()", "pred only effects basename";

if IO::Spec.FSTYPE eq 'Win32' {
    ok IO::Path::Win32.new(~$*CWD).e,        "cwd exists, filetest inheritance ok";
    ok IO::Path::Win32.new(~$*CWD).d,        "cwd is a directory";
}
else {
    skip "On-system tests for filetest inheritance", 2;
}
