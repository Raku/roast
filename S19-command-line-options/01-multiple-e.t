use v6;

use Test;

=begin pod

Test evaluation of multiple C<-e> switches.

Multiple C<-e> switches are supposed to work just
like C<join "\n"> concatenation .

=end pod

# L<S19/Reference/"Execute a single-line program.">

my @examples = (
 '-e print -e qq.Hello -e Pugs.',
 '-e print -we qq.Hello -e Pugs.',
 '-e print -wle qq.Hello -e Pugs.',
 '-e print -weqq.Hello -e Pugs.',
 '-e print -e qq.Hel. -e ";print" -e qq.lo. -e ";print" -e "qq.\nPugs."',
 '-e print -e qq.Hel. -w -e ";print" -e qq.lo. -w -e ";print" -e "qq.\nPugs."',
);

plan +@examples +1;

diag "Running under $*OS";

my $redir = ">";

if $*OS eq any <MSWin32 mingw msys cygwin> {
  $redir = '>';
};

sub nonce () { return (".{$*PID}." ~ (1..1000).pick) }
my $out_fn = "temp-ex-output" ~ nonce;

for @examples -> $ex {
  my $command = "$*EXECUTABLE_NAME $ex $redir $out_fn";
  diag $command;
  run $command;

  my $expected = "Hello\nPugs";
  my $got      = slurp $out_fn;

  is $got, $expected, "Multiple -e switches work and append the script";
}

my $command = qq[$*EXECUTABLE_NAME -e @ARGS.perl.say -e "" Hello Pugs $redir $out_fn];
diag $command;
run $command;

my @expected = <Hello Pugs>;
my $got      = slurp $out_fn;
$got .= chomp;
if (substr($got,0,1) ~~ "\\") {
  $got = substr($got,1);
};

my @got      = EVAL $got;
# fail "FIXME platform specific";
# ??? Worksforme on win32 (CORION)
is @got, @expected, "-e '' does not eat a following argument";

unlink $out_fn;

# vim: ft=perl6
