use v6;

use Test;

plan 105;

=begin pod

Misc. Junction tests 

=end pod

# RT #64184
{
    isa_ok any(6,7), Junction;
    is any(6,7).WHAT.gist, Junction.gist, 'junction.WHAT works';
}

# avoid auto-threading on ok()
#?DOES 1
sub jok(Mu $condition, $msg?) { ok ?($condition), $msg };

# L<S03/Junctive operators>
# L<S09/Junctions>
{

    # initialize them all to empty strings
    my $a = '';
    my $b = '';
    my $c = '';
    
    # make sure they all match to an empty string
    jok('' eq ($a & $b & $c), 'junction of ($a & $b & $c) matches an empty string');
    jok('' eq all($a, $b, $c), 'junction of all($a, $b, $c) matches an empty string');   
    
    # give $a a value
    $a = 'a';  
    
    # make sure that at least one of them matches 'a' 
    jok('a' eq ($b | $c | $a), 'junction of ($b | $c | $a) matches at least one "a"');
    jok('a' eq any($b, $c, $a), 'junction of any($b, $c, $a) matches at least one "a"');   

    jok('' eq ($b | $c | $a), 'junction of ($b | $c | $a) matches at least one empty string');
    jok('' eq any($b, $c, $a), 'junction of any($b, $c, $a) matches at least one empty string');
    
    # make sure that ~only~ one of them matches 'a'
    jok('a' eq ($b ^ $c ^ $a), 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
    jok('a' eq one($b, $c, $a), 'junction of one($b, $c, $a) matches at ~only~ one "a"');
    
    # give $b a value
    $b = 'a';
    
    # now this will fail
    jok('a' ne ($b ^ $c ^ $a), 'junction of ($b ^ $c ^ $a) matches at more than one "a"');              

    # change $b and give $c a value
    $b = 'b';
    $c = 'c';
    
    jok('a' eq ($b ^ $c ^ $a), 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
    jok('b' eq ($a ^ $b ^ $c), 'junction of ($a ^ $b ^ $c) matches at ~only~ one "b"');
    jok('c' eq ($c ^ $a ^ $b), 'junction of ($c ^ $a ^ $b) matches at ~only~ one "c"');  

    jok('a' eq ($b | $c | $a), 'junction of ($b | $c | $a) matches at least one "a"');
    jok('b' eq ($a | $b | $c), 'junction of ($a | $b | $c) matches at least one "b"');
    jok('c' eq ($c | $a | $b), 'junction of ($c | $a | $b) matches at least one "c"'); 

    
    # test junction to junction
    jok(('a' | 'b' | 'c') eq ($a & $b & $c), 'junction ("a" | "b" | "c") matches junction ($a & $b & $c)');    
    jok(('a' & 'b' & 'c') eq ($a | $b | $c), 'junction ("a" & "b" & "c") matches junction ($a | $b | $c)'); 
    
    # mix around variables and literals
    
    jok(($a & 'b' & 'c') eq ('a' | $b | $c), 'junction ($a & "b" & "c") matches junction ("a" | $b | $c)');              
    jok(($a & 'b' & $c) eq ('a' | $b | 'c'), 'junction ($a & "b" & $c) matches junction ("a" | $b | "c")');              
    
}

# same tests, but with junctions as variables
{
        # initialize them all to empty strings
    my $a = '';
    my $b = '';
    my $c = '';
    
    my Mu $all_of_them = $a & $b & $c;
    jok('' eq $all_of_them, 'junction variable of ($a & $b & $c) matches and empty string');
    
    $a = 'a';  
    
    my Mu $any_of_them = $b | $c | $a;
    jok('a' eq $any_of_them, 'junction variable of ($b | $c | $a) matches at least one "a"');  
    jok('' eq $any_of_them, 'junction variable of ($b | $c | $a) matches at least one empty string');
    
    my Mu $one_of_them = $b ^ $c ^ $a;
    jok('a' eq $one_of_them, 'junction variable of ($b ^ $c ^ $a) matches at ~only~ one "a"');
    
    $b = 'a';
    
    {
        my Mu $one_of_them = $b ^ $c ^ $a;
        jok('a' ne $one_of_them, 'junction variable of ($b ^ $c ^ $a) matches at more than one "a"');              
    }
    
    $b = 'b';
    $c = 'c';
    
    {
        my Mu $one_of_them = $b ^ $c ^ $a;    
        jok('a' eq $one_of_them, 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
        jok('b' eq $one_of_them, 'junction of ($a ^ $b ^ $c) matches at ~only~ one "b"');
        jok('c' eq $one_of_them, 'junction of ($c ^ $a ^ $b) matches at ~only~ one "c"');  
    }

    {
        my Mu $any_of_them = $b | $c | $a;
        jok('a' eq $any_of_them, 'junction of ($b | $c | $a) matches at least one "a"');
        jok('b' eq $any_of_them, 'junction of ($a | $b | $c) matches at least one "b"');
        jok('c' eq $any_of_them, 'junction of ($c | $a | $b) matches at least one "c"'); 
    }

}

{
    my Mu $j = 1 | 2;
    $j = 5;
    is($j, 5, 'reassignment of junction variable');
}

{
    my Mu $j;
    my Mu $k;

    $j = 1|2;
    is(WHAT($j).gist, '(Junction)', 'basic junction type reference test');

    $k=$j;
    is(WHAT($k).gist, '(Junction)', 'assignment preserves reference');
}


=begin description

Tests junction examples from Synopsis 03 

j() is used to convert a junction to canonical string form, currently
just using .perl until a better approach presents itself.

=end description

# L<S03/Junctive operators>

# Canonical stringification of a junction
sub j (Mu $j) { return $j.perl }

{
    # L<S03/Junctive operators/They thread through operations>
    my Mu $got;
    my Mu $want;
    $got = ((1|2|3)+4);
    $want = (5|6|7);
    is( j($got), j($want), 'thread + returning junctive result');

    $got = ((1|2) + (3&4));
    $want = ((4|5) & (5|6));
    is( j($got), j($want), 'thread + returning junctive combination of results');

    # L<S03/Junctive operators/This opens doors for constructions like>
    # unless $roll == any(1..6) { print "Invalid roll" }
    my $roll;
    my $note;
    $roll = 3; $note = '';
    unless $roll == any(1..6) { $note = "Invalid roll"; };
    is($note, "", 'any() junction threading ==');

    $roll = 7; $note = '';
    unless $roll == any(1..6) { $note = "Invalid roll"; };
    is($note, "Invalid roll", 'any() junction threading ==');

    # if $roll == 1|2|3 { print "Low roll" }
    $roll = 4; $note = '';
    if $roll == 1|2|3 { $note = "Low roll" }
    is($note, "", '| junction threading ==');

    $roll = 2; $note = '';
    if $roll == 1|2|3 { $note = "Low roll" }
    is($note, "Low roll", '| junction threading ==');
}

{
    # L<S03/Junctive operators/Junctions work through subscripting>
    my $got;
    my @foo;
    $got = ''; @foo = ();
    $got ~= 'y' if try { @foo[any(1,2,3)] };
    is($got, '', "junctions work through subscripting, 0 matches");

    $got = ''; @foo = (0,1);
    $got ~= 'y' if try { @foo[any(1,2,3)] };
    is($got, 'y', "junctions work through subscripting, 1 match");

    $got = ''; @foo = (1,1,1);
    $got ~= 'y' if try { @foo[any(1,2,3)] };
    is($got, 'y', "junctions work through subscripting, 3 matches");


    # L<S03/Junctive operators/Junctions are specifically unordered>
    # Compiler *can* reorder and parallelize but *may not* so don't test
    # for all(@foo) {...};  

    # Not sure what is expected
    #my %got = ('1' => 1); # Hashes are unordered too
    #@foo = (2,3,4);
    #for all(@foo) { %got{$_} = 1; };
    #is( %got.keys.sort.join(','), '1,2,3,4',
    #    'for all(...) { ...} as parallelizable');
}

=begin description

These are implemented but still awaiting clarification on p6l.

 On Fri, 2005-02-11 at 10:46 +1100, Damian Conway wrote:
 > Subject: Re: Fwd: Junctive puzzles.
 >
 > Junctions have an associated boolean predicate that's preserved across 
 > operations on the junction. Junctions also implicitly distribute across 
 > operations, and rejunctify the results.

=end description

# L<S03/Junctive operators/They thread through operations>

{
    my @subs = (sub {3}, sub {2});

    my Mu $got;
    my Mu $want;

    is(j(any(@subs)()), j(3|2), '.() on any() junction of subs');

    $want = (3&2);
    $got = all(@subs)();
    is(j($got), j($want), '.() on all() junction of subs');

    $want = (3^2);
    $got = one(@subs)();
    is(j($got), j($want), '.() on one() junction of subs');

    $want = none(3,2);
    $got = none(@subs)();
    is(j($got), j($want), '.() on none() junction of subs');

    $want = one( any(3,2), all(3,2) );
    $got = one( any(@subs), all(@subs) )();
    is(j($got), j($want), '.() on complex junction of subs');

    # Avoid future constant folding
    #my $rand = rand;
    #my $zero = int($rand-$rand);
    #my @subs = (sub {3+$zero}, sub {2+$zero});
}

# Check functional and operator versions produce the same structure
{
    is(j((1|2)^(3&4)), j(one(any(1,2),all(3,4))),
        '((1|2)^(3&4)) equiv to one(any(1,2),all(3,4))');

    is(j((1|2)&(3&4)), j(all(any(1,2),all(3,4))), 
        '((1|2)&(3&4)) equiv to all(any(1,2),all(3,4))');

    is(j((1|2)|(3&4)), j(any(any(1,2),all(3,4))),
        '((1|2)|(3&4)) equiv to any(any(1,2),all(3,4))');
}

# junction in boolean context
ok(?(0&0) == ?(0&&0), 'boolean context');
ok(?(0&1) == ?(0&&1), 'boolean context');
ok(?(1&1) == ?(1&&1), 'boolean context');
ok(?(1&0) == ?(1&&0), 'boolean context');
ok(!(?(0&0) != ?(0&&0)), 'boolean context');
ok(!(?(0&1) != ?(0&&1)), 'boolean context');
ok(!(?(1&1) != ?(1&&1)), 'boolean context');
ok(!(?(1&0) != ?(1&&0)), 'boolean context');


{
    my $c = 0;
    if 1 == 1 { $c++ }
    is $c, 1;
    if 1 == 1|2 { $c++ }
    is $c, 2;
    if 1 == 1|2|3 { $c++ }
    is $c, 3;

    $c++ if 1 == 1;
    is $c, 4;
    $c++ if 1 == 1|2;
    is $c, 5, 'if modifier with junction should be called once';

    $c = 0;
    $c++ if 1 == 1|2|3;
    is $c, 1, 'if modifier with junction should be called once';

    $c = 0;
    $c++ if 1 == any(1, 2, 3);
    is $c, 1, 'if modifier with junction should be called once';
}

{
    my @array = <1 2 3 4 5 6 7 8>;
    jok( all(@array) == one(@array), "all(@x) == one(@x) tests uniqueness(+ve)" );

    push @array, 6;
    jok( !( all(@array) == one(@array) ), "all(@x) == one(@x) tests uniqueness(-ve)" );

}

# used to be a rakudo regression (RT #60886)
ok Mu & Mu ~~ Mu, 'Mu & Mu ~~ Mu works';

## See also S03-junctions/autothreading.t
{
  is substr("abcd", 1, 2), "bc", "simple substr";
  my Mu $res = substr(any("abcd", "efgh"), 1, 2);
  isa_ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc";
  ok $res eq "fg", "substr on junctions: fg";
}

{
  my Mu $res = substr("abcd", 1|2, 2);
  isa_ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc"; 
  ok $res eq "cd", "substr on junctions: cd";
}

{
  my Mu $res = substr("abcd", 1, 1|2);
  isa_ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc"; 
  ok $res eq "b", "substr on junctions: b"; 
}

{
  my Mu $res = index(any("abcd", "qwebdd"), "b");
  isa_ok $res, Junction;
  ok $res == 1, "index on junctions: 1";
  ok $res == 3, "index on junctions: 3";
}

{
  my Mu $res = index("qwebdd", "b"|"w");
  isa_ok $res, Junction;
  ok $res == 1, "index on junctions: 1";
  ok $res == 3, "index on junctions: 3";
}

# RT #63686
{
    lives_ok { try { for any(1,2) -> $x {}; } },
             'for loop over junction in try block';

    sub rt63686 {
        for any(1,2) -> $x {};    #OK not used
        return 'happiness';
    }
    is rt63686(), 'happiness', 'for loop over junction in sub';
}

# RT #67866: [BUG] [LHF] Error with stringifying .WHAT on any junctions
#?rakudo skip 'lower case junction'
#?niecza skip 'Impossible test: === takes Any'
{
    ok((WHAT any()) === Junction, "test WHAT on empty any junction");
    ok(any().WHAT === Junction, "test WHAT on empty any junction");
    ok((WHAT any(1,2)) === Junction, "test WHAT on any junction");
    ok(any(1,2).WHAT === Junction, "test WHAT on any junction");
}

# Any list has junction methods
{
    jok(5 < (6,7,8).all, '.all method builds "all" junction');
    jok(!(7 < (6,7,8).all), '.all method builds "all" junction');
    jok(7 == (6,7,8).one, '.one method builds "one" junction');
    jok(9 == (6,7,8).none, '.none method builds "none" junction');

    my @x = (6,7,8);
    jok(5 < @x.all, '.all method works on array objects');
}

# RT #63126
#?rakudo todo 'nom regression'
#?DOES 2
{
    my @a = "foo", "foot";
    ok @a[all(0,1)] ~~ /^foo/,
        'junction can be used to index Array';

    my %h = (
        "0" => "foo",
        "1" => "foot"
    );
    ok %h{all(0,1)} ~~ /^foo/,
        'junction can be used to index Hash';
}

# stringy tests
#?niecza todo '#82'
{
   my class Foo {
      multi method gist(Foo:D:) { "gisted"; }
      multi method perl(Foo:D:) { "perled"; }
      multi method Str(Foo:D:) { "Stred"; }
   }
   is any(Foo.new).perl, 'any(perled)', 'any(Foo.new).perl';
   is any(Foo.new).gist, 'any(gisted)', 'any(Foo.new).gist';
}

# RT #109188
ok { a => 1} ~~ List|Hash, 'Can construct junction with List type object';

# RT #112392
ok (1|2).Str ~~ Str, 'Junction.Str returns a Str, not a Junction';

# RT #101124
ok (0|1 == 0&1), 'test junction evaluation order';
ok (0&1 == 0|1), 'test junction evaluation order';

done();

# vim: ft=perl6
