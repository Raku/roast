use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 24;

=begin description

Testing parameter traits for subroutines

=end description

# L<S06/"Parameter traits">

my $foo=1;

# test twice, once with assignment and once with increment, rakudo
# used to catch the first but not the latter.
#
throws-like '
    my $tmp = 1;
    sub mods_param ($x) { $x++; }
    mods_param($tmp)
    ',
    X::Multi::NoMatch,
    'can\'t modify parameter, constant by default';

throws-like '
    my $tmp = 1;
    sub mods_param ($x) { $x = 1; }
    mods_param($tmp)
    ',
    Exception,
    'can\'t modify parameter, constant by default';

# is readonly
throws-like 'sub mods_param_constant ($x is readonly) { $x++; };
             mods_param_constant($foo);',
             X::Multi::NoMatch,
            'can\'t modify constant parameter, constant by default';

sub mods_param_rw ($x is rw) { $x++; }
dies-ok  { mods_param_rw(1) }, 'can\'t modify constant even if we claim it\'s rw';
sub mods_param_rw_enforces ($x is rw) { $x; }
throws-like { mods_param_rw_enforces(1) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed a literal Int';
throws-like { mods_param_rw_enforces($[1,2]) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed an itemized array';

lives-ok  { mods_param_rw($foo) }, 'pass by "is rw" doesn\'t die';
is($foo, 2, 'pass by reference works');

# RT #129812
multi sub param_rw_ro ($x is rw) { "fee $x" }
multi sub param_rw_ro ($x) { "foo $x" }
$foo = "fie";
is param_rw_ro($foo), "fee fie", 'trait "is rw" used to narrow multi-dispatch';
#?rakudo.jvm skip 'RT #129812'
is param_rw_ro("fum"), "foo fum", 'trait "is rw" used to narrow multi-dispatch (converse)';

# is copy
$foo=1;
sub mods_param_copy ($x is copy) {$x++;}
lives-ok { mods_param_copy($foo) }, 'is copy';
is($foo, 1, 'pass by value works');

# same test with default value
sub boom ($arg is copy = 0) { $arg++ }

lives-ok { boom(42) }, "can modify a copy";


# is raw
{
    $foo=1;
    sub mods_param_raw ($x is raw) { $x++;  }
    dies-ok { mods_param_raw(1); }, 'is raw with non-lvalue';
    lives-ok { mods_param_raw($foo); }, 'is raw with non-lvalue';
    is($foo, 2, 'is raw works');
}


# with <-> we should still obey readonly traits
{
    my $anon1 = <-> $a is readonly, $b { $b++ };
    my $anon2 = <-> $a is readonly, $b { $a++ };
    my $x = 1;
    $anon1($x, $x);
    is($x, 2,                   '<-> does not override explicit traints (sanity)');
    #?rakudo 2 todo 'is readonly does not override'
    dies-ok({ $anon2($x, $x) }, '<-> does not override explicit traints');
    is($x, 2,                   '<-> does not override explicit traints (sanity)');
}


{
    try { EVAL 'my $gack; sub oh_noes( $gack is nonesuch ) { }' };

    ok  $!  ~~ Exception,  "Can't use an unknown trait";
    ok "$!" ~~ /trait/,    'error message mentions trait';
    ok "$!" ~~ /nonesuch/, 'error message mentions the name of the trait';
}

# RT #132710
is_run ｢
    sub foo1 is tighter(&[**]) is tighter(&[**])
             is looser(&[**])  is looser(&[**])
             is equiv(&[**])   is equiv(&[**]) {}
    sub foo2 is rw is rw {}
    sub foo3 is default is default {}
    sub foo5 is raw is raw {}
    -> $ is readonly is readonly {}
    print 'pass';
｣, {:err{
    .lc.contains: <duplicate tighter looser equiv rw default readonly raw>.all
}, :out<pass>}, 'duplicate traits warn';

# RT #132710
# XXX TODO 6.d REVIEW. Setting traits from multiple multies is undefined
# and this test may need to be moved to rakudo's test suite. See RT#132710
eval-lives-ok ｢
    multi infix:<↑> is assoc<right> is tighter(&infix:<**>) { $^n ** $^m }
    multi infix:<↑↑> ($, 0) is assoc<right> is tighter(&infix:<↑>) { 1 }
    multi infix:<↑↑> is assoc<right> is tighter(&infix:<↑>) { [↑] $^n xx $^m }
｣, 'no crash when defining multiple routines with tightnes';


# vim: ft=perl6
