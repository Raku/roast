use v6;
use Test;
plan 20;

unless (try { EVAL("1", :lang<perl5>) }) {
    skip_rest;
    exit;
}

#?rakudo skip ':lang<perl5>'
{
    my $r = EVAL("0", :lang<perl5>);
    is($r, 0, "number");
}

#?rakudo skip ':lang<perl5>'
{
    my $r = EVAL("2", :lang<perl5>);
    is($r, 2, "number");
}

#?rakudo skip ':lang<perl5>'
{
    my $r = EVAL('"perl6 now"', :lang<perl5>);
    is($r, 'perl6 now', "string");
}

#?rakudo emit #
my $p5_dumper = EVAL('sub {return(wantarray ? @_ : $_[0]); }', :lang<perl5>);

my %h = ( a => 1 );

#?rakudo skip ':lang<perl5>'
{
    my $test = '%h.kv received as hash';
    my ($k,$v) = $p5_dumper(%h.kv);   
    is($k, 'a', $test~' (key)');
    is($v, '1', $test~' (value)');
}

#?rakudo skip ':lang<perl5>'
{
    my $test = '\%h received as hashref';
    my %o := $p5_dumper(\%h);
    is(%o<a>, 1, $test);

    my $ref = $p5_dumper(\%h);
    is($ref<a>, 1, $test);
}

#?rakudo skip 'VAR'
{
    my $test = q{ (VAR %h)received as hashref };
    my %o := $p5_dumper(VAR %h);
    is(%o<a>, 1, $test);
}

my @a = <b c d>;
#?rakudo skip ':lang<perl5>'
{
    my $test = q{ (@a) received as array };
    my @o = $p5_dumper(@a);
    is(@o[0], "b", $test);
    is(@o[2], "d", $test);
}

#?rakudo skip ':lang<perl5>'
{
    my $test = q{ (\@a) received as arrayref };
    my $o = $p5_dumper(\@a);
    is($o[0], "b", $test);
    is($o[2], "d", $test);
}

#?rakudo skip 'VAR'
{
    my $test = q{ (VAR @a) received as arrayref };
    my $o = $p5_dumper(VAR @a);
    is($o[0], "b", $test);
    is($o[2], "d", $test);
}

my $s = 'str';

#?rakudo skip ':lang<perl5>'
{
   my $test = q{ ($s) received as scalar };
   my $o = $p5_dumper($s);
   is($o, $s, $test);
}

#?rakudo skip ':lang<perl5>'
{
   my $test = q{ (\$s) received as scalarref };
   my $o = $p5_dumper(\$s);
   is($$o, $s, $test);
}

#?rakudo skip 'VAR'
{
   my $test = q{ (VAR $s) received as scalarref };
   my $o = $p5_dumper(VAR $s);
   is($$o, $s, $test);
}

#?rakudo skip ':lang<perl5>'
{
    my $test = q{ (&p6func) Passing a Perl 6 coderef to Perl 5 };

    sub  plus_one (Int $int) { $int+1 }
    my $sub = EVAL('sub { my $p6_coderef = shift; $p6_coderef->(3) }', :lang<perl5>);
    my $result = $sub(&plus_one);
    is($result,4,$test);
}

#?rakudo 2 skip 'v5 is not in core (yet)'
{
    sub add_in_perl5 ($x, $y) {
        use v5;
        $x + $y;
    }

    eval_lives_ok("{use v5;}", "RT #77596 - use v5 in a block lives");

    is(add_in_perl5(42, 42), 84, 'Defining subroutines with "use v5" blocks');
}

# vim: ft=perl6
