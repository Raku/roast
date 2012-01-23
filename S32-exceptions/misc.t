use v6;
use Test;

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
            my $type_ok = $_.WHAT === $ex_type;
            ok $type_ok , "right exception type ({$ex_type.^name})";
            if $type_ok {
                for %matcher.kv -> $k, $v {
                    ok $_."$k"() ~~ $v, " .$k matches $v";
                }
            } else {
                skip 'wrong exception type', %matcher.elems;
            }
        }
    }
}

throws_like { Buf.new().Str }, X::Buf::AsStr, method => 'Str';
throws_like 'class Foo { $!bar }', X::Attribute::Undeclared,
            name => '$!bar', package-name => 'Foo';
throws_like 'sub f() { $^x }', X::Signature::Placeholder,
            line => 1;

#?rakudo skip 'parsing of $& and other p5 variables'
throws_like '$&', X::Obsolete, old => '$@ variable', new => '$/ or $()';

throws_like 'do    { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws_like 'do    { @_  }', X::Placeholder::Block, placeholder => '@_';
throws_like 'class { $^x }', X::Placeholder::Block, placeholder => '$^x';
throws_like 'my @a; my @a',  X::Redeclaration,      symbol      => '@a';

done;
