use v6;

use Test;

plan 35;

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

    dies_ok { $c.int-ro = 42 }, 'Cannot write to native int ro attr';
    dies_ok { $c.num-ro = 4.2e0 }, 'Cannot write to native num ro attr';
    dies_ok { $c.str-ro = 'karniyarik' }, 'Cannot write to native str ro attr';

    is $c.int-rw, 1, 'Can read rw int attr default value';
    is $c.num-rw, 1e0, 'Can read rw num attr default value';
    is $c.str-rw, 'vareniki', 'Can read rw str attr default value';

    lives_ok { $c.int-rw = 42 }, 'Can write to native int rw attr';
    lives_ok { $c.num-rw = 4.2e0 }, 'Can write to native num rw attr';
    lives_ok { $c.str-rw = 'karniyarik' }, 'Can write to native str rw attr';

    is $c.int-rw, 42, 'Can read back rw int attr changed value';
    is $c.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $c.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $c.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';

    dies_ok { $c.int-rw = 4.2e0 }, 'Cannot update int rw attr with non-int (1)';
    dies_ok { $c.int-rw = 'karniyarik' }, 'Cannot update int rw attr with non-int (2)';
    dies_ok { $c.num-rw = 42 }, 'Cannot update num rw attr with non-num (1)';
    dies_ok { $c.num-rw = 'karniyarik' }, 'Cannot update num rw attr with non-num (2)';
    dies_ok { $c.str-rw = 42 }, 'Cannot update str rw attr with non-str (1)';
    dies_ok { $c.str-rw = 4.2e0 }, 'Cannot update str rw attr with non-str (2)';
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

    lives_ok { $c.int-rw = 42 }, 'Can write to native int rw attr set by constructor';
    lives_ok { $c.num-rw = 4.2e0 }, 'Can write to native num rw attr set by constructor';
    lives_ok { $c.str-rw = 'karniyarik' }, 'Can write to native str rw attr set by constructor';

    is $c.int-rw, 42, 'Can read back rw int attr changed value';
    is $c.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $c.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $c.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';
}
