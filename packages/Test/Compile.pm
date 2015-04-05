module Test::Compile;
use Test;

=begin pod

=head1 NAME

Test::Compile - Perl6 test suite utilities for testing precompiled/loaded code

=head1 SYNOPSIS

  use Test;
  use Test::Compile;

=head1 DESCRIPTION

Note that Test::Compile is very new and the offered functions may change
as further testing requires.  For now it is advised not to mix
C<Test::Compile> tests in with the general population of tests, and to
keep such tests isolated in few files so changes can be easily promulgated.
This also ensures that problems with Test::Compile do not interfere with
completing other tests.

=head1 FUNCTIONS

=head2 loads_ok($code, $reason)

Writes the string in C<$code> to an external file, then loads it as
though it had been loaded with a C<use> statement.  The test passes if
no exceptions occur during this process.  The test result will output
C<$reason> as part of the result message.  The file is not precompiled.

If the compiler cannot load modules, the test will be automatically
skipped.

=end pod

my sub loads_ok($code, $reason) is export {
    do_compunit($code, $reason, False, False) ~~ Array;
}

=begin pod

=head2 precomp_loads_ok($code, $reason)

Works the same as C<loads_ok> but precompiles the code before loading it.

If the compiler can load modules but does not support precompiled modules,
this test will be equivalent to C<loads_ok>.

=end pod

my sub precomp_loads_ok($code, $reason) is export {
    do_compunit($code, $reason) ~~ Array
}

=begin pod

=head2 loads_is($code, $expect, $reason)

Works the same as C<loads_ok> but wraps C<$code> in a block and takes
the return value of the block.  Then performs an C<is> between the
retrieved value and C<$expect>.

=end pod

my sub loads_is($code, $expect, $reason) is export {
    loads_is_internal($code, $expect, $reason, False, False);
}
my sub loads_is_internal($code, $expect, $reason, $leavefiles, $compile) {
    my $newcode = '$*compunit_result = do { ' ~ $code ~ ' } ';
    subtest {
        plan 2;
        my $res = do_compunit($newcode, $reason ~ " (Compiled)",
                              $leavefiles, $compile);
        if ($res ~~ Array) {
            if ($res.elems) {
                is $res[0], $expect, $reason ~ " (Compared)";
            }
            else {
                is Nil, $expect, $reason ~ " (Compared)";
            }
        }
        else {
            pass "# SKIP No value to compare";
        }
    }
}

=begin pod

=head2 precomp_loads_is($code, $expect, $reason)

Works the same as C<loads_is> but precompiles the code before loading it.

If the compiler can load modules but does not support precompiled modules,
this test will be equivalent to C<loads_is>.

=end pod

my sub precomp_loads_is($code, $expect, $reason) is export {
    loads_is_internal($code, $expect, $reason, False, True);
}

# "private" parts
#
# Guts for precomp tests
# 
# Although Test:: is currently shipped with the compiler, it may
# eventually end up in its own distro.
#
# So we make some effort to do things in a way that a compiler that
# does not support precompilation can still manage to load Test::.
# Also we avoid using very many language features so there is some
# longhand here and there.
#
# NOTE: temporary file handling is probably not secure.  We either
# need that or the ability to make in-memory compunits.
#
my $precomp_dir = False;
my $precomp_dir_sep;
my $compunit_tried = False;
my $compunit_available = False;
my @compunits_to_delete = ();

sub delete_compunits($leavefiles = False) {
    return if $leavefiles;
    try unlink $_ for @compunits_to_delete;
    @compunits_to_delete = ();
}

sub tmpident { "p6testmod" ~ (2**32).rand.Int.fmt("%8.8X") }

sub init_compunit {

    $compunit_tried = True;
    my $sep = "/";

    my $have_KERNEL = False; # We may not have $*KERNEL
    my $have_TMPDIR = False; # We may not have $*TMPDIR
    try EVAL '$have_KERNEL = $*KERNEL.name; $have_TMPDIR = ~$*TMPDIR;';

    $sep = "\\" if $have_KERNEL eq 'win32';

    my $fn = tmpident;
    my $dn = tmpident;
    $precomp_dir = [~] $have_TMPDIR, $sep, $dn;
    $precomp_dir_sep = $precomp_dir ~ $sep;
    my $fp = [~] $precomp_dir, $sep, $fn;
    my $cu;

    unless $have_KERNEL {
	diag "Cannot do any precomp tests; no \$*KERNEL to figure FS separator";
	return;
    }
    unless $have_TMPDIR {
	diag "Cannot do any precomp tests; no \$*TMPDIR so no place to put stuff";
	return;
    }
    # This dir is cleaned up in END, or sooner if we fail.
    unless mkdir($precomp_dir) {
	diag "Cannot do any precomp tests; Could not make a temporary directory";
	return;
    }
    unless "$fp.pm6".IO.spurt("1;") {
	diag "Cannot do any precomp tests; Could not create a file";
	return;
    }

    @compunits_to_delete.push("$fp.pm6");
    try { $cu = EVAL '
            CompUnit.new("$fp.pm6");
        ';
	CATCH {
# For some reason rmdir does not work here.  Rely on END until that gets sussed.
#	    my $pd = $precomp_dir;
#	    $precomp_dir = False;
#    	    try rmdir($pd);
            diag "Cannot do any precomp tests because: " ~ $_;
	    return;
	}
    }
    unless $cu.defined {
# For some reason rmdir does not work here.  Rely on END until that gets sussed.
#	my $pd = $precomp_dir;
#	$precomp_dir = False;
#    	try rmdir($pd);
	diag "Cannot do any precomp tests, CompUnit did not instantiate.";
	return;
    }
    try {
	EVAL '
            $cu.precomp;
        ';
	CATCH {
            diag "Cannot do real precomp tests, precomp failed because: " ~ $_;
            # But we still may be able to load without precomp
	    diag "Will try to run such tests anyway direct from source.";
	    $compunit_available = "Source";
	    # Very weird but we need an additional CATCH here or it throws.
            CATCH { }
	}
    }
    @compunits_to_delete.push($cu.precomp-path) if $cu.precomp-path;
    try {
        EVAL '
            # CompUnit.load is broken right now.
            # $cu.load($fp, { from => "Perl6" });
            # So we hit some rakudo internals to do the same thing
            my Mu $p6ml := nqp::gethllsym("perl6", "ModuleLoader");

            if ($compunit_available eq "Source") {
                $cu = $p6ml.load_module("$fn", { },
                    :chosen{
                        :pm("$fp.pm6")
                    }
                );
            }
            else {
                $cu = $p6ml.load_module("$fn", {  },
                    :chosen{
                        :pm("$fp.pm6")
                        :load($cu.precomp-path)
                        :key($cu.precomp-path)
                    }
                );
            }
        ';
	CATCH {
            delete_compunits;
	    my $pd = $precomp_dir;
	    $precomp_dir = False;
    	    try rmdir($pd);
	    $compunit_available = False;
            diag "Still cannot do any precomp tests, load failed because: " ~ $_;
	    return;
	}
    }
    # XXX Actually I am not sure how to test for a "{ }" created in .nqp
    # versus any legit return value, but this seems to let the successes through. 
    if nqp::ishash($cu) {
        delete_compunits;
	my $pd = $precomp_dir;
	$precomp_dir = False;
    	try rmdir($pd);
	$compunit_available = False;
	diag "Still cannot do any precomp tests, load failed.";
	return;
    }    
    delete_compunits;
    $compunit_available ||= "Precomp";
}

# This will actually be internal but exported for preliminary testing
sub do_compunit($code_as_str, $reason, $leavefiles = False, $compile = True) {
    # once init_compunit(); But we do not want to rely on working "once"
    init_compunit() unless $compunit_tried;

    my $fn = tmpident;
    my $fp = $precomp_dir_sep ~ $fn;
    my $cu;

    $_ = $compunit_available;
    $_ = "Source" if not $compile and $_ eq "Precomp";

    my $*compunit_result = Nil;

    when "Precomp" {
        unless "$fp.pm6".IO.spurt($code_as_str) {
            flunk($reason);
	    diag("All of a sudden cannot create source for precomp.");
	    try unlink "$fp.pm6";  # In case of partial creation
            return;
        }
        @compunits_to_delete.push("$fp.pm6");
        my $cr;
        try EVAL '
            $cu = CompUnit.new("$fp.pm6");
            $cr = $cu.precomp;
        ';
        if defined $! {
            flunk($reason);
	    diag($!);
	    delete_compunits($leavefiles);
            return;
        }
	unless $cr {
	    # Would be nice to divert the compiler errors here somehow.
            flunk($reason);
	    diag("Failed to create CompUnit, normal compilation failure.");
	    delete_compunits($leavefiles);
            return;
	    }
        if not defined $cu {
            flunk($reason);
	    diag("Failed to create CompUnit, no but Failure thrown.");
	    delete_compunits($leavefiles);
            return;
	    }
        @compunits_to_delete.push($cu.precomp-path);
        try EVAL '
            # CompUnit.load is broken right now.
            # $cu.load($fp, { from => "Perl6" });

            # So we hit some rakudo internals to do the same thing
            my Mu $p6ml := nqp::gethllsym("perl6", "ModuleLoader");

            $cu = $p6ml.load_module("$fn", { },
                :chosen{
                    :pm("$fp.pm6")
                    :load($cu.precomp-path)
                    :key($cu.precomp-path)
                }
            );
        ';
        if defined $! {
            flunk($reason);
	    diag($!);
	    delete_compunits($leavefiles);
            return;
        }
        pass($reason);
        delete_compunits($leavefiles);
        return [ $*compunit_result ];
    }
    when "Source" {
        unless "$fp.pm6".IO.spurt($code_as_str) {
            flunk($reason);
	    diag("All of a sudden cannot create file for source compunits.");
	    try unlink "$fp.pm6";  # In case of partial creation
            return;
        }
        @compunits_to_delete.push("$fp.pm6");
        try EVAL '
            $cu = CompUnit.new("$fp.pm6");

            # CompUnit.load is broken right now.
            # $cu.load($fp, { from => "Perl6" });

            # So we hit some rakudo internals to do the same thing
            my Mu $p6ml := nqp::gethllsym("perl6", "ModuleLoader");
            $cu = $p6ml.load_module("$fn", { },
                :chosen{
                    :pm("$fp.pm6")
                }
            );
        ';
        if defined $! {
            flunk(0, $reason);
            diag($!);
            delete_compunits($leavefiles);
            return;
        }
        pass($reason);
	delete_compunits($leavefiles);
        return [ $*compunit_result ];
    }
    default {
        pass("# SKIP Because we cannot do compunits");
    }
    return
}

END {
    # Clean up any fugitive compunits and the directory used for precomp tests.
    delete_compunits;
    if ($precomp_dir) {
    	try rmdir($precomp_dir)
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
