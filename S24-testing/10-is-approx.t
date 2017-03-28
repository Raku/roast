use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 13;

my $approx1 = is-approx 1, 1, 'is-approx with description';
ok $approx1, 'is-approx 1,1, returns True';
my $approx2 = is-approx 1, 1, 'is-approx with exact match';
my $approx3 = is-approx 1, 1.000001, 'is-approx with small difference';
ok $approx3, 'is-approx 1,1.000001, returns True';


sub test-fails($code, $desc) { 
    is_run "use Test; $code", %(:out{ $^s.contains('not ok') }), $desc

}


test-fails('is_approx 1,2', 'basic is_approx failing');

is-approx 100, 101, 10, 'is-approx with absolute tolerance';

test-fails 'is-approx 100, 120, 10', 'is-approx with absolute tolerance failure';

is-approx 100, 102, :rel-tol(0.05), 'is-approx with relative tolerance';

test-fails 'is-approx 100, 110, :rel-tol(0.05)', 'is-approx with relative tolerance failure';


is-approx 100, 105, :rel-tol(0.05), :abs-tol(10), 'is-approx with relative and absolute tolerance';

test-fails 'is-approx 100, 103, :rel-tol(0.1), :abs-tol(1)', 'is-approx failing because of absolute tolerance';

test-fails('is-approx 100, 102, :rel-tol(0.01), :abs-tol(10)', 'is-approx failing because of relative tolerance');

