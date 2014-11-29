use v6;
use Test;
# L<S32::IO/IO::Path>

plan 35;

# make sure we have a controlled environment here
my $*SPEC = IO::Spec::Unix;
my $*CWD = '/zip/loc'.IO;

my $relpath = IO::Path::Unix.new('foo/bar' );
my $abspath = IO::Path::Unix.new('/foo/bar');
isa_ok $abspath, IO::Path, "Can create IO::Path::Unix";
is $abspath.volume,    "",     "volume is empty on POSIX";
is $abspath.dirname, "/foo", 'dirname "/foo/bar" -> "/foo"';
is $abspath.basename,  "bar",  'basename "/foo/bar" -> "bar"';

my $path = IO::Path::Unix.new('foo//bar//');
is $path.dirname,  "foo", 'dirname "foo//bar//" -> "foo"';
is $path.basename, "bar", 'basename "foo//bar//" -> "bar"';
isa_ok $path.path, Str, ".path returns Str";
say $path.perl;
is $path.perl.EVAL, $path, ".perl loopback";

is IO::Path::Unix.new(".").Str,  ".",  "current directory";
is IO::Path::Unix.new("..").Str, "..", "parent directory";
is IO::Path::Unix.new('').Str,   "",   "empty is empty";

is IO::Path::Unix.new("/usr/////local/./bin/././perl/").cleanup,
  "/usr/local/bin/perl",
  "cleanup '/usr/////local/./bin/././perl/' -> '/usr/local/bin/perl'";

ok $relpath.is-relative,  "relative path is-relative";
nok $relpath.is-absolute, "relative path ! is-absolute";
nok $abspath.is-relative, "absolute path ! is-relative";
ok $abspath.is-absolute,  "absolute path is-absolute";

is $relpath.absolute, IO::Spec::Unix.canonpath("$*CWD/foo/bar"),
  "absolute path from \$*CWD";
is $relpath.absolute("/usr"), "/usr/foo/bar",
  "absolute path specified";
is IO::Path::Unix.new("/usr/bin").relative("/usr"), "bin",
  "relative path specified";

is $relpath.absolute.IO.relative, "foo/bar",
  "relative inverts absolute";
is $relpath.absolute("/foo").IO.relative("/foo"),
  "foo/bar","absolute inverts relative";
#?rakudo 1 todo 'resolve NYI, needs nqp::readlink'
is $abspath.relative.IO.absolute.IO.resolve, "/foo/bar", "absolute inverts relative with resolve";

is IO::Path::Unix.new("foo/bar").parent, "foo",   "parent of 'foo/bar' is 'foo'";
is IO::Path::Unix.new("foo").parent,     ".",     "parent of 'foo' is '.'";
is IO::Path::Unix.new(".").parent,       "..",    "parent of '.' is '..'";
is IO::Path::Unix.new("..").parent,      "../..", "parent of '..' is '../..'";
is IO::Path::Unix.new("/foo").parent,    "/",     "parent at top level is '/'";
is IO::Path::Unix.new("/").parent,       "/",     "parent of root is '/'";

is IO::Path::Unix.new("/").child('foo'), "/foo",  "append to root";
is IO::Path::Unix.new(".").child('foo'), "foo",   "append to cwd";

my $numfile = IO::Path::Unix.new("foo/file01.txt");
is $numfile.succ,      "foo/file02.txt", "succ basic";
is $numfile.succ.succ, "foo/file03.txt", "succ x 2";
is $numfile.pred,      "foo/file00.txt", "pred basic";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "succ only effects basename";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "pred only effects basename";
