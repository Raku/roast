use v6;
use Test;
plan 2;
my &foo := EVAL('sub {432}',:lang<perl5>);
is foo(),432,"calling subs works";

my $foo = EVAL('sub {432}',:lang<perl5>);
is $foo(),432,"calling subs stored in variables works";
