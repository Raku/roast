use v6.c;
unit module Test::Assuming;

# Convenience subs for testing priming/currying

use Test;

sub is-primed-sig (Block $b, Signature $s, Capture |cap) is export {

    my $r = $b.assuming(|cap);
    my $res = $r.signature.perl;
    my $tname = 'Priming ' ~ $b.signature.perl ~ ' with ' ~ cap.perl ~ ' gave ' ~ $s.perl;
    if $res eq $s.perl and not $r.can('Failure') {
        pass($tname);
        return;
    }
    my $diag1;
    my $diag2;
    unless $res eq $s.perl {
        $diag1 = "Got $res instead";
    }
    if $r.can('Failure') {
        $r.Failure.defined;
        $diag2 = "Binding primers failed with: " ~ $r.Failure.gist;
    }
    ok(0,$tname);
    diag $diag1 if $diag1;
    diag $diag2 if $diag2;
}

sub priming-fails-bind-ok (Block $b, $symbol, $expected, Capture |cap) is export {
    my $thrown;
    my $r;
    try {
        $r = $b.assuming(|cap);
        CATCH { default { $_.defined; $thrown = $_; } }
    };
    my $expected_s = $expected;
    $expected_s //= $expected.^name;
    # We will eventually throw everything rather than mix it in.
    # If we get throws, pretend they are mixed in for now.
    $r = $r but Failure.new($thrown) if $thrown ~~ Exception;
    my $why = "";
    if not $r.can('Failure') {
        $why = "No Failure mixed in\n";
    }
    elsif $r.Failure.exception !~~ X::TypeCheck::Binding|X::AdHoc {
        $why = 'Wrong X:: subtype ' ~ $r.Failure.exception.WHAT.perl;
    }
    elsif $r.Failure.exception ~~ X::TypeCheck::Binding and $r.Failure.exception.expected !=== $expected {
        $why = "Wrong expected type { $r.Failure.exception.expected.perl } reported";
    }
    elsif $r.Failure.exception ~~ X::TypeCheck::Binding and $r.Failure.exception.symbol ne $symbol {
        $why = "Wrong symbol { $r.Failure.exception.symbol } reported";
    }
    elsif $r.Failure.exception ~~ X::AdHoc and $r.Failure.exception.payload !~~ rx:s[$expected_s] {
        $why = 'Wrong AdHoc Message: ' ~ $r.Failure.exception.payload;
    }

    my $tname = "Priming { $b.signature.perl } with { cap.perl } mixed in a Failure ";
    if ($why) {
        ok(0,$tname);
    } else {
        pass($tname);
        return;
    }
    if not $r.can('Failure') {
    }
    elsif $r.Failure.exception ~~ X::AdHoc {
        diag "expected $expected_s";
    } else {
        diag "because $symbol !~~ $expected_s";
    }
    diag $why;
}

sub is-primed-call (Block $b, \call, @expect, Capture |cap) is export {

    my $r = $b.assuming(|cap);
    my $res = $r.signature.perl;
    my @res;
    my @got;
    my $why;

    my $tname =  "&" ~ $b.name ~ ".assuming(" ~ cap.values.perl ~ ")(" ~ call.values.perl ~ ") returned expected value { @expect.perl }";

    if $r.can('Failure') or (@got = $r(|call)) !eqv @expect {
        ok(0,$tname);
        if $r.can('Failure') {
            $r.Failure.defined;
            diag "Saw this Failure mixed in: " ~ $r.Failure.gist;
        }
        if @got eqv @expect {
            diag "Result looked otherwise correct\n";
        }
        else {
            diag "Got { @got.perl } instead";
        }
    }
    else {
        pass($tname);
    }
}
