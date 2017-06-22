#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

# windows / cross platform needs -e "" with EVAL and \c[DOLLAR SIGN]
my $impl = `perl6 -e "EVAL qq/say \\c[DOLLAR SIGN]*PERL.compiler.name, '.', \\c[DOLLAR SIGN]*VM.name/" 2>&1`;
die capture_error('perl6', $impl) if $?;
chomp($impl);

my ($compiler) = $impl =~ /([^.]*)[.]?/; 

my $fudge_run_test = fudge_test_to_run_test('t/01-implname.in');

fudge_and_run_ok(
    $fudge_run_test, 'Test with no specced implementation', {}, {
        todo_passed => '2, 5-' . ($impl eq $compiler ? '8' : '9')
    }
);
fudge_and_run_ok(
    $fudge_run_test, 'Test with implementation and no backend',
    { impl => $compiler }, { todo_passed => '2, 5-8' }
);
if ($impl ne $compiler) {
    fudge_and_run_ok(
        $fudge_run_test, 'Test with implementation and backend',
        { impl => $impl }, { todo_passed => '2, 5-9' }
    );
    fudge_and_run_ok(
        $fudge_run_test, 'Test with just backend',
        { backend => substr($impl, length($compiler) + 1) },
        { todo_passed => '2, 5-9' }
    );
}

$fudge_run_test = fudge_test_to_run_test('t/04-combinations.in');
fudge_and_run_ok(
    $fudge_run_test, 'Test with version below #?v version',
    { version => 'v6.0.0' }
);
fudge_and_run_ok(
    $fudge_run_test, 'Test with version at #?v version',
    { version => 'v6.0.5' }, { todo_passed => '3' }
);

done_testing();

######################################################################
# We shell out for some commands and usually don't expect errors,
# but if there is an error would like helpful message
######################################################################
sub capture_error {
    my ($cmd, $output) = @_;
    my $rc  =   $? == -1    ?   -1
            :   $? & 127    ?   'signal ' . $? & 127
            :   $? >> 8;
    my $err = $! || $output if $?; # undef warn unless $? - wy were we called?

    return <<"EO_ERR"
Could not run $cmd
    System rc: $rc
    error: $err
EO_ERR
}

######################################################################
# Make a copy of a fudge test file with
# #?impl-1(.backend?) translated to perl6 implementation / compiler
######################################################################
sub fudge_test_to_run_test {
    my $fudge_test = shift;
    open my $fudge_fh, $fudge_test or
        die "Could not open file $fudge_test for read: $!";

    my $run_test = $fudge_test;
    $run_test =~ s/\.in$/.run.in/ or
        die "Could not substitute .run.in for .in on fudge test: $fudge_test";
    open my $fudge_run_fh, '>', $run_test or
        die "Could not open fudge run input file $run_test for write: $!";

    while (<$fudge_fh>) {
        s/#([?!])impl(-1)?.backend/#$1$impl/;
        s/#([?!])impl(-1)?/#$1$compiler/;
        print $fudge_run_fh $_;
    }

    return $run_test;
}

######################################################################
# Run fudgeandrun on file with specified $run_opts and
# verify that fudgeandrun output shows a successful run.
######################################################################
sub fudge_and_run_ok {
    my ($test_file, $test_desc, $run_opts, $success_opts) = @_;

    my @far_opts;
    push @far_opts, "--impl=$run_opts->{impl}" if $run_opts->{impl};
    push @far_opts, "--version=$run_opts->{version}" if $run_opts->{version};
    push @far_opts, "--backend=$run_opts->{backend}" if $run_opts->{backend};

    my $got = `$^X fudgeandrun -q @far_opts $test_file 2>&1`;
    die capture_error('fudgeandrun', $got) if $?;

    like($got, qr/^Result: PASS$/m, "$test_desc - passed by prove");
    if ($success_opts->{todo_passed}) {
        like(
            $got,
            qr/^\s*TODO passed:\s*\Q$success_opts->{todo_passed}\E$/m,
            "$test_desc - passing todo matched"
        );
    }
}
