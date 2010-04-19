use v6;

use Test;

=begin description

Test that C< $*PID > in this process is different from
C< $*PID > in the child process.
L<A05/"RFC 332: Regex: Make /\$/ equivalent to /\z/ under the '/s' modifier" /The current process id is now C<\$\*PID>/>

=end description

plan 1;

#?pugs emit if $*OS eq "browser" {
#?pugs emit   skip_rest "Programs running in browsers don't have access to \$*PID.";
#?pugs emit   exit;
#?pugs emit }

my ($perl6_executable,$redir,$squo) = ($*EXECUTABLE_NAME, ">", "'");

# if it's non-perl5 js backend the test would have been skipped already
#?pugs emit # $perl6_executable = './runjs.pl --run=jspm --perl5'
#?pugs emit #     if $?PUGS_BACKEND eq 'BACKEND_JAVASCRIPT';

#?pugs emit # if $*OS eq any <MSWin32 mingw msys cygwin> {
#?pugs emit #     $perl6_executable = 'pugs.exe';
#?pugs emit # };

sub nonce () { return (".{$*PID}." ~ (^1000).pick) }
my $tempfile = "temp-ex-output" ~ nonce;

my $command = $perl6_executable ~ q! -e 'say $*PID'! ~ qq!$redir $tempfile!;
diag $command;
run $command;

my $child_pid = slurp $tempfile;
$child_pid .= chomp;
unlink $tempfile;

ok $*PID ne $child_pid, "My PID differs from the child pid ($*PID != $child_pid)";

# vim: ft=perl6
