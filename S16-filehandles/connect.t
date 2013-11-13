use v6;

use Test;

# L<S32::IO/IO::File/open>
# L<S32::IO/IO/uri>
# L<S29/IO/connect>
# old: L<S16/"Filehandles, files, and directories"/"connect">

=begin pod

Tests for IO connect() builtin

=end pod

plan 4;

my $skip_var = 'PERL_TESTS_ALLOW_NETWORK';
unless %*ENV{$skip_var} {
  skip_rest "Won't test &connect as environment variable \"$skip_var\" is not true.";
  exit;
}

{
  my $fh = connect "google.com", 80;

  my $nl = chr(13) ~ chr(10);
  $fh.print("GET / HTTP/1.0{$nl}Host: google.de{$nl}User-Agent: pugs/connect.t{$nl}Connection: close$nl$nl");
  $fh.flush();

  ok index($fh.readline, "HTTP/") > -1, "connect('google.de', 80) works";
}

{
  dies_ok { connect "localhost", 70000 }, "&connect fails when it can't connect";
}

skip_rest("waiting on 'use fatal'"); exit;

{
  # no fatal;
  lives_ok { connect "localhost", 70000 },
    "&connect does not die when it can't connect";

  ok !connect("localhost", 70000),
    "&connect returns a false value when it can't connect";
}

# vim: ft=perl6
