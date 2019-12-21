use v6;

use Test;

plan(2);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

EVAL q<<<

use Digest::MD5:from<Perl5> <md5_hex>;

sub get_dmd5 {
    my $ctx = Digest::MD5.new;
    return($ctx);
}

{
    is( md5_hex('test'), '098f6bcd4621d373cade4e832627b4f6', 'Perl function exported' );
}

{
    my $ctx = get_dmd5();
    $ctx.add('test');
    is( $ctx.hexdigest, '098f6bcd4621d373cade4e832627b4f6', 'XS return' );
}

>>>;

# vim: ft=perl6
