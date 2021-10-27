unit module CurrentDistributionTwo;

our sub distribution { $?DISTRIBUTION }

our sub resources { %?RESOURCES }

our sub dependency-distribution {
    use CurrentDistributionOne:auth<foo@bar.baz>;
    CurrentDistributionOne::distribution;
}

our sub dependency-resources {
    use CurrentDistributionOne;
    CurrentDistributionOne::resources;
}

# vim: expandtab shiftwidth=4
