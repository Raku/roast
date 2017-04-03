use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

# L<S32::IO/Functions/chdir>

plan 8;

throws-like ' chdir() ', Exception, 'Cannot call chdir without an argument';

### You can use Unix style folder separator / to set folders on windows too.
my $sep = '/';

# change to t subfolder and see if cwd is updated
my $subdir = 't';
if $subdir.IO !~~ :d {
    skip "Directory, '$subdir', does not exist", 7;
}
else {
    my $cwd = $*CWD;
    ok chdir("$*CWD/$subdir"), 'chdir gave a true value';
    isnt $*CWD.cleanup, $cwd.cleanup, 'Directory has changed';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "Current directory is '$subdir' subfolder (absolute)";

    # relative change back up.
    ok chdir( ".." ), 'chdir gave a true value';
    is $*CWD.cleanup, $cwd.cleanup, 'Change back up to .. worked';

    # relative change to t
    ok chdir( "$subdir" ), 'chdir gave a true value';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "Current directory is '$subdir' subfolder (relative)";
}

# vim: ft=perl6
