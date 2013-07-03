use v6;

use Test;

plan 2;

sub nonce () { return ".{$*PID}." ~ (1..1000).pick() }
my $filename = 'tempfile_rebindstdhandles' ~ nonce();

# Test for re-binding $*OUT.
#?rakudo skip 'contextual rebinding regression'
{
    my $old_out := $*OUT;
    $*OUT := open($filename, :w);
    print "OH ";
    say "HAI!";
    $*OUT.close();
    $*OUT := $old_out;

    is(slurp($filename), "OH HAI!\n", 'rebound $*OUT to file handle OK');
    
    unlink($filename);
}

# Test for re-binding $*ERR.
# #?rakudo skip 'warn does not yet use $*ERR'
{
    my $old_err := $*ERR;
    $*ERR := open($filename, :w);
    warn("OH NOES OUT OF CHEEZBURGER\n");
    $*ERR.close();
    $*ERR := $old_err;

    is(slurp($filename), "OH NOES OUT OF CHEEZBURGER\n", 'rebound $*ERR to file handle OK');

    unlink($filename);
}

# vim: ft=perl6
