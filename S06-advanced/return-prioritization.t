use Test;

{
    my $val = 0;
    sub s() {
        LEAVE $val = 7;
        return 1;
    }

    is s(), 1, "LEAVE doesn't impair explicit return value";
    is $val, 7, "LEAVE phaser runs";
}

{
    my $val = 0;
    sub s(&code) {
        LEAVE $val = 7;
        code();
    }
    sub s2() {
        s({
            return 1;
        });
    }
    is s2(), 1, "LEAVE doesn't impair explicit return value (nested return)";
    is $val, 7, "LEAVE phaser runs (nested return)";
}

{
    sub s() {
        LEAVE return 1;
        return 0;
    }
    is s(), 1, "LEAVE can overwrite return value with a return";
}

{
    my $val = 0;
    sub s(&code) {
        LEAVE return 2;
        code();
    }
    sub s2(&code) {
        s(&code);
        $val = 1;
    }
    sub s3() {
        s2({
            return 1;
        });
        return 0;
    }
    is s3(), 1, "LEAVE with return in other lexical scope can't interrupt return";
    is $val, 0, "LEAVE won't hijack outer returns unwind.";
}

{
    sub s() {
        LEAVE return 1;
        0;
    }
    is s(), 1, "LEAVE can overwrite implicit return value with a return";
}

{
    sub s(&code) {
        return 0;
        LEAVE {
            code()
        }
    }

    sub s2() {
        s({
            return 1;
        });
        return 2;
    }

    is s2(), 1, "Return in LEAVE in different lexical scope returns";
}

{
    my $val;
    sub s() {
        return 5;
    }
    sub s1(&code) {
        code();
        LEAVE {
            $val = s;
        }
    }

    sub s2() {
        s1({ return 1 });
        return 2;
    }

    is s2(), 1, "Return is uninterrupted by returns in LEAVE blocks in other scopes";
    is $val, 5, "Return in LEAVE blocks can run as usual";
}
