use v6;
use Test;
# L<S32::IO/IO::Path>

plan 50;

# Make sure we have a controlled environment
my $*SPEC = IO::Spec::Cygwin;
my $*CWD  = '/zip/loc/';

my $relpath = IO::Path::Cygwin.new('foo/bar' );
my $abspath = IO::Path::Cygwin.new('/foo/bar');

isa_ok $abspath, IO::Path, "Can create IO::Path::Cygwin";
is $abspath.volume,    "",     'volume "/foo/bar" -> ""';
is $abspath.directory, "/foo", 'directory "/foo/bar" -> "/foo"';
is $abspath.basename,  "bar",  'basename "/foo/bar" -> "bar"';


my $path = IO::Path::Cygwin.new('C:foo\\\\bar\\');
is $path.volume,    "C:",  'volume "C:foo\\\\bar\\" -> "C:"';
is $path.directory, "foo", 'directory "C:foo\\\\bar\\" -> "foo"';
is $path.basename,  "bar", 'basename "C:foo\\\\bar\\" -> "bar"';
isa_ok $path.path, Str, ".path returns Str of path";

is $path.perl.EVAL, $path, ".perl loopback";

my $uncpath = IO::Path::Cygwin.new("\\\\server\\share\\");
is $uncpath.volume, "//server/share", 'volume "//server/share/" -> ""/server/share"';
is $uncpath.directory, "/", 'directory "\\\\server\\share\\" -> "\\"';
is $uncpath.basename,  "/", 'basename "\\\\server\\share\\" -> "\\"';
is $uncpath.Str, "\\\\server\\share\\", '"\\\\server\\share" restringifies to itself';

my $uncpath2 = IO::Path::Cygwin.new("//server/share/a");
is $uncpath2.volume, "//server/share", 'volume "//server/share/a" -> ""//server/share"';
is $uncpath2.directory, "/", 'directory "//server/share/a" -> "/"';
is $uncpath2.basename,  "a", 'basename "//server/share/a" -> "a"';
is $uncpath2.Str, "//server/share/a", '"//server/share/a" restringifies to itself';

is IO::Path::Cygwin.new(".").Str,        ".",        "current directory";
is IO::Path::Cygwin.new("..").Str,        "..",        "parent directory";
is IO::Path::Cygwin.new('').Str,        "",        "empty is empty";

is IO::Path::Cygwin.new("/usr/////local/./bin/.\\./perl/").cleanup, "/usr/local/bin/perl",
    "cleanup '/usr/////local/./bin/.\\./perl/' -> '/usr/local/bin/perl'";

ok $relpath.is-relative,    "relative path is-relative";
nok $relpath.is-absolute,    "relative path ! is-absolute";
nok $abspath.is-relative,    "absolute path ! is-relative";
ok $abspath.is-absolute,    "absolute path is-absolute";
ok $uncpath.is-absolute,    "UNC path is-absolute";
ok $uncpath2.is-absolute,    "UNC path with forward slash is-absolute";
ok IO::Path::Cygwin.new("\\foo").is-absolute,    "path beginning with backslash is absolute";
ok IO::Path::Cygwin.new("A:\\").is-absolute,    '"A:\\" is absolute';
ok IO::Path::Cygwin.new("A:b").is-relative,    '"A:b" is relative';


is $relpath.absolute,    IO::Spec::Cygwin.canonpath("$*CWD/foo/bar"),    "absolute path from \$*CWD";
is $relpath.absolute("/usr"), "/usr/foo/bar", "absolute path specified";
is IO::Path::Cygwin.new("/usr/bin").relative("/usr"), "bin", "relative path specified";

is $relpath.absolute.IO.relative,  "foo/bar", "relative inverts absolute";
is $relpath.absolute("/foo").IO.relative("\\foo"), "foo/bar", "absolute inverts relative";
#?rakudo 1 todo 'resolve NYI, needs nqp::readlink'
is $abspath.relative.IO.absolute.IO.resolve, "\\foo\\bar", "absolute inverts relative with resolve";

is IO::Path::Cygwin.new("foo/bar").parent,        "foo",            "parent of 'foo/bar' is 'foo'";
is IO::Path::Cygwin.new("foo").parent,            ".",            "parent of 'foo' is '.'";
is IO::Path::Cygwin.new(".").parent,            "..",            "parent of '.' is '..'";
is IO::Path::Cygwin.new("..").parent,            "../..",        "parent of '..' is '../..'";
is IO::Path::Cygwin.new("/foo").parent,            "/",            "parent at top level is '/'";
is IO::Path::Cygwin.new("/").parent,            "/",            "parent of root is '/'";
is IO::Path::Cygwin.new("\\").parent,            "/",            "parent of root ('\\') is '/'";

is IO::Path::Cygwin.new("/").child('foo'),    "/foo",        "append to root";
is IO::Path::Cygwin.new(".").child('foo'),    "foo",        "append to cwd";

my $numfile = IO::Path::Unix.new("foo/file01.txt");
is $numfile.succ,    "foo/file02.txt", "succ basic";
is $numfile.succ.succ,    "foo/file03.txt", "succ x 2";
is $numfile.pred,    "foo/file00.txt", "pred basic";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "succ only effects basename";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "pred only effects basename";
