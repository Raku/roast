use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");
use MONKEY-SEE-NO-EVAL;

plan 23;

eval-lives-ok q<use LongNames;>, "export with overlapping short names doesn't fail";

for <Foo Bar> -> $l1 {
    # Classes
    my $sym = 'class';
    for <C1 C2> -> $l2 {
        is EVAL("use LongNames; {$l1}::{$l2}.^name"), "LongNames::{$l1}::{$l2}", "{$l1}::{$l2} -- exported $sym name includes it's enclosing module";
        eval-lives-ok "use LongNames; {$l1}::{$l2}.new", "{$l1}::{$l2} -- exported symbol is a class we can use";
    }

    # Enums
    $sym = "enum";
#?rakudo 1 todo "enum full name must include it's enclosing package, as subset does"
    is EVAL("use LongNames; {$l1}::Vals.^name"), "LongNames::{$l1}::Vals", "{$l1}::Vals -- exported $sym name is as declared";
    for <Val1 Val2> -> $v {
        ok EVAL("use LongNames; {$l1}::Vals.WHO<{$l1}{$v}>:exists"), "{$l1}::Vals -- exported enum contains value {$l1}{$v}";
    }
    nok EVAL("use LongNames; {$l1}::Vals.WHO<{$l1}NoVal>:exists"), "{$l1}::Vals -- exported enum doesn't contain value {$l1}NoVal";

    # Subsets
    $sym = "subset";
    is EVAL("use LongNames; {$l1}::MyInt.^name"), "LongNames::{$l1}::MyInt", "{$l1}::MyInt -- exported $sym name is as declared";
    eval-lives-ok "use LongNames; my {$l1}::MyInt \$v = 13", "{$l1}::MyInt subset accepts allowed value";
    eval-dies-ok "use LongNames; my {$l1}::MyInt \$v = 7", "{$l1}::MyInt subset dies on bad value";
}
