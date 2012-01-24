use v6;
use Test;

sub throws_like($code, $ex_type, *%matcher) {
    my $msg;
    if $code ~~ Callable {
        $msg = 'code dies';
        $code()
    } else {
        $msg = "'$code' died";
        eval $code;
    }
    ok 0, $msg;
    skip 'Code did not die, can not check exception', 1 + %matcher.elems;
    CATCH {
        default {
            ok 1, $msg;
            my $type_ok = $_.WHAT === $ex_type;
            ok $type_ok , "right exception type ({$ex_type.^name})";
            if $type_ok {
                for %matcher.kv -> $k, $v {
                    my $got = $_."$k"();
                    my $ok = $got ~~ $v,;
                    ok $ok, ".$k matches $v";
                    unless $ok {
                        diag "Got:      $got\n"
                            ~"Expected: $v";

                    }
                }
            } else {
                diag "Got:      {$_.WHAT.gist}\n"
                    ~"Expected: {$ex_type.gist}";
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
throws_like '$^x',           X::Placeholder::Mainline, placeholder => '$^x';
throws_like 'sub f(*@a = 2) { }', X::Parameter::Default, how => 'slurpy';
throws_like 'sub f($x! = 3) { }', X::Parameter::Default, how => 'required';
throws_like 'sub f(:$x! = 3) { }', X::Parameter::Default, how => 'required';
throws_like 'sub f($:x) { }',  X::Parameter::Placeholder,
        parameter => '$:x',
        right     => ':$x';
throws_like 'sub f($?x) { }',  X::Parameter::Twigil,
        parameter => '$?x',
        twigil    => '?';
throws_like 'sub (Int Str $x) { }', X::Parameter::TypeConstraint;



throws_like 'my @a; my @a',  X::Redeclaration,      symbol => '@a';
throws_like 'sub a { }; sub a { }',X::Redeclaration, symbol => 'a', what => 'routine';
throws_like 'CATCH { }; CATCH { }', X::Phaser::Once, block => 'CATCH';

done;
