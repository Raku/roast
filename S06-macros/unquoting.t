use v6;

use lib 't/spec/packages';
use Test::Util;

use Test;
plan 10;

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

{ # building an AST incrementally in a for loop
    macro podolsky() {
        my $q = quasi { 2 };
        $q = quasi { 1 + {{{$q}}} } for ^2;
        $q;
    }

    is podolsky(), 4, "can build ASTs in a for loop";
}

{ # using the mainline context from an unquote
    macro rosen($code) {
        my $paradox = "this shouldn't happen";
        quasi {
            {{{$code}}}();
        }
    }

    my $paradox = "EPR";
    #?rakudo todo 'unquotes get the wrong lexical context'
    is rosen(sub { $paradox }), "EPR", "unquotes retain their lexical context";
}

{ # unquotes must evaluate to ASTs
    #?does 5
    throws_like 'macro bohm() { quasi { {{{"not an AST"}}} } }; bohm',
                X::TypeCheck::Splice,
                got      => Str,
                expected => AST,
                action   => 'unquote evaluation',
                line     => 1;
}
