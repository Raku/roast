use v6;

use Test;

=begin description

Test that C< $*PID > in this process is different from
C< $*PID > in the child process.
L<A05/"RFC 332: Regex: Make /\$/ equivalent to /\z/ under the '/s' modifier" /The current process id is now C<\$\*PID>/>

=end description

plan 1;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to \$*PID.";
  exit;
}

my ($pugs,$redir,$squo) = ($*EXECUTABLE_NAME, ">", "'");

# if it's non-perl5 js backend the test would have been skipped already
$pugs = './runjs.pl --run=jspm --perl5'
    if $?PUGS_BACKEND eq 'BACKEND_JAVASCRIPT';

if $*OS eq any <MSWin32 mingw msys cygwin> {
    $pugs = 'pugs.exe';
};

sub nonce () { return (".$*PID." ~ int rand 1000) }
my $tempfile = "temp-ex-output" ~ nonce;

my $command = $pugs ~ q! -e 'say $PID'! ~ qq!$redir $tempfile!;
diag $command;
system $command;

my $child_pid = slurp $tempfile;
$child_pid .= chomp;
unlink $tempfile;

ok $*PID ne $child_pid, "My PID differs from the child pid ($*PID != $child_pid)";
