use v6-alpha;
use Test;
plan 40;

# L<S29/Num/"=item abs">

=pod

Basic tests for the abs() builtin

=cut

for(0, 0.0, 1, 50, 60.0, 99.99) {
    is(abs($_), $_, "got the right absolute value for $_");
    is(WHAT abs($_), WHAT $_, "got the right data type("~WHAT($_)~") of absolute value for $_");
}
for(-1, -50, -60.0, -99.99) {
    is(abs($_), -$_, "got the right absolute value for $_");
    is(WHAT abs($_), WHAT $_, "got the right data type("~WHAT($_)~") of absolute value for $_");
}

for (0, 0.0, 1, 50, 60.0, 99.99) {
    is(.abs, $_, 'got the right absolute value for $_='~$_);
    is(WHAT .abs, WHAT $_, 'got the right data type('~WHAT($_)~') of absolute value for $_='~$_);
}
for (-1, -50, -60.0, -99.99) {
    is(.abs, -$_, 'got the right absolute value for $_='~$_);
    is(WHAT .abs, WHAT $_, 'got the right data type('~WHAT($_)~') of absolute value for $_='~$_);
}
