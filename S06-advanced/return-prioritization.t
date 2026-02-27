use Test;

{
    my $val = 0;
    sub s1a() {
        LEAVE $val = 7;
        return 1;
    }

    is s1a(), 1, "LEAVE doesn't impair explicit return value";
    is $val, 7, "LEAVE phaser runs";
}

{
    my $val = 0;
    sub s2a(&code) {
        LEAVE $val = 7;
        code();
    }
    sub s2b() {
        s2a({
            return 1;
        });
    }
    is s2b(), 1, "LEAVE doesn't impair explicit return value (nested return)";
    is $val, 7, "LEAVE phaser runs (nested return)";
}

{
    sub s3a() {
        LEAVE return 1;
        return 0;
    }
    is s3a(), 1, "LEAVE can overwrite return value with a return";
}

#?rakudo skip 'Non-local return from callback through LEAVE is not implemented'
{
    my $val = 0;
    sub s4a(&code) {
        LEAVE return 2;
        code();
    }
    sub s4b(&code) {
        s4a(&code);
        $val = 1;
    }
    sub s4c() {
        s4b({
            return 1;
        });
        return 0;
    }
    is s4c(), 1, "LEAVE with return in other lexical scope can't interrupt return";
    is $val, 0, "LEAVE won't hijack outer returns unwind.";
}

{
    sub s5a() {
        LEAVE return 1;
        0;
    }
    is s5a(), 1, "LEAVE can overwrite implicit return value with a return";
}

#?rakudo skip 'Return from LEAVE in dead code callback path is not implemented'
{
    sub s6a(&code) {
        return 0;
        LEAVE {
            code()
        }
    }

    sub s6b() {
        s6a({
            return 1;
        });
        return 2;
    }

    is s6b(), 1, "Return in LEAVE in different lexical scope returns";
}

#?rakudo skip 'Return crossing lexical scopes from callback is not implemented'
{
    my $val;
    sub s7a() {
        return 5;
    }
    sub s7b(&code) {
        code();
        LEAVE {
            $val = s7a;
        }
    }

    sub s7c() {
        s7b({ return 1 });
        return 2;
    }

    is s7c(), 1, "Return is uninterrupted by returns in LEAVE blocks in other scopes";
    is $val, 5, "Return in LEAVE blocks can run as usual";
}

done-testing;
