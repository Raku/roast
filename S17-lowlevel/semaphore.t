use v6;
use Test;

plan 2;

# The following two tests cover RT #128628, where code like this could hang
# as well as give wrong results.

{
    my Semaphore $s .= new(1);
    my @p;
    my $r;
    for ^4000 {
        my $i = $_;
        @p.push: Promise.start({
            $s.acquire;
            $r += $i;
            $s.release;
        });
    }
    await @p;
    is $r, 7998000, 'Sempahore protected addition and we got the correct result';
}

{
    my Semaphore $s .= new(1);
    my @p;
    my @r;
    for ^4000 {
        my $i = $_;
        @p.push: Promise.start({
            $s.acquire;
            @r[$i]++;
            $s.release;
        });
    }
    await @p;
    ok all(@r) == 1, 'Semaphore protected array operations';
}
