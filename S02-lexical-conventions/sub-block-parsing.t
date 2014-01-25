use v6;

use Test;

# TODO: smartlink

# L<"http://use.perl.org/~autrijus/journal/25365">
# Closure composers like anonymous sub, class and module always trumps hash
# dereferences:
#
#   sub{...}
#   module{...}
#   class{...}

plan 9;

ok(sub { 42 }(), 'sub {...}() works'); # TODO: clarify

ok(sub{ 42 }(),  'sub{...}() works'); # TODO: clarify

#RT #76432
eval_dies_ok q[
    sub x { die }
    x();
], 'block parsing works with newline';

eval_dies_ok q[
    sub x { die };
    x();
], 'block parsing works with semicolon';

# RT #85844
{
    eval_dies_ok 'sub foo;', 'RT #85844'
}

# RT #76896: 
# perl6 - sub/hash syntax
#?pugs skip 'Unexpected ";"'
{
    sub to_check_before {
        my %fs = ();
        %fs{ lc( 'A' ) } = &fa;
        sub fa() { return 'fa called.'; }
        ;
        %fs{ lc( 'B' ) } = &fb;
        sub fb() { return 'fb called.'; }

        my $fn = lc( @_[ 0 ] || 'A' );
        return %fs{ $fn }();
    }

    sub to_check_after {
        my %fs = ();
        %fs{ lc( 'A' ) } = &fa;
        sub fa() { return 'fa called.'; }

        %fs{ lc( 'B' ) } = &fb;
        sub fb() { return 'fb called.'; }

        my $fn = lc( @_[ 0 ] || 'A' );
        return %fs{ $fn }();
    }

    is to_check_before, "fa called.", 'fa called in old sub/hash syntax is ok';
    is to_check_before('B'), "fb called.", 'fb called in old sub/hash syntax is ok';
    is to_check_after, "fa called.", 'fa called in sub/hash syntax is ok';
    is to_check_after('B'), "fb called.", 'fb called in sub/hash syntax is ok';
}

done;

# vim: ft=perl6
