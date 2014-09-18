#! http://perl6advent.wordpress.com/2011/12/03/buffers-and-binary-io/

use v6;
use Test;
plan 2;

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

my $buf = Buf.new(0x6d, 0xc3, 0xb8, 0xc3, 0xbe, 0x0a);
is capture-out({$*OUT.write($buf)}), ["møþ"], "buffer write";
my $str = $buf.decode('UTF-8');
is $str, "møþ\n", "buffer decode";

