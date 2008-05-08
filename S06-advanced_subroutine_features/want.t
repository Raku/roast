use v6;

use Test;

plan 15;

# L<S06/The C<want> function/shorthand methods to reduce line noise>
sub obj_ok_in_item   { want.item         ?? 42 !! 0 }
sub obj_ok_in_list   { want.list         ?? 42 !! 0 }
sub obj_ok_in_count2 { (want.count == 2) ?? 42 !! 0 }
sub obj_ok_in_count3 { (want.count == 3) ?? 42 !! 0 }

# ok_in_rw is different, because it has to be a lvalue.
sub obj_ok_in_rw is rw {
  my $forty_two = 42;
  my $zero      = 0;

  # By returning variables instead of constants, our sub can act as a lvalue.
  want.count ?? $forty_two !! $zero;
}

#?pugs todo 'feature'
{
    is try { my $item_ctx = obj_ok_in_item() }, 42,
      "want() works correctly in Item context (object-form)";

    is try { my @list_ctx = obj_ok_in_list() },   42,
        "want() works correctly in List context (object-form)";

    my ($a, $b, $c, $d, $e);
    is try { ($a, $b)    = obj_ok_in_count2() }, 42,
      "want.count() works correct if two return values are expected (object-form)";

    is try { ($c,$d,$e)  = obj_ok_in_count3() }, 42,
      "want.count() works correct if three return values are expected (object-form)";

    is try { obj_ok_in_rw() = 23 },              42,
      "want() works correctly in rw context (object-form)";
}

# The same again, but this time using the smartmatch operator.
# L<S06/The C<want> function/Or use its shorthand methods to reduce line noise>
sub sm_ok_in_item   { want ~~ 'Item' ?? 42 !! 0 }
sub sm_ok_in_list   { want ~~ 'List' ?? 42 !! 0 }
sub sm_ok_in_count2 { want ~~ 2      ?? 42 !! 0 }
sub sm_ok_in_count3 { want ~~ 3      ?? 42 !! 0 }

my ($item_ctx, @list_ctx);

#?pugs todo 'feature'
{
    is try { $item_ctx = sm_ok_in_item() }, 42,
      "want() works correctly in Item context (smartmatch-form)";

    is try { @list_ctx   = sm_ok_in_list() },   42,
        "want() works correctly in List context (smartmatch-form)";

    is try { ($a, $b)    = sm_ok_in_count2() }, 42,
      "want.count() works correct if two return values are expected (smartmatch-form)";

    is try { ($c,$d,$e)  = sm_ok_in_count3() }, 42,
      "want.count() works correct if three return values are expected (smartmatch-form)";
}

# Test the identity of want() across function calls:
sub wants_array( *@got ) { return @got };
sub gives_array() { return want };
my @a = gives_array;
@a = wants_array( @a );
my @b = wants_array( gives_array(), gives_array() );

is( substr(@a, 0, 4), substr(@b, 0, 4), "want() context propagates consistently" ); 

#?pugs 2 todo 'bug'
like( @a[0], rx:P5/Item/, "The context is Item");
like( @b[0], rx:P5/Item/, "... on both subs");

# Test the identity again, via splice(), a builtin:
my @tmp = (1..10);
@a = splice(@tmp, 8, 1);
@tmp = (1..10);
@b = wants_array(splice @tmp, 8, 1);
is( @a, @b, "want() results are consistent for builtins" ); 
is( @a, [9], "We got the expected results");
is( @b, [9], "... on both calls" );

