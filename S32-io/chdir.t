use v6;
use Test;

# L<S32::IO/IO::DirectoryNode/chdir>

plan 10;

dies_ok { chdir() }, 'Cannot call chdir without an argument';

### Although you can use Unix style folder separator / to set folders, what's returned
### is in the native style, such as \ for windows
my $sep = '/';
if $*OS eq "MSWin32" {
    $sep = '\\';
}

# change to t subfolder and see if cwd is updated
my $cwd = $*CWD;
ok chdir("$*CWD/t"), 'chdir gave a true value';
isnt $*CWD, $cwd, 'Directory has changed';
is $*CWD, "$cwd{$sep}t", 'Current directory is "t" subfolder (absolute)';

# relative change back up.
ok chdir( ".." ), 'chdir gave a true value';
is $*CWD, $cwd, 'Change back up to .. worked';

# relative change to t
ok chdir( "t" ), 'chdir gave a true value';
is $*CWD, "$cwd{$sep}t", 'Current directory is "t" subfolder (relative)' ;

lives_ok { chdir("lol does not exist") }, 'chdir to a non-existant does not by default throw an exception';
ok !chdir("lol does not exist"), 'change to non-existant directory gives a false value';
