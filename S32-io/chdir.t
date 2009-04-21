use v6;
use Test;

plan 3;


eval_dies_ok( 'chdir()', 'Cannot call chdir without an argument' );

# change to t subfolder and see if cwd is updated

my $cwd = $*CWD;

chdir( "$*CWD/t" );

isnt( $*CWD, $cwd, 'Directory has changed' );


### Although you can use Unix style folder separator / to set folders, what's returned
### is in the native style, such as \ for windows

my $sep = '/';
if $*OS eq "MSWin32" {
    $sep = '\\';
}#if

is( $*CWD, "$cwd{$sep}t", 'Current directory is "t" subfolder' );
