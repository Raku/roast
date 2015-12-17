use v6;
use Test;

plan 16;

# L<S32::IO/IO::Path>

my $path = '/foo/bar.txt'.IO;
isa-ok $path, IO::Path, "Str.IO returns an IO::Path";
is IO::Path.new('/foo/bar.txt'), $path,
   "Constructor works without named arguments";

is IO::Path.new(:basename<bar.txt>), IO::Path.new('bar.txt'),
    "Can use either :basename or positional argument";

is IO::Path.new(:dirname</foo>, :basename<bar.txt>).cleanup, $path.cleanup,
    "Can construct path from :dirname and :basename";

# This assumes slash-separated paths, so it will break on, say, VMS

is $path.volume,          '', 'volume';
is $path.dirname,     '/foo', 'dirname';
is $path.basename, 'bar.txt', 'basename';
#?niecza 2 skip '.parent NYI'
is $path.parent,    '/foo',    'parent';
is $path.parent.parent, '/',   'parent of parent';
#?niecza 2 skip '.is-absolute, .is-relative NYI'
is $path.is-absolute, True,    'is-absolute';
is $path.is-relative, False,   'is-relative';

isa-ok $path.path, Str,      'IO::Path.path returns Str';
#?niecza skip 'IO::Handle still called IO'
isa-ok $path.IO,   IO::Path, 'IO::Path.IO returns IO::Path';

# Try to guess from context that the correct backend is loaded:
#?niecza skip 'is-absolute NYI'
#?DOES 2
{
  if $*DISTRO.name eq any <win32 mswin32 os2 dos symbian netware> {
      ok "c:\\".IO.is-absolute, "Win32ish OS loaded (volume)";
      is "/".IO.cleanup, "\\", "Win32ish OS loaded (back slash)"
  }
  elsif $*DISTRO.name eq 'cygwin' {
      ok "c:\\".IO.is-absolute, "Cygwin OS loaded (volume)";
      is "/".IO.cleanup, "/", "Cygwin OS loaded (forward slash)"
  }
  else { # assume POSIX
      nok "c:\\".IO.is-absolute, "POSIX OS loaded (no volume)";
      is "/".IO.cleanup, "/", "POSIX OS loaded (forward slash)"
  }
}

# RT #126935
{
    my $perl = "/foo|\\bar".IO.perl;
    is $perl.EVAL.perl, $perl, "does $perl roundtrip?";
}
