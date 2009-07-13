use v6;
use Test;

# L<S06/List parameters/Slurpy parameters>

plan 45;

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

whatever( 'a' p5=> 'b', 'c' p5=> 'd' );

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
    # Positional with slurpy *%h and slurpy *@a
    my sub foo($n, *%h, *@a) { };
    my sub foo1($n, *%h, *@a) { $n }
    my sub foo2($n, *%h, *@a) { %h<x> + %h<y> + %h<n> }
    my sub foo3($n, *%h, *@a) { [+] @a }

## all pairs will be slurped into hash, except the key which has the same name
## as positional parameter
    diag('Testing with positional arguments');
    lives_ok { foo 1, x => 20, y => 300, 4000 },
    'Testing: `sub foo($n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
    is (foo1 1, x => 20, y => 300, 4000), 1,
    'Testing the value for positional';
    is (foo2 1, x => 20, y => 300, 4000), 320,
    'Testing the value for slurpy *%h';
    is (foo3 1, x => 20, y => 300, 4000), 4000,
    'Testing the value for slurpy *@a';

    # XXX should this really die?
    #?rakudo todo 'positional params can be accessed as named ones'
    dies_ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `sub foo($n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`';

## We *can* pass positional arguments as a 'named' pair with slurpy *%h.
## Only *remaining* pairs are slurped into the *%h
# Note: with slurpy *@a, you can pass positional params, But will be slurped into *@a
    diag('Testing without positional arguments');
    lives_ok { foo n => 20, y => 300, 4000 },
    'Testing: `sub foo($n, *%h, *@a){ }; foo n => 20, y => 300, 4000`';
#?rakudo 3 todo 'positional params can be passed as named ones'
    is (foo1 n => 20, y => 300, 4000), 20,
    'Testing the value for positional';
    is (foo2 n => 20, y => 300, 4000), 300,
    'Testing the value for slurpy *%h';
    is (foo3 n => 20, y => 300, 4000), 4000,
    'Testing the value for slurpy *@a';
}


{
    my sub foo ($n, *%h) { };
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    #?pugs todo 'bug'
    #?rakudo todo ''
    dies_ok { foo 1, n => 20, y => 300 },
        'Testing: `sub foo($n, *%h) { }; foo 1, n => 20, y => 300`';
}

{
    my sub foo ($n, *%h) { };
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    dies_ok { foo 1, x => 20, y => 300, 4000 },
        'Testing: `sub foo($n, *%h) { }; foo 1, x => 20, y => 300, 4000`';
}


# Named with slurpy *%h and slurpy *@a
# named arguments aren't required in tests below
{
    my sub foo(:$n, *%h, *@a) { };
    my sub foo1(:$n, *%h, *@a) { $n };
    my sub foo2(:$n, *%h, *@a) { %h<x> + %h<y> + %h<n> };
    my sub foo3(:$n, *%h, *@a) { [+] @a };
    
    diag("Testing with named arguments (named param isn't required)");
    lives_ok { foo 1, x => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
    ok (foo1 1, x => 20, y => 300, 4000) ~~ undef,
      'Testing value for named argument';
    is (foo2 1, x => 20, y => 300, 4000), 320,
      'Testing value for slurpy *%h';
    is (foo3 1, x => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';
    
    ### named parameter pair will always have a higher "priority" while passing
    ### so %h<n> will always be undef
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
    my sub foo(:$n!, *%h, *@a){ };
    diag('Testing with named arguments (named param is required) (++ version)');
    lives_ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(+:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    #?pugs todo 'bug'
    dies_ok { foo 1, x => 20, y => 300, 4000 };
}

#### "trait" version
{
    my sub foo(:$n is required, *%h, *@a) { };
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

L<S06/List parameters/Slurpy scalar parameters capture what would otherwise be the first elements of the variadic array:>

=end desc

{
    sub first(*$f, *$s, *@r){ return $f };
    sub second(*$f, *$s, *@r){ return $s };
    sub rest(*$f, *$s, *@r){ return [+] @r };
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

# vim: ft=perl6
