use v6;

use Test;

=begin pod

Test C<-p> implementation

The C<-p> command line switch mimics the Perl5 C<-p> command line
switch, and wraps the whole script in

  for (lines) {
    ...         # your script
    .say;
  };

=end pod

# L<S19/Reference/"Act like sed.">

my @examples = (
  '-p',
  '-p "-e1;"',
  '-pe ";"',
  '-pe ""',
  '-p "-e1;" "-e1;"',
  '"-e1;" -p "-e1;"',
);

plan +@examples;

diag "Running under $*OS";

my ($redir_in,$redir_out) = ("<", ">");

my $str = "
foo
bar
";

sub nonce () { return (".{$*PID}." ~ (1..1000).pick) }
my ($in_fn, $out_fn) = <temp-ex-input temp-ext-output> >>~>> nonce;
my $h = open("$in_fn", :w);
$h.print($str);
$h.close();

for @examples -> $ex {
  my $command = "$*EXECUTABLE_NAME $ex $redir_in $in_fn $redir_out $out_fn";
  diag $command;
  run $command;

  my $expected = $str;
  my $got      = slurp $out_fn;
  unlink $out_fn;

  is $got, $expected, "$ex works like cat";
}

unlink $in_fn;

# vim: ft=perl6
