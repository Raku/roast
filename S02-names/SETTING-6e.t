# SETTING::OUTER::OUTER is a revision-specific namespace.
use v6.e.PREVIEW;
use Test;

plan 6;

sub not($x) { $x } #OK
my $setting = 'SETTING::OUTER::OUTER::OUTER::OUTER';
ok &SETTING::OUTER::OUTER::OUTER::OUTER::not(False), 'SETTING::OUTER::OUTER::OUTER::OUTER:: works';
ok &::($setting)::not.(False), '::("' ~ $setting ~ '::") works';

ok EVAL('&SETTING::OUTER::OUTER::OUTER::OUTER::not(False)'), 'SETTING::OUTER::OUTER::OUTER::OUTER:: finds eval context';
ok EVAL('&::($setting)::not(False)'), '::("' ~ $setting ~ '::") finds eval context';
my $f = EVAL('-> $fn { $fn(); }');
ok $f({ &CALLER::SETTING::OUTER::OUTER::OUTER::OUTER::not(False) }), 'CALLER::SETTING::OUTER::OUTER::OUTER::OUTER:: works';
ok $f({ &CALLER::($setting)::not(False) }), 'CALLER::' ~ $setting ~ ':: works (ind)';

# vim: expandtab shiftwidth=4
