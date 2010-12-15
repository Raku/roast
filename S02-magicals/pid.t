use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' }
use Test::Util;

=begin description

Test that C< $*PID > in this process is different from
C< $*PID > in the child process.
L<A05/"RFC 332: Regex: Make /\$/ equivalent to /\z/ under the '/s' modifier" /The current process id is now C<\$\*PID>/>

=end description

plan 1;

is_run 'say $*PID',
    {
        out => -> $p { $p > 0 && $p != $*PID },
        err => '',
        status => 0,
    }, 'my $*PID is different from a child $*PID';

# vim: ft=perl6
