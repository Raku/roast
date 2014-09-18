# http://perl6advent.wordpress.com/2010/12/14/day-14-nextsame-and-its-cousins/
use v6;
use Test;
plan 5;

class A {
    method sing {
        say "life is but a dream.";
    }
}

class B is A {
    method sing {
        say ("merrily," xx 4).join(" ");
        nextsame;
    }
}

class C is B {
    method sing {
        say "row, row, row your boat,";
        say "gently down the stream.";
        nextsame;
    }
}

sub capture-said($code) {
    my $output;
    my $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
    }
    $code();
    return $output.lines;
}


my @out = capture-said { C.new.sing };

is_deeply @out, [
    'row, row, row your boat,',
    'gently down the stream.',
    'merrily, merrily, merrily, merrily,',
    'life is but a dream.'], 'nextsame inheritance';

sub bray {
    say "EE-I-EE-I-OO.";
}

# Oh right, forgot to add the first line of the song...
&bray.wrap( {
    say "Old MacDonald had a farm,";
    nextsame;
} );

@out = capture-said {
    bray();
};

is_deeply @out, [
    "Old MacDonald had a farm,",
    "EE-I-EE-I-OO."], 'nextsame wrapping';

multi foo(    $x) { say "Any argument" }
multi foo(Int $x) { say "Int argument" }

@out = capture-said({foo(42)});
is_deeply @out, ['Int argument'], 'multisub sanity';

class A1 {
    method foo { "OH HAI" }
}

role LogFoo {
    method foo {
        say ".foo was called";
        nextsame;
    }
}

my $logged_A = A1.new but LogFoo;

my $result;
@out = capture-said {$result = $logged_A.foo};
is $result, 'OH HAI';
is_deeply @out, ['.foo was called'], 'nextsame mixin';
