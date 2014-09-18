# http://perl6advent.wordpress.com/2009/12/07/day-7-looping-for-fun-and-profit/

use v6;
use Test;

plan 14;

my $a = '';
for 1, 2, 3, 4 { $a ~= $_ }
is $a, '1234', '$_ is default topic';

$a = 0;
for 1, 2, 3, 4 -> $i { $a += $i }
is $a, 10, 'explicit topic';

$a = '';
for 1, 2, 3, 4 -> $i, $j { $a ~= "$j $i " }
is $a, '2 1 4 3 ', '2 topics';

my @array = <a b c d>;

$a = '';
for @array { $a ~= $_ }
is $a, 'abcd', '$_ is default topic, variable list';

sub capture-out($code) {
    my $output;
    my $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
	multi method write(Buf $b){$output ~= $b.decode}
    }
    $code();
    return $output.lines;
}
is capture-out( {@array.map: *.say} ), [< a b c d>], "map"; 
is capture-out( {@array».say } ).sort, [<a b c d>], "hyperoperator form (say)"; 
is @array».Str , <a b c d> , 'testing hyperoperator form';


$a = '';
for 1..4 { $a ~= $_ };
is $a, '1234', 'simple range';

$a = '';
for ^4 { $a ~= $_ };
is $a, '0123', 'upto';

my @array1 = <11 12 13>;
my @array2 = <21 22 23>;

$a = '';
for @array1 Z @array2 -> $one, $two { $a ~= "$one $two " };
is $a, '11 21 12 22 13 23 ', 'zip with multiple topics';

$a = '';
for ^Inf Z @array -> $index, $item { $a ~= "$index $item " };
is $a, '0 a 1 b 2 c 3 d ', 'infinite upto, zip with multiple topics';

$a = '';
for ^@array.elems Z @array -> $index, $item { $a ~= "$index $item " };
is $a, '0 a 1 b 2 c 3 d ', 'elems upto, zip with multiple topics';

$a = '';
for @array.kv -> $index, $item { $a ~= "$index $item " };
is $a, '0 a 1 b 2 c 3 d ', '.kv, multiple topics';

{
    my @one   = <11 12 13>;
    my @two   = <21 22 23>;
    my @three = <31 32 33>;
    my @four  = <41 42 43>;

    $a = '';
    for @one Z @two Z @three Z @four -> $one, $two, $three, $four {
        $a ~= "$one $two $three $four "
    };
    is $a, '11 21 31 41 12 22 32 42 13 23 33 43 ', 'multiple iteration';
}

done;
