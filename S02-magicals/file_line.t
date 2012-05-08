use v6;


use Test;

plan 2;

# L<S02/Names/Which line am I at>
is($?LINE, 10, '$?LINE works');

# L<S02/Names/Which file am I in>
# try to be robust for implementations that use Win32 file paths, or
# absolute paths, or whatever
ok($?FILE ~~ rx/'S02-magicals'<[\/\\]>'file_line.t'/, '$?FILE works');


# vim: ft=perl6
