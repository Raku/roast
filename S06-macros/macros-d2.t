use v6;

use Test;
plan 5;

# editorial note:
# macros in this file have been named after 20th-century physicists.

{ # simplest possible unquote splicing
    my $unquote_splicings;
    BEGIN { $unquote_splicings = 0 }; # so it's not Any() if it doesn't work

    macro planck($x) {
        quasi { {{{$unquote_splicings++; $x}}} }
    }

    planck "length";
    is $unquote_splicings, 1, "spliced code runs at parse time";
}

#{ # building an AST from smaller ones
#    macro bohr() {
#        my $q1 = quasi { 6 };
#        my $q2 = quasi { 6 * 10 };
#        my $q3 = quasi { 100 + 200 + 300 };
#        quasi { {{{$q1}}} + {{{$q2}}} + {{{$q3}}} }
#    }
#
#    is bohr(), 666, "building quasis from smaller quasis works";
#}

{ # building an AST incrementally
    macro einstein() {
        my $q = quasi { 2 };
        $q = quasi { 1 + {{{$q}}} };
        $q = quasi { 1 + {{{$q}}} };
        $q;
    }

    is einstein(), 4, "can build ASTs incrementally";
}

#?rakudo todo 'something gets wrongly bound here'
{ # building an AST incrementally in a for loop
    macro podolsky() {
        my $q = quasi { 2 };
        $q = quasi { 1 + {{{$q}}} } for ^2;
        $q;
    }

    is podolsky(), 4, "can build ASTs in a for loop";
}

#?rakudo todo 'unquotes get the wrong lexical context'
{ # using the mainline context from an unquote
    macro rosen($code) {
        my $paradox = "this shouldn't happen";
        quasi {
            {{{$code}}}();
        }
    }

    my $paradox = "EPR";
    is rosen(sub { $paradox }), "EPR", "unquotes retain their lexical context";
}

#?rakudo todo 'no type checking on unquote results'
{ # unquotes must evaluate to ASTs
    macro bohm() {
        my $q = "certainly not an AST";
        quasi { {{{$q}}} }
    }

    eval_dies_ok('bohm', 'unquote must provide an AST');
}
