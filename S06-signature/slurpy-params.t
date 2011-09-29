use v6;
use Test;

# L<S06/List parameters/Slurpy parameters>

plan 58;

sub xelems(*@args) { @args.elems }
sub xjoin(*@args)  { @args.join('|') }

is xelems(1),          1,        'Basic slurpy params 1';
is xelems(1, 2, 5),    3,        'Basic slurpy params 2';

is xjoin(1),           '1',      'Basic slurpy params 3';
is xjoin(1, 2, 5),     '1|2|5',  'Basic slurpy params 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    'Positional and slurp params';
is mixed(1, 2, 3),     '|1|2!3', 'Positional and slurp params';
dies_ok { mixed()},              'at least one arg required';

#?rakudo skip 'types on slurpy params'
{
    sub x_typed_join(Int *@args){ @args.join('|') }
    is x_typed_join(1),           '1',      'Basic slurpy params with types 1';
    is x_typed_join(1, 2, 5),     '1|2|5',  'Basic slurpy params with types 2';
    dies_ok { x_typed_join(3, 'x') }, 'Types on slurpy params are checked';
}

sub first_arg      ( *@args         ) { ~@args[0]; }
sub first_arg_rw   ( *@args is rw   ) { ~@args[0]; }
sub first_arg_copy ( *@args is copy ) { ~@args[0]; }

is first_arg(1, 2, 3),      '1',  'can grab first item of a slurpy array';
is first_arg_rw(1, 2, 3),   '1',  'can grab first item of a slurpy array (is rw)';
is first_arg_copy(1, 2, 3), '1',  'can grab first item of a slurpy array (is copy)';

# test that shifting works
{
    sub func(*@m) {
        @m.shift;
        return @m;
    }
    #?pugs todo 'bug'
    is_deeply(func(5), [], "Shift from an array function argument works");
}


sub whatever {
    is(@_[3], 'd', 'implicit slurpy param flattens');
    is(@_[2], 'c', 'implicit slurpy param flattens');
    is(@_[1], 'b', 'implicit slurpy param flattens');
    is(@_[0], 'a', 'implicit slurpy param flattens');
}

whatever( 'a', 'b', 'c', 'd' );

# use to be t/spec/S06-signature/slurpy-params-2.t

# L<S06/List parameters/Slurpy parameters follow any required>

=begin pod

=head1 List parameter test

These tests are the testing for "List paameters" section of Synopsis 06

You might also be interested in the thread Calling positionals by name in
presence of a slurpy hash" on p6l started by Ingo
Blechschmidt L<http://www.nntp.perl.org/group/perl.perl6.language/22883>

=end pod

{
    my sub foo ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    #?pugs todo 'bug'
    lives_ok { foo 1, n => 20, y => 300 },
        'Testing: `sub foo($n, *%h) { }; foo 1, n => 20, y => 300`';
}

{
    my sub foo ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    dies_ok { foo 1, x => 20, y => 300, 4000 },
        'Testing: `sub foo($n, *%h) { }; foo 1, x => 20, y => 300, 4000`';
}


# Named with slurpy *%h and slurpy *@a
# named arguments aren't required in tests below
{
    my sub foo(:$n, *%h, *@a) { };   #OK not used
    my sub foo1(:$n, *%h, *@a) { $n };   #OK not used
    my sub foo2(:$n, *%h, *@a) { %h<x> + %h<y> + %h<n> };   #OK not used
    my sub foo3(:$n, *%h, *@a) { [+] @a };   #OK not used
    
    diag("Testing with named arguments (named param isn't required)");
    lives_ok { foo 1, x => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
    nok (foo1 1, x => 20, y => 300, 4000).defined,
      'Testing value for named argument';
    is (foo2 1, x => 20, y => 300, 4000), 320,
      'Testing value for slurpy *%h';
    is (foo3 1, x => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';
    
    ### named parameter pair will always have a higher "priority" while passing
    ### so %h<n> will always be undefined
    lives_ok { foo1 1, n => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`';
    is (foo1 1, n => 20, y => 300, 4000), 20,
      'Testing the named argument';
    is (foo2 1, n => 20, y => 300, 4000), 300,
      'Testing value for slurpy *%h';
    is (foo3 1, n => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';
}


# named with slurpy *%h and slurpy *@a
## Named arguments **ARE** required in tests below

#### ++ version
{
    my sub foo(:$n!, *%h, *@a) { };   #OK not used
    diag('Testing with named arguments (named param is required) (++ version)');
    lives_ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(+:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    #?pugs todo 'bug'
    dies_ok { foo 1, x => 20, y => 300, 4000 };
}

#### "trait" version
{
    my sub foo(:$n is required, *%h, *@a) { };   #OK not used
    diag('Testing with named arguments (named param is required) (trait version)');
    lives_ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    #?pugs todo 'bug'
    #?rakudo todo ''
    dies_ok { foo 1, x => 20, y => 300, 4000 },
    'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000 }`';
}

##### Now slurpy scalar tests here.
=begin desc

=head1 List parameter test

These tests are the testing for "List parameters" section of Synopsis 06


=end desc

# L<S06/List parameters/Slurpy scalar parameters capture what would otherwise be the first elements of the variadic array:>

{
    sub first(*$f, *$s, *@r) { return $f };   #OK not used
    sub second(*$f, *$s, *@r) { return $s };   #OK not used
    sub rest(*$f, *$s, *@r) { return [+] @r };   #OK not used
    diag 'Testing with slurpy scalar';
    is first(1, 2, 3, 4, 5), 1,
       'Testing the first slurpy scalar...';
    is second(1, 2, 3, 4, 5), 2,
       'Testing the second slurpy scalar...';
    is rest(1, 2, 3, 4, 5), 12,
       'Testing the rest slurpy *@r';
}

# RT #61772
{
    my @array_in = <a b c>;

    sub no_copy( *@a         ) { @a }
    sub is_copy( *@a is copy ) { @a }

    my @not_copied = no_copy( @array_in );
    my @copied     = is_copy( @array_in );

    is @copied, @not_copied, 'slurpy array copy same as not copied';
}

# RT #64814
#?rakudo skip 'types on slurpy params'
{
    sub slurp_any( Any *@a ) { @a[0] }
    is slurp_any( 'foo' ), 'foo', 'call to sub with (Any *@a) works';

    sub slurp_int( Int *@a ) { @a[0] }
    dies_ok { slurp_int( 'foo' ) }, 'dies: call (Int *@a) sub with string';
    is slurp_int( 27.Int ), 27, 'call to sub with (Int *@a) works';

    sub slurp_of_int( *@a of Int ) { @a[0] }
    dies_ok { slurp_of_int( 'foo' ) }, 'dies: call (*@a of Int) with string';
    is slurp_of_int( 99.Int ), 99, 'call to (*@a of Int) sub works';

    class X64814 {}
    class Y64814 {
        method x_slurp ( X64814 *@a ) { 2 }   #OK not used
        method of_x ( *@a of X64814 ) { 3 }   #OK not used
        method x_array ( X64814 @a ) { 4 }   #OK not used
    }

    my $x = X64814.new;
    my $y = Y64814.new;
    is $y.x_array( $x ), 4, 'call to method with typed array sig works';
    is $y.of_x( $x ),    3, 'call to method with "slurp of" sig works';
    is $y.x_slurp( $x ), 2, 'call to method with typed slurpy sig works';
    dies_ok { $y.x_array( 23 ) }, 'die calling method with typed array sig';
    dies_ok { $y.of_x( 17 ) }, 'dies calling method with "slurp of" sig';
    dies_ok { $y.x_slurp( 35 ) }, 'dies calling method with typed slurpy sig';
}

{
    my $count = 0;
    sub slurp_obj_thread(*@a) { $count++; }   #OK not used
    multi sub slurp_obj_multi(*@a) { $count++; }   #OK not used

    $count = 0;
    slurp_obj_thread(3|4|5);
    is $count, 1, 'Mu slurpy param doesnt autothread';
    $count = 0;
    slurp_obj_multi(3|4|5);
    is $count, 1, 'Mu slurpy param doesnt autothread';
}

##  Note:  I've listed these as though they succeed, but it's possible
##  that the parameter binding should fail outright.  --pmichaud
#?rakudo skip 'types on slurpy params'
{
    my $count = 0;
    sub slurp_any_thread(Any *@a) { $count++; }   #OK not used
    multi sub slurp_any_multi(Any *@a) { $count++; }   #OK not used

    slurp_any_thread(3|4|5);
    is $count, 1, 'Any slurpy param doesnt autothread';
    $count = 0;
    slurp_any_multi(3|4|5);
    is $count, 1, 'Any slurpy param doesnt autothread';
}

eval_dies_ok 'sub rt65324(*@x, $oops) { say $oops }',
             "Can't put required parameter after variadic parameters";

# used to be RT #69424
#?rakudo skip 'types on slurpy params'
{
    sub typed-slurpy(Int *@a) { 5 }   #OK not used
    my Int @b;
    is typed-slurpy(@b), 5, 'can fill typed slurpy with typed array';
}


# RT #74344
#?rakudo skip 'RT 74344'
{
    sub slurpy-by-name(*@var) { @var.join('|') }
    is slurpy-by-name(:var<a v g>), 'a|v|g', 'Can call slurpy param by name';
}

# RT #61772
{
    sub array_slurpy_copy(*@a is copy) {
        return @a;
    }
    my @array = <a b c>;
    my @c = array_slurpy_copy(@array);
    is @c[0], 'a', 'slurpy is copy-array works fine, thank you';
}

# RT #72600
{
    sub A (*@_) {
        is @_, [5, 4], 'slurpy @_ contains proper values';
        if 1 {
            is @_, [5, 4], 'slurpy @_ values not clobbered by if statement';
        }
    };
    A(5, 4);
}

# RT #74410
{
    is -> *@a { @a[+0] }.([5]), 5,
        'slurpy array can be indexed if index contains prefix:<+>';
}

done;

# vim: ft=perl6
