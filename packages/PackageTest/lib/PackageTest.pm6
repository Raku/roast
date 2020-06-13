use v6;

package PackageTest {

    our sub ns  { "PackageTest" }

    our sub pkg { $?PACKAGE }

    sub test_export is export { "party island" }

    our package Our::Package {

        our sub pkg { $?PACKAGE }

    }


    our sub get_our_pkg {
        Our::Package::pkg();
    }

    sub cant_see_pkg {
        return My::Package::pkg();
    }

    {
        my package My::Package {
            our sub pkg { $?PACKAGE }
        }

        our sub my_pkg {
            return My::Package::pkg();
        }
    }

    sub dummy_sub_with_params($arg1, $arg2) is export { "[$arg1] [$arg2]" }
}

# vim: expandtab shiftwidth=4
