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
    return "%s\n", %fs{ $fn }();
}

is to_check, "\%s\n fa called.", 'fa called ok';
is to_check('B'), "\%s\n fb called.", 'fb called ok';

# vim: ft=perl6
