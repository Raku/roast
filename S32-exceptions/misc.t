use v6;
use Test;

#?DOES 3
sub throws_like($code, $ex_type, *%matcher) {
    if $code ~~ Callable {
        $code()
    } else {
        eval $code;
    }
    ok 0, 'code died';
    skip 'Code did not die, can not check exception', 1 + %matcher.elems;
    CATCH {
        default {
            ok 1, 'code died';
            ok $_.WHAT === $ex_type , "right exception type ({$ex_type.^name})";
            for %matcher.kv -> $k, $v {
                ok $_."$k"() ~~ $v, " .$k matches $v";
            }
        }
    }
}

throws_like { Buf.new().Str }, X::Buf::AsStr, method => 'Str';
throws_like 'class Foo { $!bar }', X::Attribute::Undeclared,
            name => '$!bar', package-name => 'Foo';
throws_like 'sub f() { $^x }', X::Signature::Placeholder,
            line => 1;

done;
