# SETTING is a revision-specific namespace.
use v6.c;
use Test;

plan 6;

sub not($x) { $x } #OK
my $setting = 'SETTING';
ok &SETTING::not(False), 'SETTING:: works';
ok &::($setting)::not.(False), '::("SETTING") works';

#?rakudo 4 skip "NYI"
{
ok EVAL('&SETTING::not(False)'), 'SETTING finds eval context';
ok EVAL('&::($setting)::not(False)'), '::("SETTING") finds eval context';
my $f = EVAL('-> $fn { $fn(); }');
ok $f({ &CALLER::SETTING::not(False) }), 'CALLER::SETTING works';
ok $f({ &CALLER::($setting)::not(False) }), 'CALLER::SETTING works (ind)';
}

# vim: expandtab shiftwidth=4
