use v6;

use Test;

plan 98;
#force_todo 8, 44, 46, 48; # untodo with r10745

#?pugs emit unless $?PUGS_BACKEND eq "BACKEND_PUGS" {
#?pugs emit   skip_rest "eval() not yet implemented in $?PUGS_BACKEND.";
#?pugs emit   exit;
#?pugs emit }

# L<S02/Names and Variables/To get a Perlish representation of any object>
# Quoting S02 (emphasis added):
#   To get a Perlish representation of any data value, use the .perl method.
#   This will put quotes around strings, square brackets around list values,
#   curlies around hash values, etc., **such that standard Perl could reparse
#   the result**.
sub desc_perl ($obj) {
    "($obj.perl()).perl returned something whose eval()ed stringification is unchanged";
}
sub desc_ref ($obj) {
    "($obj.perl()).perl returned something whose eval()ed .WHAT is unchanged";
}

{
    # tests 1-6
    for (42, 42/10, 4.2,) -> $obj {
      is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
      is ~"WHAT($obj.perl())".eval, ~$obj.WHAT, desc_ref($obj);
    }
    
    # tests 7,8
    for (sqrt(2)) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is ~"WHAT($obj.perl())".eval, ~$obj.WHAT, desc_ref($obj), :todo<bug>;
    }
    
    # tests 9-16
    for (3e5, Inf, -Inf, NaN,) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    for ("a string", "", "\0", "\t", "\n", "\r\n", "\o7", '{', '}', "\d123",) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    for (?1, ?0, undef,) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    #?rakudo emit skip 6, 'rx:P5// does not work';

    #?rakudo emit =begin skip 
    for (rx:P5/foo/, rx:P5//, rx:P5/^.*$/,) -> $obj {
        is ~"item($obj.perl())".eval, ~$obj, desc_perl($obj), :todo<bug>;
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj), :todo<bug>;
    }
    #?rakudo emit =end skip

    #?rakudo emit skip 18, '\\foo does not work';

    #?rakudo emit =begin skip 
    for (\42, \Inf, \-Inf, \NaN, \"string", \"", \?1, \?0, \undef,) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }
    #?rakudo emit =end skip

    # Pairs - XXX - Very Broken - FIXME!
    for ((a => 1),:b(2),) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    for ([],  [ 42 ]     ,  [< a b c>],) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    for ({ a => 42, },  { :a(1), :b(2), :c(3) },) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

#    for ([ 3..42 ], [ 3..Inf ], [ -Inf..Inf ], [ 3..42, 17..Inf, -Inf..5 ],) -> $obj {
#        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
#        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
#    }


    for ({ a => [1,2,3] },) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    for ([ [1,2,3] ],) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    # tests 85-88
    for ({ a => [1,2,3], b => [4,5,6] },) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

    # tests 89-92
    for ([ { :a(1) }, { :b(2), :c(3) } ],) -> $obj {
        is ~"item($obj.perl())".eval    , ~$obj    , desc_perl($obj);
        is  "WHAT($obj.perl())".eval,  $obj.WHAT, desc_ref($obj);
    }

}

# Recursive data structures
{
    my $foo = [ 42 ]; $foo[1] = $foo;
    is $foo[1][1][1][0], 42, "basic recursive arrayref";

    # XXX hangs
    flunk "skipping hanging test", :todo<bug>;
    #is ~$foo.perl.eval, ~$foo,
    #    ".perl worked correctly on a recursive arrayref";
}

{
    my $foo = { a => 42 }; $foo<b> = $foo;
    is $foo<b><b><b><a>, 42, "basic recursive hashref";

    # XXX hangs
    flunk "skipping hanging test", :todo<bug>;
    #is ~$foo.perl.eval, ~$foo,
    #    ".perl worked correctly on a recursive hashref";
}

{
    my $foo = [ 42 ];
    my $bar = { a => 23 };
    $foo[1] = $bar;
    $bar<b> = $foo;

    is $foo[1]<b>[1]<b>[0], 42, "mixed arrayref/hashref recursive structure";

    # XXX hangs
    flunk "skipping hanging test", :todo<bug>;
    #is ~$foo.perl.eval, ~$foo,
    #    ".perl worked correctly on a mixed arrayref/hashref recursive structure";
}

{
    # test a bug reported by Chewie[] - apparently this is from S03
    is((("f","oo","bar").keys).perl, "(0, 1, 2)", ".perl on a .keys list");
}

#?rakudo emit skip 3, 'hyperoperator does not work';

#?rakudo emit =begin skip
{
    # test bug in .perl on result of hyperoperator
    # first the trivial case without hyperop
    my @foo = ([-1, -2], -3);
    is @foo.perl, '[[-1, -2], -3]', ".perl on a nested list";

    my @hyp = -« ([1, 2], 3);
    # what it currently (r16460) gives
    isnt @hyp.perl, '[(-1, -2), -3]', "strange inner parens from .perl on result of hyperop", :todo<bug>;

    # what it should give
    is @hyp.perl, '[[-1, -2], -3]', ".perl on a nested list result of hyper operator", :todo<bug>;
}
#?rakudo emit =end skip
