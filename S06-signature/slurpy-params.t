use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# L<S06/List parameters/Slurpy parameters>

plan 87;

sub xelems(*@args) { @args.elems }
sub xjoin(*@args)  { @args.join('|') }

is xelems(1),          1,        'Basic slurpy params 1';
is xelems(1, 2, 5),    3,        'Basic slurpy params 2';

is xjoin(1),           '1',      'Basic slurpy params 3';
is xjoin(1, 2, 5),     '1|2|5',  'Basic slurpy params 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    'Positional and slurp params';
is mixed(1, 2, 3),     '|1|2!3', 'Positional and slurp params';
dies-ok {EVAL(' mixed()')},      'at least one arg required';

sub first_arg      ( *@args         ) { ~@args[0]; }
sub first_arg_rw   ( *@args is raw  ) { ~@args[0]; }
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
    is func(5).elems, 0, "Shift from an array function argument works";
}


sub whatever {
    is(@_[3], 'd', 'implicit slurpy param flattens');
    is(@_[2], 'c', 'implicit slurpy param flattens');
    is(@_[1], 'b', 'implicit slurpy param flattens');
    is(@_[0], 'a', 'implicit slurpy param flattens');
}

whatever( 'a', 'b', 'c', 'd' );

# use to be t/spec/S06-signature/slurpy-params-2.t


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
    lives-ok { foo 1, n => 20, y => 300 },
        'Testing: `sub foo($n, *%h) { }; foo 1, n => 20, y => 300`';
}

{
    my sub foo ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    dies-ok { foo 1, x => 20, y => 300, 4000 },
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
    lives-ok { foo 1, x => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
    nok (foo1 1, x => 20, y => 300, 4000).defined,
      'Testing value for named argument';
    is (foo2 1, x => 20, y => 300, 4000), 320,
      'Testing value for slurpy *%h';
    is (foo3 1, x => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';
    
    ### named parameter pair will always have a higher "priority" while passing
    ### so %h<n> will always be undefined
    lives-ok { foo1 1, n => 20, y => 300, 4000 },
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
    lives-ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(+:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    dies-ok { foo 1, x => 20, y => 300, 4000 };
}

#### "trait" version
{
    my sub foo(:$n is required, *%h, *@a) { };   #OK not used
    diag('Testing with named arguments (named param is required) (trait version)');
    lives-ok { foo 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    dies-ok { foo 1, x => 20, y => 300, 4000 },
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

{
    sub oneargcached (+@foo) { @foo }
    is oneargcached(1,2,3).elems, 3, "comma separates top-level args";
    is oneargcached((1,2,3)).elems, 3, "top-level arg is list";
    is oneargcached([1,2,3]).elems, 3, "top-level arg is array";
    is oneargcached(1..3).elems, 3, "top-level arg is range";
    is oneargcached(1...3).elems, 3, "top-level arg is seq";
    is oneargcached((1,2,3),4).elems, 2, "top-level arg contains list";
    is oneargcached([1,2,3],4).elems, 2, "top-level arg contains array";
    is oneargcached(1..3,4).elems, 2, "top-level arg contains range";
}

{
    sub oneargraw (+foo) { foo }
    is oneargraw(1,2,3).elems, 3, "comma separates top-level args";
    is oneargraw((1,2,3)).elems, 3, "top-level arg is list";
    is oneargraw([1,2,3]).elems, 3, "top-level arg is array";
    is oneargraw(1..3).elems, 3, "top-level arg is range";
    is oneargraw(1...3).elems, 3, "top-level arg is seq";
    is oneargraw((1,2,3),4).elems, 2, "top-level arg contains list";
    is oneargraw([1,2,3],4).elems, 2, "top-level arg contains array";
    is oneargraw(1..3,4).elems, 2, "top-level arg contains range";
    is oneargraw(1..*)[^5], (1,2,3,4,5), "top-level arg is lazy";
}

{
    sub oneargcached ($x, :$y, +@foo) { @foo }
    is oneargcached(0,:y,1,2,3).elems, 3, "comma separates final top-level args";
    is oneargcached(0,:y,(1,2,3)).elems, 3, "final top-level arg is list";
    is oneargcached(0,:y,[1,2,3]).elems, 3, "final top-level arg is array";
    is oneargcached(0,:y,1..3).elems, 3, "final top-level arg is range";
    is oneargcached(0,:y,(1...3)).elems, 3, "final top-level arg is seq";
    is oneargcached(0,:y,(1,2,3),4).elems, 2, "final top-level arg contains list";
    is oneargcached(0,:y,[1,2,3],4).elems, 2, "final top-level arg contains array";
    is oneargcached(0,:y,1..3,4).elems, 2, "final top-level arg contains range";
}

{
    sub oneargraw ($x, :$y, +foo) { foo }
    is oneargraw(0,:y,1,2,3).elems, 3, "comma separates final top-level args";
    is oneargraw(0,:y,(1,2,3)).elems, 3, "final top-level arg is list";
    is oneargraw(0,:y,[1,2,3]).elems, 3, "final top-level arg is array";
    is oneargraw(0,:y,1..3).elems, 3, "final top-level arg is range";
    is oneargraw(0,:y,(1...3)).elems, 3, "final top-level arg is seq";
    is oneargraw(0,:y,(1,2,3),4).elems, 2, "final top-level arg contains list";
    is oneargraw(0,:y,[1,2,3],4).elems, 2, "final top-level arg contains array";
    is oneargraw(0,:y,1..3,4).elems, 2, "final top-level arg contains range";
    is oneargraw(0,:y,1..*)[^5], (1,2,3,4,5), "final top-level arg is lazy";
}

{
    sub f(+a) { a };
    ok f((1,2,3).grep({$_})).WHAT === Seq, "+args passes through Seq unscathed";
    is-deeply f((1,2,3).grep({$_})),(1,2,3), "+args passes through Seq unscathed";

    my @result;
    nok try {
	my \seq = f((1,2,3).grep({$_}));
	push @result, $_ for seq;
	is-deeply @result, [1,2,3], "iteration succeeds on first pass";
	push @result, $_ for seq;
    }.defined, "+args can't repeat a Seq";
    ok $!.WHAT === X::Seq::Consumed, "produces the right error";
    is-deeply @result, [1,2,3], "iteration dies on second pass";
}

{
    sub f(+@a) { @a };
    ok f((1,2,3).grep({$_})).WHAT === List, "+@args converts Seq to List";
    is-deeply f((1,2,3).grep({$_})),(1,2,3), "+@args handles List from Seq";

    my @result;
    my \seq = f((1,2,3).grep({$_}));
    push @result, $_ for seq;
    push @result, $_ for seq;
    is-deeply @result, [1,2,3,1,2,3], "iteration succeeds on second pass";
}

throws-like 'sub rt65324(*@x, $oops) { say $oops }', X::Parameter::WrongOrder,
             "Can't put required parameter after variadic parameters";

# RT #113964, RT #69424
throws-like 'sub typed-slurpy-pos(Int *@a) { }',
    X::Parameter::TypedSlurpy, kind => 'positional';

# RT #120994
throws-like 'sub typed-slurpy-pos(Int *%h) { }',
    X::Parameter::TypedSlurpy, kind => 'named';

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

# RT #128201
#?rakudo.jvm skip 'Proc::Async NYI RT #126524 / RT #128201'
doesn't-hang '{ say @_.gist }(1..Inf)', :out(/'[...]'/),
    '.gist on @_ containing lazy list correctly thinks it is lazy';

# RT #129175
#?rakudo.jvm skip 'Proc::Async NYI RT #129175'
doesn't-hang ｢-> *@a { @a.is-lazy.say }(1…∞)｣, :out(/True/),
    'slurpy positional param does not hang when given infinite lists';

# vim: ft=perl6
