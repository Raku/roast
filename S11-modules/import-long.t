use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");
use MONKEY-SEE-NO-EVAL;

plan 9;

eval-lives-ok q<use LongNames;>, "export with overlapping short names doesn't fail";

for <Foo Bar> -> $l1 {
    for <C1 C2> -> $l2 {
        is EVAL("use LongNames; {$l1}::{$l2}.^name"), "LongNames::{$l1}::{$l2}", "{$l1}::{$l2} -- exported symbol name includes it's enclosing module";
        eval-lives-ok "use LongNames; {$l1}::{$l2}.new", "{$l1}::{$l2} -- export symbol is a class we can use";
    }
}
