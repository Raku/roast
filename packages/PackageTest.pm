# The semicolon form of "package" would be illegal in the
# middle of a Perl 6 file.
# At the top, it would mean the rest of the file was Perl 5 code.
# So we use "package" with a block:

package t::spec::packages::PackageTest {

sub ns  { "t::spec::packages::PackageTest" }

sub pkg { $?PACKAGE }

sub test_export is export { "party island" }

sub get_our_pkg {
    Our::Package::pkg();
}

our package Our::Package {

    sub pkg { $?PACKAGE }

}

sub cant_see_pkg {
    return My::Package::pkg();
}

{
    sub my_pkg {
        return My::Package::pkg();
    }

    my package My::Package {
        sub pkg { $?PACKAGE }
    }

}

sub dummy_sub_with_params($arg1, $arg2) is export { "[$arg1] [$arg2]" }

}
