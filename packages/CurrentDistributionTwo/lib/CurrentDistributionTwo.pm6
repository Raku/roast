unit module CurrentDistributionTwo;

our sub distribution { $?DISTRIBUTION }

our sub resources { %?RESOURCES }

our sub dependency-distribution {
    use CurrentDistributionOne;
    CurrentDistributionOne::distribution;
}

our sub dependency-resources {
    use CurrentDistributionOne;
    CurrentDistributionOne::resources;
}
