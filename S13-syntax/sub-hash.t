use v6;

use Test;

plan 2;

# RT #76896: 
# perl6 - sub/hash syntax

sub to_check {
    my %fs = ();
    %fs{ lc( 'A' ) } = &fa;
    sub fa() { return 'fa called.'; }

    %fs{ lc( 'B' ) } = &fb;
    sub fb() { return 'fb called.'; }

    my $fn = lc( @_[ 0 ] || 'A' );
    return %fs{ $fn }();
}

is to_check, "fa called.", 'fa called ok';
is to_check('B'), "fb called.", 'fb called ok';

# vim: ft=perl6
