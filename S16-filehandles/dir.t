use v6;
use Test;
use FindBin;
plan 36;

# L<S32::IO/IO::DirectoryNode>
# old: L<S16/"Filehandles, files, and directories"/"IO::Dir::open">
# XXX closedir is not defined rigth now, should it be IO::Dir::close"?
# old: L<S16/"Filehandles, files, and directories"/"IO::Dir::open">
# XXX readdir is not defined rigth now, should be it IO::Dir::read"?
# old: L<S16/"Filehandles, files, and directories"/"IO::Dir::open">
# XXX rewinddir is not defined rigth now, should it be IO::Dir::rewind"?
# old: L<S16/"Filehandles, files, and directories"/"IO::Dir::open">

=begin pod

opendir/readdir support

=end pod

my $dir = opendir($FindBin::Bin);
isa_ok($dir, IO::Dir, "opendir worked on $FindBin::Bin");

my @files = readdir($dir);
ok(@files, "seems readdir worked too");

my @more_files = readdir($dir);
is(+@more_files, 0, "No more things to read");

my $row = readdir($dir);
ok(!defined($row), "in scalar context it returns undefined");

my $rew_1 = rewinddir($dir);
is($rew_1, 1, "success of rewinddir 1 returns 1");

my @files_again = readdir($dir);

is_deeply(\@files_again, @files, "same list of files retrieved after rewind");

my $rew_2 = rewinddir($dir);
is($rew_2, 1, "success of rewinddir 2 returns 1");

my @files_scalar;
loop {
    my $f = readdir($dir) orelse last;
    @files_scalar.push($f);
}
is_deeply(\@files_scalar, @files, "same list of files retrieved after rewind, using scalar context");

my $rew_3 = $dir.rewinddir;
is($rew_3, 1, 'success of rewinddir 3 using $dir.rewinddir returns 1');
my @files_dot = $dir.readdir;
is_deeply(\@files_dot, @files, 'same list of files retrieved using $dir.readdir');

my $rew_4 = $dir.rewinddir;
is($rew_4, 1, 'success of rewinddir 4 using $dir.rewinddir returns 1');

my @files_scalar_dot;
for $dir.readdir -> $f {
    @files_scalar_dot.push($f);
}
is_deeply(\@files_scalar_dot, @files, 'same list of files, using $dir.readdir in scalar context');

my @more_files_2 = $dir.readdir;
is(+@more_files_2, 0, "No more things to read");

my $row_2 = $dir.readdir;
ok(!defined($row_2), "in scalar context it returns undefined");


ok(closedir($dir), "as does closedir");

# on closed directory handler these calls should throw an exception
#my $undef = readdir($dir);
#my @empty = readdir($dir);
# rewinddir($dir);
# closedir


my $dh = opendir($FindBin::Bin);
isa_ok($dh, IO::Dir, "opendir worked");
my @files_once_more = $dh.readdir;
is_deeply(@files_once_more.sort, @files.sort, 'same list of files,after reopen');
ok($dir.closedir, 'closedir using $dir.closedir format');


# short version. read close etc...
# copied from above just shortent he methods. and append _s to every variable.
diag "Start testing for short version.";
my $dir_s = opendir($FindBin::Bin);
isa_ok($dir_s, IO::Dir, "opendir worked on $FindBin::Bin");

my @files_s = read($dir_s);
ok(@files_s, "seems read worked too");

my @more_files_s = read($dir);
is(+@more_files_s, 0, "No more things to read");

my $row_s = read($dir_s);
ok(!defined($row_s), "in scalar context it returns undefined");

my $rew_1_s = rewind($dir_s);
is($rew_1_s, 1, "success of rewind 1 returns 1");

my @files_again_s = read($dir_s);

is_deeply(\@files_again_s, @files_s, "same list of files retrieved after rewind");

my $rew_2_s = rewind($dir_s);
is($rew_2_s, 1, "success of rewind 2 returns 1");

my @files_scalar_s;
loop {
    my $f = read($dir_s) orelse last;
    @files_scalar_s.push($f);
}
is_deeply(\@files_scalar_s, @files_s, "same list of files retrieved after rewind, using scalar context");

my $rew_3_s = $dir_s.rewind;
is($rew_3_s, 1, 'success of rewind 3 using $dir.rewind returns 1');
my @files_dot_s = $dir_s.read;
is_deeply(\@files_dot_s, @files_s, 'same list of files retrieved using $dir.read');

my $rew_4_s = $dir_s.rewind;
is($rew_4_s, 1, 'success of rewind 4 using $dir.rewind returns 1');

my @files_scalar_dot_s;
for $dir_s.read -> $f {
    @files_scalar_dot_s.push($f);
}
is_deeply(\@files_scalar_dot_s, @files, 'same list of files, using $dir.read in scalar context');

my @more_files_2_s = $dir_s.read;
is(+@more_files_2_s, 0, "No more things to read");

my $row_2_s = $dir_s.read;
ok(!defined($row_2_s), "in scalar context it returns undefined");


ok(close($dir_s), "as does close");

# on closed directory handler these calls should throw an exception
#my $undef = readdir($dir);
#my @empty = readdir($dir);
# rewinddir($dir);
# closedir

my $dh_s = opendir($FindBin::Bin);
isa_ok($dh_s, IO::Dir, "opendir worked");
my @files_once_more_s = $dh_s.read;
is_deeply(@files_once_more_s.sort, @files_s.sort, 'same list of files,after reopen');
ok($dir_s.close, 'close using $dir.close format');



# vim: ft=perl6
