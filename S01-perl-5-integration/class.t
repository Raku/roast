use v6.c;

use Test;

plan(3);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

{
    lives-ok {
        EVAL q|
            use Digest::MD5:from<Perl5>;
            my $d = Digest::MD5.new;
#?rakudo skip " RT #124648"
{
            is $d.isa(Digest::MD5), 1, "Correct isa";
}
            $d.add('foo'.encode('UTF-8'));
            is $d.hexdigest, 'acbd18db4cc2f85cedef654fccc4a4d8';
        |
        or die $!;
    }, "CLASS:from<Perl5>.new";
}

# vim: ft=perl6
