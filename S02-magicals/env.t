use v6;

# Tests for magic variables
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;
# L<S28/Named variables>
plan 18;

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
diag '%*ENV<PUGS_ROCKS>=' ~ (%*ENV<PUGS_ROCKS> // "");
ok !defined(%*ENV<PUGS_ROCKS>), "there's no env variable 'PUGS_ROCKS'";
%vars<PUGS_ROCKS> = "42";
diag '%*ENV<PUGS_ROCKS>=' ~ (%*ENV<PUGS_ROCKS> // "");
ok !defined(%*ENV<PUGS_ROCKS>), "there's still no env variable 'PUGS_ROCKS'";

my ($redir,$squo) = (">", "'");

# RT #77906 - can we modify the ENV?
my $expected = 'Hello from subprocess';
%*ENV<PUGS_ROCKS> = $expected;
# Note that the "?" preceding the "(" is necessary, because we need a Bool,
# not a junction of Bools.
is %*ENV<PUGS_ROCKS>, $expected,'%*ENV is rw';

%*ENV<PUGS_ROCKS>:delete;
ok(%*ENV<PUGS_ROCKS>:!exists, 'We can remove keys from %*ENV');

ok %*ENV<does_not_exist>:!exists, "exists() returns false on a not defined env var";

# %ENV must not be imported by default
throws-like { EVAL "%ENV" },
  X::Undeclared,
  '%ENV not visible by default';

#?rakudo skip 'import fails, ENV not available: RT #122339'
{
    # It must be importable
    import PROCESS <%ENV>;
    ok +%ENV.keys, 'imported %ENV has keys';
}

# Importation must be lexical
{
    try { EVAL "%ENV" };
    ok $!.defined, '%ENV not visible by after lexical import scope';
    1;
}

# RT #78256
{
    nok %*ENV<NOSUCHENVVAR>.defined, 'non-existing vars are undefined';
    nok %*ENV<NOSUCHENVVAR>:exists, 'non-existing vars do not exist';

}

{
    %*ENV<abc> = 'def';
    is_run 'print %*ENV<abc>',
    {
        status  => 0,
        out     => 'def',
        err     => '',
    },
    'ENV members persist to child processes';
}

# RT #77458
{
    %*ENV<ABC> = 'def';
    ok %*ENV.gist ~~ /ABC/, '%*ENV.gist generates something with ABC in it';
    ok %*ENV.perl ~~ /ABC/, '%*ENV.perl generates something with ABC in it';
}

# RT #117951
{
    ok $%*ENV, "itemizer works on %*ENV.";
}

# RT #125953
{
    %*ENV<FOOBAR> = 1;
    lives-ok { run($*EXECUTABLE, '-v') },
        'call run($command) after setting non-strings into %*ENV does not die';
}

# vim: ft=perl6
