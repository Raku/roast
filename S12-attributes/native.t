use v6;

use Test;

plan 48;

class C {
    has int $.int-ro = 1;
    has num $.num-ro = 1e0;
    has str $.str-ro = 'vareniki';
    has int $.int-rw is rw = 1;
    has num $.num-rw is rw = 1e0;
    has str $.str-rw is rw = 'vareniki';

    method all-the-things() {
        "$!int-rw $!num-rw $!str-rw"
    }
}

{
    my $c = C.new;

    is $c.int-ro, 1, 'Can read ro int attr default value';
    is $c.num-ro, 1e0, 'Can read ro num attr default value';
    is $c.str-ro, 'vareniki', 'Can read ro str attr default value';

    dies-ok { $c.int-ro = 42 }, 'Cannot write to native int ro attr';
    dies-ok { $c.num-ro = 4.2e0 }, 'Cannot write to native num ro attr';
    dies-ok { $c.str-ro = 'karniyarik' }, 'Cannot write to native str ro attr';

    is $c.int-rw, 1, 'Can read rw int attr default value';
    is $c.num-rw, 1e0, 'Can read rw num attr default value';
    is $c.str-rw, 'vareniki', 'Can read rw str attr default value';

    lives-ok { $c.int-rw = 42 }, 'Can write to native int rw attr';
    lives-ok { $c.num-rw = 4.2e0 }, 'Can write to native num rw attr';
    lives-ok { $c.str-rw = 'karniyarik' }, 'Can write to native str rw attr';

    is $c.int-rw, 42, 'Can read back rw int attr changed value';
    is $c.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $c.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $c.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';

    dies-ok { $c.int-rw = 4.2e0 }, 'Cannot update int rw attr with non-int (1)';
    dies-ok { $c.int-rw = 'karniyarik' }, 'Cannot update int rw attr with non-int (2)';
    dies-ok { $c.num-rw = 42 }, 'Cannot update num rw attr with non-num (1)';
    dies-ok { $c.num-rw = 'karniyarik' }, 'Cannot update num rw attr with non-num (2)';
    dies-ok { $c.str-rw = 42 }, 'Cannot update str rw attr with non-str (1)';
    dies-ok { $c.str-rw = 4.2e0 }, 'Cannot update str rw attr with non-str (2)';
}

{
    my $c = C.new(
        int-ro => 2, num-ro => 2e0, str-ro => 'pelmeni',
        int-rw => 3, num-rw => 3e0, str-rw => 'kofte'
    );

    is $c.int-ro, 2, 'Can read ro int attr value from constructor';
    is $c.num-ro, 2e0, 'Can read ro num attr value from constructor';
    is $c.str-ro, 'pelmeni', 'Can read ro str attr value from constructor';

    is $c.int-rw, 3, 'Can read rw int attr value from constructor';
    is $c.num-rw, 3e0, 'Can read rw num attr value from constructor';
    is $c.str-rw, 'kofte', 'Can read rw str attr value from constructor';

    lives-ok { $c.int-rw = 42 }, 'Can write to native int rw attr set by constructor';
    lives-ok { $c.num-rw = 4.2e0 }, 'Can write to native num rw attr set by constructor';
    lives-ok { $c.str-rw = 'karniyarik' }, 'Can write to native str rw attr set by constructor';

    is $c.int-rw, 42, 'Can read back rw int attr changed value';
    is $c.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $c.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $c.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';
}

class NoTwigilNatives {
    has int $int-rw = 1;
    has num $num-rw = 1.2e0;
    has str $str-rw = 'vareniki';

    method set-int(int $value) {
        $int-rw = $value;
    }

    method set-num(num $value) {
        $num-rw = $value;
    }

    method set-str(str $value) {
        $str-rw = $value;
    }

    method all-the-things() {
        "$int-rw $num-rw $str-rw"
    }
}

{
    my $ntn = NoTwigilNatives.new;

    is $ntn.all-the-things, '1 1.2 vareniki', 'Non-twigil native attr defaults work';

    lives-ok { $ntn.set-int(42) }, 'Can set non-twigil native int attr';
    is $ntn.all-the-things, '42 1.2 vareniki', 'The update took effect';

    lives-ok { $ntn.set-num(4.2e0) }, 'Can set non-twigil native num attr';
    is $ntn.all-the-things, '42 4.2 vareniki', 'The update took effect';

    lives-ok { $ntn.set-str('draniki') }, 'Can set non-twigil native str attr';
    is $ntn.all-the-things, '42 4.2 draniki', 'The update took effect';
}

throws-like { EVAL 'class Warfare { has int $a; say $a }' }, X::Syntax::NoSelf;

# RT #127548
class MV {
    has uint64 $.start;
    method s { if $!start { 5 } }
}
is MV.new(start => 42).start, 42, 'uint64 native attribute accessor works';
is MV.new(start => 4).s, 5, 'uint64 native attribute use in method works';

# RT #131122
{
    my class C1 {
        has uint8 $.ff;
    }
    my $c = C1.new(ff => 255);
#?rakudo.moar todo 'RT #131122'
    is $c.ff, 255, 'large unsigned ints';

    my class C2 is repr('CStruct') {
        has uint8 $.ff is rw;
    }

    my $c2 = C2.new;
    $c2.ff = 100;
    is $c2.ff, 100, 'unsigned int sanity';
    $c2.ff = 200;
#?rakudo todo 'RT #131122'
    is $c2.ff, 200, 'large unsigned ints';
}
