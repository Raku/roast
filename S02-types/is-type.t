use v6;
use Test;

plan 12;

{
    my @a is Buf;
    ok @a ~~ Buf, 'is TypeName on @ sigil has effect (my)';
    
    my %h is BagHash;
    ok %h ~~ BagHash, 'is TypeName on % sigil has effect (my)';
}

{
    state @a is Buf;
    ok @a ~~ Buf, 'is TypeName on @ sigil has effect (state)';
    
    state %h is BagHash;
    ok %h ~~ BagHash, 'is TypeName on % sigil has effect (state)';
}

class C {
    has @.a is Buf;
    has %.h is BagHash;
}
ok C.new.a ~~ Buf, 'is TypeName on @ sigil has effect (has)';
ok C.new.h ~~ BagHash, 'is TypeName on % sigil has effect (has)';

for ^2 {
    my %h is BagHash;
    is %h.elems, 0, "Get fresh BagHash in my variable per iteration ($_)";
    %h<a>++; # Create state that should not leak to next iteration
}

sub test-state() {
    my $got;
    for ^2 {
        state %h is BagHash;
        %h<a>++;
        $got = %h<a>;
    }
    $got
}
#?rakudo todo 'state variables with `is BagHash`'
is test-state(), 2, 'state variable with `is BagHash` retains state...';
is test-state(), 2, '...and it is per closure clone';

for ^2 {
    my %h := C.new.h;
    is %h.elems, 0, "Get fresh BagHash in new object per iteration ($_)";
    %h<a>++; # Create state that should not leak to next iteration
}
