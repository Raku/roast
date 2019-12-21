use v6;
use Test;
plan 15;

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

{
    my $r = EVAL("0", :lang<Perl5>);
    is($r, 0, "number");
}

{
    my $r = EVAL("2", :lang<Perl5>);
    is($r, 2, "number");
}

{
    my $r = EVAL('"perl6 now"', :lang<Perl5>);
    is($r, 'perl6 now', "string");
}

my $p5_dumper = EVAL('sub {return(wantarray ? @_ : $_[0]); }', :lang<Perl5>);

my %h = ( a => 1 );

{
    my $test = '%h.kv received as hash';
    my ($k,$v) = $p5_dumper(%h.kv);
    is($k, 'a', $test~' (key)');
    is($v, '1', $test~' (value)');
}

{
    my $test = q{ (VAR %h)received as hashref };
    my %o := $p5_dumper($%h);
    is(%o<a>, 1, $test);
}

my @a = <b c d>;
{
    my $test = q{ (@a) received as array };
    my @o = $p5_dumper(@a);
    is(@o[0], "b", $test);
    is(@o[2], "d", $test);
}

{
    my $test = q{ (VAR @a) received as arrayref };
    my $o = $p5_dumper($@a);
    is($o[0], "b", $test);
    is($o[2], "d", $test);
}

my $s = 'str';

{
   my $test = q{ ($s) received as scalar };
   my $o = $p5_dumper($s);
   is($o, $s, $test);
}

{
   my $test = q{ (VAR $s) received as scalarref };
   my $o = $p5_dumper(VAR $s);
   is($$o, $s, $test);
}

{
    my $test = q{ (&p6func) Passing a Raku coderef to Perl };

    sub  plus_one (Int $int) { $int+1 }
    my $sub = EVAL('sub { my $p6_coderef = shift; $p6_coderef->(3) }', :lang<Perl5>);
    my $result = $sub(&plus_one);
    is($result,4,$test);
}

#?rakudo skip "would need v5"
{
    sub add_in_perl ($x, $y) {
        use v5;
        $x + $y;
    }

    eval-lives-ok("{use v5;}", "RT #77596 - use v5 in a block lives");

    is(add_in_perl(42, 42), 84, 'Defining subroutines with "use v5" blocks');
}

# vim: ft=perl6
