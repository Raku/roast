use Test; plan 17;

# L<S12/"Calling sets of methods">
# L<S12/"Roles">

# Spec:
# For any method name, there may be some number of candidate methods that could
# handle the request: typically, inherited methods or multi variants. The
# ordinary "dot" operator dispatches to a method in the standard fashion. There
# are also "dot" variants that call some number of methods with the same name:

#      $object.?meth  # calls method if there is one, otherwise undef

role plugin_1 { multi method init_hook { $.cnt += 2 } }
role plugin_2 { multi method init_hook { $.cnt += 3 } }

class Parent {
    has Int $.cnt is rw;
    does plugin_1;
    does plugin_2;
    method meth {++$.cnt}
}
class Child is Parent {
    method meth {++$.cnt}
    method child_only {'child_only'}
}

{
    my $test = q"$object.?meth calls method if there is one";
    my $object = Child.new;
    my $result = 1; # default to one to see if value changes to undef
    try { $result = $object.?nope };
    ok($object.?meth, $test);
    ok(!$result.defined, q" ..undef otherwise ");

    my $thing = 'child_only';
    is($object.?$thing, 'child_only', '$o.?$name works as expected');
    ok(!$object.'?child_only'.defined, '$object.\'?name\' correctly does not call $object.name');
}

{
    my $test = q"$object.*meth(@args)  # calls all methods (0 or more)";
    my $object = Child.new;
    my $result = 1; # default to one to see if value changes to undef
    try { $result = $object.*nope };
    ok(!$result.defined, q"$test: Case 0 returns undef");

    try { $result = $object.*child_only };
    is($result, 'child_only', "$test: Case 1 finds one result"); 

    try { $result = $object.*meth };
    is($object.cnt, 2, "$test: Case 2 visits both Child and Parent");

    my $meth = 'meth';
    $object = Child.new;
    try { $result = $object.*$meth };
    is($object.cnt, 2, "$test: Case 2 visits both Child and Parent (as dynamic method call)");

    ok(!$object.'*cnt'.defined, '$object.\'*name\' correctly does not call $object.*name');

    my $meth = 'sqrt'; 
    my $ans = 0;
    try { $ans = 4.*$meth };
    is($ans, 2, q"$obj.*$meth works built-in methods like 'sqrt'");
}

{
    # We should not only look in parent classes, but for matching 
    # multi methods in parent classes!
    my $test = q"$object.*meth(@args)  # calls all methods (0 or more) works on multi axis, too";
    my $object = Child.new;
    my $got = 0;
    my $meth = 'init_hook';
    try { $got = $object.*$meth };
    is($got, 5, $test, :todo<feature>);
}

{
    my $test = q"$object.+meth(@args)  # calls all methods (1 or more)";
    my $object = Child.new;
    my $result = 1; # default to one to see if value changes to undef
    try { $result = $object.+nope };
    ok($!, q"$test: Case 0 dies");

    try { $result = $object.+child_only };
    is($result, 'child_only', "$test: Case 1 finds one result"); 

    try { $result = $object.+meth };
    is($object.cnt, 2, "$test: Case 2 visits both Child and Parent");

    my $name = 'child_only';
    is($object.+$name, 'child_only', '$object.+$method works');

    # TODO: add test for $object.+$meth (dynamic method) with multiple methods called as well
}

ok(0, q 'STUB: $object.*WALK[:breadth:omit($?CLASS)]::meth(@args);', :todo<feature> );

ok(0, "STUB: there is more Calling Sets functionality which needs tests", :todo<feature>);
# vim: ft=perl6
