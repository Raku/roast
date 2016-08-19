use v6;
use Test;
plan 10;
my &p5_void := EVAL(
    'sub {
        if (defined(wantarray)) {
            $::got_void = 0;
        } else {
            $::got_void = 1;
        }
}',:lang<Perl5>);

p5_void(:context<void>);
#?rakudo todo ''
is(EVAL(:lang<Perl5>,'$::got_void'),1,":context<void> sets void context");
p5_void(:context<scalar>);
is(EVAL(:lang<Perl5>,'$::got_void'),0,":context<scalar> doesn't set void context");
p5_void(:context<list>);
is(EVAL(:lang<Perl5>,'$::got_void'),0,":context<list> doesn't set void context");

my &p5_scalar := EVAL(
    'sub {
        if (not(wantarray) && defined wantarray) {
            $::got_scalar = 1;
        } else {
            $::got_scalar = 0;
        }
}',:lang<Perl5>);
p5_scalar(:context<scalar>);
#?rakudo todo ''
is(EVAL(:lang<Perl5>,'$::got_scalar'),1,":context<scalar> sets scalar context");
p5_scalar(:context<void>);
is(EVAL(:lang<Perl5>,'$::got_scalar'),0,":context<void> doesn't set scalar context");
p5_scalar(:context<list>);
is(EVAL(:lang<Perl5>,'$::got_scalar'),0,":context<list> doesn't set scalar context");

my &p5_list := EVAL(
    'sub {
        if (wantarray) {
            $::got_list = 1;
        } else {
            $::got_list = 0;
        }
}',:lang<Perl5>);
p5_list(:context<list>);
is(EVAL(:lang<Perl5>,'$::got_list'),1,":context<list> sets list context");
p5_list(:context<scalar>);
#?rakudo 3 todo ''
is(EVAL(:lang<Perl5>,'$::got_list'),0,":context<scalar> doesn't set list context");
p5_list(:context<void>);
is(EVAL(:lang<Perl5>,'$::got_list'),0,":context<void> doesn't set list context");

my &p5_list_of_values := EVAL('sub {return (1,2,3,4)}',:lang<Perl5>);
ok(p5_list_of_values(:context<void>) === Nil,"a p5 sub called in void context returns a Nil");


# vim: ft=perl6
