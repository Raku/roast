use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 48;

# Basic functionality

is_run 'sub MAIN($x) { }; sub USAGE() { print "USAGE() called" }',
    {out => 'USAGE() called'},
    'a user-defined USAGE sub is called if MAIN dispatch fails';

is_run 'sub MAIN() { print "MAIN() called" }; sub USAGE() { print "USAGE() called" }',
    {out => 'MAIN() called', status => 0},
    'a user-defined USAGE sub is not called if MAIN dispatch succeeds';

is_run 'sub MAIN( $a = nosuchsub()) { }; sub USAGE { say 42 }',
    { out => '', err => /nosuchsub/},
    'if the MAIN dispatch results in an error, that error should be printed, not USAGE';

is_run 'sub MAIN($foo) { }', { err => /<< foo >>/, out => ''},
    'auto-generated USAGE message goes to $*ERR and contains parameter name';

is_run 'sub MAIN(\bar) { }', {err => /<< bar >>/},
    'auto-generated USAGE should handle sigilles parameters';

is_run 'sub MAIN($bar) { }', {out => /<< bar >>/}, :args['--help'],
    '--help option sends auto-generated USAGE message to $*OUT';

is_run 'sub MAIN(Bool :$x) { say "yes" if $x }',
    {out => "yes\n", err => '', status => 0}, :args['--x'], 'boolean option +';

is_run 'sub MAIN(Bool :$x) { print "yes" if $x }', {out => ""}, :args['--/x'],
    'boolean option -';

is_run 'sub MAIN(:$x) { print $x }', {out => "23"}, :args['--x=23'],
    'option with value';

is_run 'sub MAIN(:xen(:$xin)) { print $xin }', {out => "23"}, :args['--xin=23'],
    'named alias (inner name)';

is_run 'sub MAIN(:xen(:$xin)) { print $xin }', {out => "23"}, :args['--xen=23'],
    'named alias (outer name)';

# https://github.com/Raku/old-issue-tracker/issues/1443
is_run 'sub MAIN($a, :$var) { say "a: $a, optional: $var"; }',
    {err => /\-\-var/, out => ''}, :args['param', '--var'],
    'Non Bool option last with no value';

is_run 'sub MAIN($a, Bool :$var) { say "a: $a, optional: $var"; }',
    {out => "a: param, optional: True\n"}, :args['--var', 'param'],
    'Bool option followed by positional value';

# Arguments with vertical or horizontal space don't get quoted corrected using is_run
# so many of the following tests use run directly to work around issues on windows.

# https://github.com/Raku/old-issue-tracker/issues/4714
subtest 'Valid arg with zero length value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.print }', '-y=';
    is $proc.out.slurp(:close), '';
    is $proc.err.slurp(:close), '';
}

subtest 'Valid arg with single space value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.print }', '-y= ';
    is $proc.out.slurp(:close), '32';
    is $proc.err.slurp(:close), '';
}

subtest 'Valid arg with two space value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.join(" ").print }', '-y=  ';
    is $proc.out.slurp(:close), '32 32';
    is $proc.err.slurp(:close), '';
}

subtest 'Valid arg with newline value' => {
    # Fails on windows - \n is seemingly lost such that .out.slurp returns a blank string
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.print }', "-y=\n";
    is $proc.out.slurp(:close), '10';
    is $proc.err.slurp(:close), '';
}

subtest 'Valid arg with tab value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.print }', "-y=\t";
    is $proc.out.slurp(:close), '9';
    is $proc.err.slurp(:close), '';
}


subtest 'Valid arg with tab then space value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN(:$y) { $y.ords.join(" ").print }', "-y=\t ";
    is $proc.out.slurp(:close), '9 32';
    is $proc.err.slurp(:close), '';
}

subtest 'Extra arg with zero length value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', '-y=';
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

subtest 'Extra arg with single space value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', '-y= ';
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

subtest 'Extra arg with two space value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', '-y=  ';
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

subtest 'Extra arg with newline value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', "-y=\n";
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

subtest 'Extra arg with tab value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', "-y=\t";
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

subtest 'Extra arg with newline value' => {
    my $proc = run :out, :err, $*EXECUTABLE, '-e', 'sub MAIN() { }; sub USAGE() { "USG".note }', "-y=\t ";
    ok $proc.err.slurp(:close).match(/USG/);
    is $proc.out.slurp(:close), '';
}

# Spacey options may be removed from core spec; for now, moving to end of tests
# (discussion starts at http://irclog.perlgeek.de/perl6/2011-10-17#i_4578353 )

is_run 'sub MAIN(Any :$x) { print $x }', {:status<2>}, :args<--x 23>,
    'short option with optional argument rejects spacey value';

is_run 'sub MAIN(Str :$x) { print $x }', {:out<23>}, :args<--x 23>,
    'short option with required argument accepts spacey value';

is_run 'sub MAIN(Any :xen(:$x)) { print $x }', {:status<2>}, :args<--xen 23>,
    'long option with optional argument rejects spacey value';

is_run 'sub MAIN(Str :xen(:$x)) { print $x }', {:out<23>}, :args<--xen 23>,
    'long option with required argument accepts spacey value';

is_run 'sub MAIN(Any :xen(:$xin)) { print $xin }', {:status<2>}, :args<--xin 23>,
    'named alias (inner name) with optional argument rejects spacey value';

is_run 'sub MAIN(Str :xen(:$xin)) { print $xin }', {:out<23>}, :args<--xin 23>,
    'named alias (inner name) with required argument accepts spacey value';

is_run 'sub MAIN(Any :xen(:$xin)) { print $xin }', {:status<2>}, :args<--xen 23>,
    'named alias (outer name) with optional argument rejects spacey value';

is_run 'sub MAIN(Str :xen(:$xin)) { print $xin }', {:out<23>}, :args<--xen 23>,
    'named alias (outer name) with required argument accepts spacey value';

is_run 'sub MAIN(Any :xen(:$x)) { print $x }', {:status<2>}, :args<-x 23>,
    'named alias (short option) with optional argument rejects spacey value';

is_run 'sub MAIN(Str :xen(:$x)) { print $x }', {:out<23>}, :args<-x 23>,
    'named alias (short option) with required argument accepts spacey value';

is_run 'subset Command of Str where "run";
        multi MAIN(Command $c) { print 1 },
        multi MAIN()           { print 2 }
    ', {:out<2>};


# https://github.com/Raku/old-issue-tracker/issues/2441
is_run 'multi MAIN($) { print q[Any] }; multi MAIN(Str) { print q[Str] }',
    {:out<Str>}, :args['foo'],
    'best multi matches (not just first one)';

is_run 'sub MAIN() { print 42 }',
    {:out(''), err => rx:i/usage/}, :args['--foo'],
    'superfluous options trigger usage message';

# https://github.com/Raku/old-issue-tracker/issues/2973
is_run 'sub MAIN($arg) { print $arg }', {:out<--23>}, :args['--', '--23'],
    'Stopping option processing';

is_run 'sub MAIN($arg, Bool :$bool) { print $bool, $arg }',
    {:out<True-option>}, :args['--bool', '--', '-option'],
    'Boolean argument with --';

# https://github.com/Raku/old-issue-tracker/issues/3950
# https://github.com/rakudo/rakudo/issues/2797
is_run 'sub MAIN(:@foo) { print @foo }', {out => "bar"}, :args['--foo=bar'],
    'single occurence for named array param';

is_run 'sub MAIN(:@foo) { print @foo }',
    {out => "bar baz"}, :args['--foo=bar', '--foo=baz'],
    'multiple occurence for named array param';

is_run 'multi MAIN(:$foo) { print "Scalar" }; multi MAIN(:@foo) { print "Array" }',
    {out => "Scalar"}, :args['--foo=bar'],
    'correctly select Scalar candidate from Scalar and Array candidates.';

#?rakudo todo 'NYI'
is_run 'multi MAIN(:$foo) { print "Scalar" }; multi MAIN(:@foo) { print "Array" }',
    {out => "Array"}, :args['--foo=bar', '--foo=baz'],
    'correct select Array candidate from Scalar and Array candidates.';

# https://github.com/Raku/old-issue-tracker/issues/3194
is_run 'sub MAIN (Str $value) { print "String $value" }',
    {out => 'String 10', err => ''}, :args[10],
    'passing an integer matches MAIN(Str)';

# https://github.com/Raku/old-issue-tracker/issues/5262
is_run 'sub MAIN(*@arg where { False }) { }; sub USAGE { print "USAGE called" }',
    {out => 'USAGE called', err => ''},
    "failed constraint check doesn't leak internal exception out to the user";

# https://github.com/Raku/old-issue-tracker/issues/5155
is_run 'sub MAIN($, *%) { }', { err => '', }, :args['--help'],
    'use of anon slurpy hash does not cause a crash';

subtest '$*USAGE tests' => {
    # Original speculations had $?USAGE, but later we realized generating
    # it at compile time is not worth the price, so it was changed to be
    # a run time variable instead:
    # https://irclog.perlgeek.de/perl6-dev/2017-09-23#i_15206569
    plan 4;

    is_run ｢sub MAIN($meow, :$moo) {}; sub USAGE { $*USAGE.uc.say }｣,
        {:out(/MEOW/ & /MOO/), :err(''), :0status },
    'default $*USAGE is available inside `sub USAGE`';

    is_run ｢sub MAIN($meow, :$moo) {$*USAGE.uc.say; $meow.say; $moo.say}｣,
        :args<--moo=31337  42>,
        {:out(/MEOW/ & /MOO/ & /42/ & /31337/), :err(''), :0status },
    'default $*USAGE is available inside `sub MAIN`';

    is_run ｢sub MAIN { try $*USAGE = "meow"; $! and "PASS".print }｣,
        {:out<PASS>, :err(''), :0status },
    'trying to assign to $*USAGE inside sub MAIN throws';

    is_run ｢
        sub MAIN ($foo) {}
        sub USAGE { try $*USAGE = "meow"; $! and "PASS".print }
    ｣, {:out<PASS>, :err(''), :0status },
    'trying to assign to $*USAGE inside sub MAIN throws';
}

# vim: expandtab shiftwidth=4
