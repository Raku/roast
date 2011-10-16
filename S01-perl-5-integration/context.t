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

# vim: ft=perl6
