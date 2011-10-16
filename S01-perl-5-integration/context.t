use v6;
use Test;
my &p5_void := eval(
    'sub {
        if (defined(wantarray)) {
            $::got_void = 0;
        } else {
            $::got_void = 1;
        }
}',:lang<perl5>);
p5_void(:context<void>);
is(eval(:lang<perl5>,'$::got_void'),1,":contex<void> sets void context");
p5_void(:context<scalar>);
is(eval(:lang<perl5>,'$::got_void'),0,":contex<scalar> dosn't set void context");
p5_void(:context<list>);
is(eval(:lang<perl5>,'$::got_void'),0,":contex<list> dosn't sets void context");
done;

my &p5_scalar := eval(
    'sub {
        if (not(wantarray) && defined wantarray) {
            $::got_scalar = 1;
        } else {
            $::got_scalar = 0;
        }
}',:lang<perl5>);
p5_scalar(:context<scalar>);
is(eval(:lang<perl5>,'$::got_scalar'),1,":contex<scalar> sets scalar context");
p5_scalar(:context<void>);
is(eval(:lang<perl5>,'$::got_scalar'),0,":contex<void> dosn't set scalar context");
p5_scalar(:context<list>);
is(eval(:lang<perl5>,'$::got_scalar'),0,":contex<list> dosn't sets scalar context");
done;

my &p5_list := eval(
    'sub {
        if (wantarray) {
            $::got_list = 1;
        } else {
            $::got_list = 0;
        }
}',:lang<perl5>);
p5_list(:context<list>);
is(eval(:lang<perl5>,'$::got_list'),1,":contex<list> sets list context");
p5_list(:context<scalar>);
is(eval(:lang<perl5>,'$::got_list'),0,":contex<scalar> dosn't set list context");
p5_list(:context<void>);
is(eval(:lang<perl5>,'$::got_list'),0,":contex<void> dosn't sets list context");
done;

# vim: ft=perl6
