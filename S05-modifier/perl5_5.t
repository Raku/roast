use v6;

use Test;

plan 102;

#L<S05/Modifiers/"The extended syntax">

unless "a" ~~ rx:P5/a/ {
  skip_rest "skipped tests - P5 regex support appears to be missing";
  exit;
}

my $b = 'x';
my $backspace = "\b";
my $bang = '!';

is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){2}(.)/ && $0), "b", 're_tests 609/1 (793)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){4,5}(.)/ && $0), "b", 're_tests 611/1 (795)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){4,5}?(.)/ && $0), "d", 're_tests 613/1 (797)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){6,7}(.)/ && $0), "e", 're_tests 615/1 (799)');
#?rakudo.jvm todo "nigh"
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){6,7}?(.)/ && $0), "e", 're_tests 617/1 (801)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){5,6}(.)/ && $0), "e", 're_tests 619/1 (803)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){5,6}?(.)/ && $0), "b", 're_tests 621/1 (805)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){5,7}(.)/ && $0), "e", 're_tests 623/1 (807)');
is(("acdbcdbe" ~~ rx:P5/a(?:b|c|d){5,7}?(.)/ && $0), "b", 're_tests 625/1 (809)');
is(("AB" ~~ rx:P5/^(.+)?B/ && $0), "A", 're_tests 627/1 (811)');
is(("." ~~ rx:P5/^([^a-z])|(\^)$/ && $0), ".", 're_tests 629/1 (813)');
is(("<&OUT" ~~ rx:P5/^[<>]&/ && $/), "<&", 're_tests 631/0 (815)');
is(("aaaaaaaaaa" ~~ rx:P5/^(a\1?){4}$/ && $0), "aaaa", 're_tests 633/1 (817)');
ok((not ("aaaaaaaaa" ~~ rx:P5/^(a\1?){4}$/)), 're_tests 635  (819)');
ok((not ("aaaaaaaaaaa" ~~ rx:P5/^(a\1?){4}$/)), 're_tests 637  (821)');
#?rakudo todo "unknown issue"
is(("aaaaaaaaaa" ~~ rx:P5/^(a(?(1)\1)){4}$/ && $0), "aaaa", 're_tests 639/1 (823)');
ok((not ("aaaaaaaaa" ~~ rx:P5/^(a(?(1)\1)){4}$/)), 're_tests 641  (825)');
ok((not ("aaaaaaaaaaa" ~~ rx:P5/^(a(?(1)\1)){4}$/)), 're_tests 643  (827)');
is(("aaaaaaaaa" ~~ rx:P5/((a{4})+)/ && $0), "aaaaaaaa", 're_tests 645/1 (829)');
is(("aaaaaaaaaa" ~~ rx:P5/(((aa){2})+)/ && $0), "aaaaaaaa", 're_tests 647/1 (831)');
is(("aaaaaaaaaa" ~~ rx:P5/(((a{2}){2})+)/ && $0), "aaaaaaaa", 're_tests 649/1 (833)');
is(("ab" ~~ rx:P5/(?<=a)b/ && $/), "b", 're_tests 651/0 (835)');
ok((not ("cb" ~~ rx:P5/(?<=a)b/)), 're_tests 653  (837)');
ok((not ("b" ~~ rx:P5/(?<=a)b/)), 're_tests 655  (839)');
is(("ab" ~~ rx:P5/(?<!c)b/ && $/), "b", 're_tests 657/0 (841)');
ok((not ("cb" ~~ rx:P5/(?<!c)b/)), 're_tests 659  (843)');
ok(("b" ~~ rx:P5/(?<!c)b/), 're_tests 661  (845)');
is(("b" ~~ rx:P5/(?<!c)b/ && $/), "b", 're_tests 663/0 (847)');
is(("aba" ~~ rx:P5/(?:..)*a/ && $/), "aba", 're_tests 665/0 (849)');
is(("aba" ~~ rx:P5/(?:..)*?a/ && $/), "a", 're_tests 667/0 (851)');
#?rakudo todo "unknown issue"
is(("abc" ~~ rx:P5/^(?:b|a(?=(.)))*\1/ && $/), "ab", 're_tests 669/0 (853)');
is(("aax" ~~ rx:P5/^(a+)*ax/ && $0), "a", 're_tests 671/1 (855)');
is(("aax" ~~ rx:P5/^((a|b)+)*ax/ && $0), "a", 're_tests 673/1 (857)');
is(("aax" ~~ rx:P5/^((a|bc)+)*ax/ && $0), "a", 're_tests 675/1 (859)');
is(("ab" ~~ rx:P5/(?:(?i)a)b/ && $/), "ab", 're_tests 677/0 (861)');
is(("ab" ~~ rx:P5/((?i)a)b/ && $/), "ab", 're_tests 679/0 (863)');
is(("ab" ~~ rx:P5/((?i)a)b/ && $0), "a", 're_tests 679/1 (864)');
is(("Ab" ~~ rx:P5/(?:(?i)a)b/ && $/), "Ab", 're_tests 681/0 (867)');
is(("Ab" ~~ rx:P5/((?i)a)b/ && $/), "Ab", 're_tests 683/0 (869)');
is(("Ab" ~~ rx:P5/((?i)a)b/ && $0), "A", 're_tests 683/1 (870)');
ok((not ("aB" ~~ rx:P5/(?:(?i)a)b/)), 're_tests 685  (873)');
ok((not ("aB" ~~ rx:P5/((?i)a)b/)), 're_tests 687  (875)');
is(("ab" ~~ rx:P5/(?i:a)b/ && $/), "ab", 're_tests 689/0 (877)');
is(("ab" ~~ rx:P5/((?i:a))b/ && $/), "ab", 're_tests 691/0 (879)');
is(("ab" ~~ rx:P5/((?i:a))b/ && $0), "a", 're_tests 691/1 (880)');
is(("Ab" ~~ rx:P5/(?i:a)b/ && $/), "Ab", 're_tests 693/0 (883)');
is(("Ab" ~~ rx:P5/((?i:a))b/ && $/), "Ab", 're_tests 695/0 (885)');
is(("Ab" ~~ rx:P5/((?i:a))b/ && $0), "A", 're_tests 695/1 (886)');
ok((not ("aB" ~~ rx:P5/(?i:a)b/)), 're_tests 697  (889)');
ok((not ("aB" ~~ rx:P5/((?i:a))b/)), 're_tests 699  (891)');
is(("ab" ~~ rx:P5/(?i)(?:(?-i)a)b/ && $/), "ab", 're_tests 701/0 (893)');
is(("ab" ~~ rx:P5/(?i)((?-i)a)b/ && $/), "ab", 're_tests 702/0 (894)');
is(("ab" ~~ rx:P5/(?i)((?-i)a)b/ && $0), "a", 're_tests 702/1 (895)');
is(("aB" ~~ rx:P5/(?i)(?:(?-i)a)b/ && $/), "aB", 're_tests 703/0 (896)');
is(("aB" ~~ rx:P5/(?i)((?-i)a)b/ && $/), "aB", 're_tests 704/0 (897)');
is(("aB" ~~ rx:P5/(?i)((?-i)a)b/ && $0), "a", 're_tests 704/1 (898)');
ok((not ("Ab" ~~ rx:P5/(?i)(?:(?-i)a)b/)), 're_tests 705  (899)');
ok((not ("Ab" ~~ rx:P5/(?i)((?-i)a)b/)), 're_tests 706  (900)');
is(("aB" ~~ rx:P5/(?i)(?:(?-i)a)b/ && $/), "aB", 're_tests 707/0 (901)');
is(("aB" ~~ rx:P5/(?i)((?-i)a)b/ && $0), "a", 're_tests 708/1 (902)');
ok((not ("AB" ~~ rx:P5/(?i)(?:(?-i)a)b/)), 're_tests 709  (903)');
ok((not ("AB" ~~ rx:P5/(?i)((?-i)a)b/)), 're_tests 710  (904)');
is(("ab" ~~ rx:P5/(?i)(?-i:a)b/ && $/), "ab", 're_tests 711/0 (905)');
is(("ab" ~~ rx:P5/(?i)((?-i:a))b/ && $/), "ab", 're_tests 712/0 (906)');
is(("ab" ~~ rx:P5/(?i)((?-i:a))b/ && $0), "a", 're_tests 712/1 (907)');
is(("aB" ~~ rx:P5/(?i)(?-i:a)b/ && $/), "aB", 're_tests 713/0 (908)');
is(("aB" ~~ rx:P5/(?i)((?-i:a))b/ && $/), "aB", 're_tests 714/0 (909)');
is(("aB" ~~ rx:P5/(?i)((?-i:a))b/ && $0), "a", 're_tests 714/1 (910)');
ok((not ("Ab" ~~ rx:P5/(?i)(?-i:a)b/)), 're_tests 715  (911)');
ok((not ("Ab" ~~ rx:P5/(?i)((?-i:a))b/)), 're_tests 716  (912)');
is(("aB" ~~ rx:P5/(?i)(?-i:a)b/ && $/), "aB", 're_tests 717/0 (913)');
is(("aB" ~~ rx:P5/(?i)((?-i:a))b/ && $0), "a", 're_tests 718/1 (914)');
ok((not ("AB" ~~ rx:P5/(?i)(?-i:a)b/)), 're_tests 719  (915)');
ok((not ("AB" ~~ rx:P5/(?i)((?-i:a))b/)), 're_tests 720  (916)');
ok((not ("a\nB" ~~ rx:P5/(?i)((?-i:a.))b/)), 're_tests 721  (917)');
is(("a\nB" ~~ rx:P5/(?i)((?s-i:a.))b/ && $0), "a\n", 're_tests 722/1 (918)');
ok((not ("B\nB" ~~ rx:P5/(?i)((?s-i:a.))b/)), 're_tests 723  (919)');
is(("cabbbb" ~~ rx:P5/(?:c|d)(?:)(?:a(?:)(?:b)(?:b(?:))(?:b(?:)(?:b)))/ && $/), "cabbbb", 're_tests 724/0 (920)');
is(("caaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" ~~ rx:P5/(?:c|d)(?:)(?:aaaaaaaa(?:)(?:bbbbbbbb)(?:bbbbbbbb(?:))(?:bbbbbbbb(?:)(?:bbbbbbbb)))/ && $/), "caaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", 're_tests 726/0 (922)');
#?rakudo 2 todo "(?i) and backreferences"
is(("Ab4ab" ~~ rx:P5/(?i)(ab)\d\1/ && $0), "Ab", 're_tests 728/1 (924)');
is(("ab4Ab" ~~ rx:P5/(?i)(ab)\d\1/ && $0), "ab", 're_tests 730/1 (926)');
is(("foobar1234baz" ~~ rx:P5/foo\w*\d{4}baz/ && $/), "foobar1234baz", 're_tests 732/0 (928)');
is(("cabd" ~~ rx:P5/a(?{})b/ && $/), "ab", 're_tests 734/0 (930)');
is(("cabd" ~~ rx:P5/a(?{"\{"})b/ && $/), "ab", 're_tests 735/0 (931)');
ok(("x~~" ~~ rx:P5/x(~~)*(?:(?:F)?)?/), 're_tests 736  (932)');
is(("aaac" ~~ rx:P5/^a(?#xxx){3}c/ && $/), "aaac", 're_tests 738/0 (934)');
is(("aaac" ~~ rx:P5/(?x)^a (?#xxx) (?#yyy) {3}c/ && $/), "aaac", 're_tests 739/0 (935)');
ok((not ("dbcb" ~~ rx:P5/(?<![cd])b/)), 're_tests 740  (936)');
is(("dbaacb" ~~ rx:P5/(?<![cd])[ab]/ && $/), "a", 're_tests 742/0 (938)');
ok((not ("dbcb" ~~ rx:P5/(?<!(c|d))b/)), 're_tests 744  (940)');
is(("dbaacb" ~~ rx:P5/(?<!(c|d))[ab]/ && $/), "a", 're_tests 746/0 (942)');
is(("cdaccb" ~~ rx:P5/(?<!cd)[ab]/ && $/), "b", 're_tests 748/0 (944)');
#?rakudo skip "hangs"
ok((not ("a--" ~~ rx:P5/^(?:a?b?)*$/)), 're_tests 750  (946)');
is(("a\nb\nc\n" ~~ rx:P5/((?m)^b$)/ && $0), "b", 're_tests 752/1 (948)');
is(("a\nb\n" ~~ rx:P5/(?m)^b/ && $/), "b", 're_tests 753/0 (949)');
is(("a\nb\n" ~~ rx:P5/(?m)^(b)/ && $0), "b", 're_tests 754/1 (950)');
is(("a\nb\n" ~~ rx:P5/((?m)^b)/ && $0), "b", 're_tests 755/1 (951)');
is(("a\nb\n" ~~ rx:P5/\n((?m)^b)/ && $0), "b", 're_tests 756/1 (952)');
is(("a\nb\nc\n" ~~ rx:P5/((?s).)c(?!.)/ && $0), "\n", 're_tests 757/1 (953)');
is(("a\nb\nc\n" ~~ rx:P5/((?s)b.)c(?!.)/ && $0), "b\n", 're_tests 758/1 (954)');
ok((not ("a\nb\nc\n" ~~ rx:P5/^b/)), 're_tests 759  (955)');
ok((not ("a\nb\nc\n" ~~ rx:P5/()^b/)), 're_tests 761  (957)');

# vim: ft=perl6
