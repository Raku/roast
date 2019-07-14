# SETTING::OUTER::OUTER is a revision-specific namespace.
use v6.d;
use Test;

plan 6;

sub not($x) { $x } #OK
my $setting = 'SETTING::OUTER::OUTER';
ok &SETTING::OUTER::OUTER::not(False), 'SETTING::OUTER::OUTER:: works';
ok &::($setting)::not.(False), '::("SETTING::OUTER::OUTER") works';

ok EVAL('&SETTING::OUTER::OUTER::not(False)'), 'SETTING::OUTER::OUTER finds eval context';
ok EVAL('&::($setting)::not(False)'), '::("SETTING::OUTER::OUTER") finds eval context';
my $f = EVAL('-> $fn { $fn(); }');
ok $f({ &CALLER::SETTING::OUTER::OUTER::not(False) }), 'CALLER::SETTING::OUTER::OUTER works';
ok $f({ &CALLER::($setting)::not(False) }), 'CALLER::SETTING::OUTER::OUTER works (ind)';
