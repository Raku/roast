use v6.c;
use Test;
plan 30;

my $number-of-dwarfs = 7;
is $number-of-dwarfs.WHAT.gist, '(Int)', 'Int WHAT';

is-deeply 0b1010, 10, 'binary';
is-deeply 0b10, 2, 'binary' ;

is-deeply 0xA, 10, 'hex';
is-deeply 0x10, 16, 'hex';

is-deeply 0o644, 420, 'octal';

is-deeply :3<120>, 15, 'radix';
is-deeply :28<aaaargh>, 4997394433, 'radix';
my $n = '42';
is-deeply :5($n), 22, 'radix';

is-deeply 0xCAFEBABE, 3405691582;
is 3405691582.base(16), 'CAFEBABE';

my $tenth = 1/10;
is $tenth.WHAT.gist, '(Rat)', 'Rat WHAT';

is (0, 1/10 ... 1).gist, '(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1)', 'rational series';
is ((1/3 + 1/6) * 2).gist, '1';
#?rakudo.jvm todo 'got (Int) instead of (Bool)'
is (1/10 + 1/10 + 1/10 == 0.3).gist, 'True', '(\o/)';

my $pi = 3.14e0;
my $earth-mass = 5.97e24;  # kg
is $earth-mass.WHAT.gist, '(Num)';

is-approx (0, 1e-1 ... 2)[11], 1.1, 'missed the 1';
is (0, 1e-1 ... * >= 1).gist, '(0 0.1 0.2 0.30000000000000004 0.4 0.5 0.6 0.7 0.7999999999999999 0.8999999999999999 0.9999999999999999 1.0999999999999999)', '(oops)';
is (1e0/10 + 1/10 + 1/10 == 0.3).gist, 'False', '(awww!)';

{
    my @numbers = <1 2.0 3e0>;
    isa-ok @numbers[0], Int;
    isa-ok @numbers[1], Rat;
    isa-ok @numbers[2], Num;
}

is (i * i).gist, '-1+0i', 'complex number';
is-approx e ** (i * pi) + 1, 0, 'complex equation';

my $googol = EVAL( "1" ~ "0" x 100 );
is $googol.gist, '1' ~ '0' x 100, 'googol';
is $googol.WHAT.gist, '(Int)';

is Inf.gist, 'Inf';
is Inf.WHAT.gist, '(Num)';
is (Inf > $googol).gist, 'True', 'Inf > $googol';
my $max = -Inf;
$max max= 5;          # (max= means "store only if greater")
is-deeply $max, 5, 'max';             # 5
