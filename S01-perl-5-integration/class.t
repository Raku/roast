use v6;

use Test;

plan(2);

unless (try { eval("1", :lang<perl5>) }) {
    skip_rest;
    exit;
}

{
    lives_ok {
        eval q|
            use perl5:CGI;
            my $q = CGI.new;
            is $q.isa(CGI), 1, "Correct isa";
        |
        or die $!;
    }, "perl5:CLASS.new";
}
