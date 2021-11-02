use v6;

use Test;

plan 17;

# L<S04/The Relationship of Blocks and Declarations/There is also a let function>
# L<S04/Definition of Success>
# let() should not restore the variable if the block exited successfully
# (returned a true value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (1)";
}

# let() should restore the variable if the block failed (returned a false
# value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "let() changed the variable (1)");
    Mu;
  }
  is $a, 42, "let() should restore the variable, as our block failed";
}

# Test that let() restores the variable at scope exit, not at subroutine
# entry.  (This might be a possibly bug.)
{
  my $a     = 42;
  my $get_a = { $a };
  {
    is($(let $a = 23; $a),       23, "let() changed the variable (2-1)");
    is $get_a(), 23, "let() changed the variable (2-2)";
    1;
  }
  is $a, 23, "let() should not restore the variable, as our block exited successfully (2)";
}

# Test that let() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is($(let $a = 23; $a), 23, "let() changed the variable in a try block");
    die 57;
  };
  # https://github.com/Raku/old-issue-tracker/issues/3369
  #?rakudo.jvm todo 'let restore on exception, RT #121647'
  is $a, 42, "let() restored the variable, the block was exited using an exception";
}

{
  my @array = (0, 1, 2);
  {
    is($(let @array[1] = 42; @array[1]), 42, "let() changed our array element");
    Mu;
  }
  is @array[1], 1, "let() restored our array element";
}

{
    my $x = 5;
    sub f() {
        let $x = 10;
        fail 'foo';
    }
    my $sink = f(); #OK
    is $x, 5, 'fail() resets let variables';
}

# https://github.com/Raku/old-issue-tracker/issues/5057
{
    my %h{Pair}; %h{a => 1} = 2;
    my %c{Pair}; %c{a => 1} = 2;
    {
        let %h;
        %h{a => 1} = 42;
        Nil
    }
    is-deeply %h, %c, 'let works with parametarized Hashes';
}

{
    my @a is default(Nil) = Nil;
    my @c is default(Nil) = Nil;
    { let @a; Nil }
    is-deeply @a, @c, '`let` keeps around Nils in Arrays when they exist';

    (my %h is default(Nil))<a> = Nil;
    (my %c is default(Nil))<a> = Nil;
    { let %h; Nil };
    is-deeply %h, %c, '`let` keeps Nils around in Hashes when they exist';
}

# https://github.com/rakudo/rakudo/issues/1433
# Make sure that holes and containerization are preserved.
{
    subtest "let with Array" => {
        plan 12;
        my @a;
        @a[3] = 42;
        @a[2] := 12;

        # Control tests
        nok @a[1]:exists, "control: there is an expected hole";
        isa-ok @a[3].VAR.WHAT, Scalar, "control: there is a container at the assigned position";
        isa-ok @a[2].VAR.WHAT, Int, "control: there is no container at the bound position";

        {
            let @a;

            #?rakudo todo "NYI"
            nok @a[1]:exists, "let doesn't vivifies containers in holes";
            @a[1] = 13;
            ok @a[1]:exists, "assignment closes a hole on localized array";

            #?rakudo todo "NYI"
            isa-ok @a[2].VAR.WHAT, Int, "let doesn't containerize bound elements";
            isa-ok @a[3].VAR.WHAT, Scalar, "let doesn't decontainerize assigned elements";

            @a[2] = "12";
            @a[3] := "42";

            isa-ok @a[2].VAR.WHAT, Scalar, "control: containerized a bound element";
            isa-ok @a[3].VAR.WHAT, Str, "control: decontainerized by binding";

            Nil
        }

        nok @a[1]:exists, "hole is back after restoration";
        isa-ok @a[2].VAR.WHAT, Int, "non-container element is correctly restored";
        isa-ok @a[3].VAR.WHAT, Scalar, "containerized element is correctly restored";
    }

    subtest "let with Hash" => {
        plan 4;
        my sub let-hash(\h, $msg) is test-assertion {
            subtest $msg => {
                plan 8;
                h<a> = 1;
                h<c> := 3;
                isa-ok h<a>.VAR.WHAT, Scalar, "control: assigned value is containerized";
                isa-ok h<c>.VAR.WHAT, Int, "control: bound value is not containerized";

                {
                    let h;

                    isa-ok h<a>.VAR.WHAT, Scalar, "let doesn't decontainerize assigned elements";
                    isa-ok h<c>.VAR.WHAT, Int, "let doesn't containerize bound elements";

                    h<a> := 42;
                    h<c>:delete;
                    h<c> = 13;

                    isa-ok h<a>.VAR.WHAT, Int, "control: decontainerized by binding";
                    isa-ok h<c>.VAR.WHAT, Scalar, "control: containerized by re-assignment";

                    Nil
                }

                isa-ok h<a>.VAR.WHAT, Scalar, "containerized element is correctly restored";
                isa-ok h<c>.VAR.WHAT, Int, "non-container element is correctly restored";
            }
        }

        let-hash my %h, "plain hash";
        let-hash my Int %h, "typed hash";
        let-hash my %h{Str}, "object hash";
        let-hash my Int %h{Str}, "typed object hash";
    }
}

# vim: expandtab shiftwidth=4
