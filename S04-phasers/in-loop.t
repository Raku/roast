use v6;

use Test;

plan 3;

# TODO, based on synopsis 4:
#
# * KEEP, UNDO, PRE, POST, CONTROL
#   CATCH is tested in t/spec/S04-statements/try.t
#                  and t/spec/S04-exception-handlers/catch.t
#
# * $var will undo, etc
#
# * LEAVE type blocks in the context of CATCH
#
# * PRE/POST in classes is not the same as LEAVE/ENTER

# L<S04/"Phasers">

#?rakudo.parrot todo "unknown phasers issue"
#?rakudo.moar todo "unknown phasers issue"
#?rakudo.jvm skip "RT #122134 - last+ENTER in loop"
{
    my $str;

    for 1..10 -> $i {
        last if $i > 3;
        $str ~= "($i a)";
        next if $i % 2 == 1;
        $str ~= "($i b)";
        LAST  { $str ~= "($i Lst)" }
        LEAVE { $str ~= "($i Lv)"  }
        NEXT  { $str ~= "($i N)"   }
        FIRST { $str ~= "($i F)"   }
        ENTER { $str ~= "($i E)"   }
    }

    is $str, "(1 F)(1 E)(1 a)" ~ "(1 N)(1 Lv)" ~
                  "(2 E)(2 a)(2 b)(2 N)(2 Lv)" ~
                  "(3 E)(3 a)" ~ "(3 N)(3 Lv)" ~
                  "(4 E)"  ~          "(4 Lv)(4 Lst)",
       'trait blocks work properly in for loop';
}

#?rakudo todo "unknown phasers issue"
{
    my $str;

    for 1..10 -> $i {
        last if $i > 3;
        $str ~= "($i a)";

        ENTER { $str ~= "($i E1)"   }
        LAST  { $str ~= "($i Lst1)" }
        FIRST { $str ~= "($i F1)"   }
        LEAVE { $str ~= "($i Lv1)"  }

        next if $i % 2 == 1;
        $str ~= "($i b)";

        LAST  { $str ~= "($i Lst2)" }
        NEXT  { $str ~= "($i N1)"   }
        FIRST { $str ~= "($i F2)"   }
        LEAVE { $str ~= "($i Lv2)"  }
        ENTER { $str ~= "($i E2)"   }
        NEXT  { $str ~= "($i N2)"   }
    }

    is $str, 
"(1 F1)(1 F2)(1 E1)(1 E2)(1 a)" ~ "(1 N2)(1 N1)" ~  "(1 Lv2)(1 Lv1)" ~
            "(2 E1)(2 E2)(2 a)(2 b)(2 N2)(2 N1)" ~  "(2 Lv2)(2 Lv1)" ~
            "(3 E1)(3 E2)(3 a)" ~ "(3 N2)(3 N1)" ~  "(3 Lv2)(3 Lv1)" ~
            "(4 E1)(4 E2)"  ~                       "(4 Lv2)(4 Lv1)" ~ "(4 Lst2)(4 Lst1)",
       'trait blocks work properly in for loop';
}

# RT #122011
{
    my $str = "";

    for 10..1 -> $i {
        LAST  { $str ~= "(this should not happen)" }
    }

    is $str, "",
       'LAST does not fire for empty loop';
}

# vim: ft=perl6
