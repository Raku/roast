use v6;
use Test;

plan 2;

my $old = $*CWD;

indir $*TMPDIR, {
    is $*CWD, $*TMPDIR, 'basic &indir';
}
is $*CWD, $old, 'back to normal after &indir';
