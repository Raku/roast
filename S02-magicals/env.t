use v6;

# Tests for magic variables

use Test;
# L<S28/Named variables>
plan 16;

if $*OS eq "browser" {
  skip_rest "Programs running in browsers don't have access to regular IO.";
  exit;
}

=begin desc

= DESCRIPTION

Tests for %*ENV

Tests that C<%*ENV> can be read and written to and that
child processes see the modified C<%*ENV>.

=end desc

# It must not be empty at startup.
ok +%*ENV.keys, '%*ENV has keys';

# %*ENV should be able to get copied into another variable.
my %vars = %*ENV;
is +%vars.keys, +%*ENV.keys, '%*ENV was successfully copied into another variable';

# XXX: Should modifying %vars affect the environment? I don't think so, but, of
# course, feel free to change the following test if I'm wrong.
%vars<PATH> = "42";
ok %*ENV<PATH> ne "42",
  'modifying a copy of %*ENV didn\'t affect the environment';

# Similarily, I don't think creating a new entry in %vars should affect the
# environment:
diag '%*ENV<PUGS_ROCKS>=' ~ %*ENV<PUGS_ROCKS>;
ok !defined(%*ENV<PUGS_ROCKS>), "there's no env variable 'PUGS_ROCKS'";
%vars<PUGS_ROCKS> = "42";
diag '%*ENV<PUGS_ROCKS>=' ~ %*ENV<PUGS_ROCKS>;
ok !defined(%*ENV<PUGS_ROCKS>), "there's still no env variable 'PUGS_ROCKS'";

my ($redir,$squo) = (">", "'");

my $expected = 'Hello from subprocess';
%*ENV<PUGS_ROCKS> = $expected;
# Note that the "?" preceding the "(" is necessary, because we need a Bool,
# not a junction of Bools.
is %*ENV<PUGS_ROCKS>, $expected,'%*ENV is rw';

my $tempfile = "temp-ex-output." ~ $*PID ~ "." ~ 1000.rand;

my $command = qq!$*EXECUTABLE_NAME -e "\%*ENV.perl.say" $redir $tempfile!;
diag $command;
shell $command;

my $child_env = slurp $tempfile;
my %child_env = eval $child_env;
unlink $tempfile;

my $err = 0;
for %*ENV.kv -> $k,$v {
  # Ignore env vars which bash and maybe other shells set automatically.
  next if $k eq any <SHLVL _ OLDPWD PS1>;
  if (%child_env{$k} !~~ $v) {
    if (! $err) {
      #?rakudo todo 'nom regression'
      flunk("Environment gets propagated to child.");
      $err++;
    };
    diag "Expected: $k=$v";
    diag "Got:      $k=%child_env{$k}";
  } else {
    # diag "$k=$v";
  };
};
if (! $err) {
  ok(1,"Environment gets propagated to child.");
};

%*ENV.delete('PUGS_ROCKS');
ok(!%*ENV.exists('PUGS_ROCKS'), 'We can remove keys from %*ENV');

$command = qq!$*EXECUTABLE_NAME -e "\%*ENV.perl.say" $redir $tempfile!;
diag $command;
shell $command;

$child_env = slurp $tempfile;
%child_env = eval $child_env;
unlink $tempfile;

ok(!%child_env.exists('PUGS_ROCKS'), 'The child did not see %*ENV<PUGS_ROCKS>');

$err = 0;
for %*ENV.kv -> $k,$v {
  # Ignore env vars which bash and maybe other shells set automatically.
  next if $k eq any <SHLVL _ OLDPWD PS1>;
  if (%child_env{$k} !~~ $v) {
    if (! $err) {
      flunk("Environment gets propagated to child.");
      $err++;
    };
    diag "Expected: $k=$v";
    diag "Got:      $k=%child_env{$k}";
  } else {
    # diag "$k=$v";
  };
};
if (! $err) {
  ok(1,"Environment gets propagated to child.");
};

ok !%*ENV.exists("does_not_exist"), "exists() returns false on a not defined env var";

# %ENV must not be imported by default
#?rakudo skip 'set_pmc() not implemented in class Exception'
#?pugs todo 'bug'
{
    my $x = eval "%ENV";
    ok $! ~~ m:P5/Undeclared/, '%ENV not visible by default';
}

# following doesn't parse yet
#?rakudo skip 'import keyword'
{
    # It must be importable
    import PROCESS <%ENV>;
    ok +%ENV.keys, 'imported %ENV has keys';
}

# Importation must be lexical
#?pugs todo 'bug'
{
    try { eval "%ENV" };
    ok $!.defined, '%ENV not visible by after lexical import scope';
    1;
}

# RT #78256
{
    nok %*ENV<NOSUCHENVVAR>.defined, 'non-existing vars are undefined';
    nok %*ENV.exists('NOSUCHENVVAR'), 'non-existing vars do not exist';

}

# vim: ft=perl6
