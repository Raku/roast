use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 8;

sub output-has(Str:D $output, Int:D :$todos, Int:D :$fails, Int:D :$noks) {
    my $todos-actual = +$output.comb('TODO');
    my $fails-actual = +$output.comb('Failed');
    my $noks-actual  = +$output.comb('not ok');

    my $result = $todos == $todos-actual
              && $fails == $fails-actual
              && $noks  == $noks-actual;

    unless $result {
        diag qq:to/END/;
        TODOS: $todos|$todos-actual (expected|actual)
        FAILS: $fails|$fails-actual
        NOKS:  $noks|$noks-actual
        while testing `$output.perl()`
        END
    }
    $result
}

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { ok 0; }｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :2noks, :2fails, :2todos}, :0status
    }, 'case one';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { ok 1; }｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :0noks, :0fails, :1todos}, :0status
    }, 'case two';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { todo 1; ok 0; }｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :2noks, :2fails, :2todos}, :0status
    }, 'case three';

is_run ｢use Test; plan 1; subtest 'foos' => { todo 1; ok 0; }｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :1noks, :1fails, :1todos}, :0status
    }, 'case four';


is_run ｢use Test; plan 1; subtest 'foos' => { todo 1; ok 0; ok 0 }｣, {
        :err{.&output-has: :0noks, :2fails, :0todos},
        :out{.&output-has: :3noks, :1fails, :1todos}, :1status
    }, 'case five';

is_run ｢use Test; plan 1; todo 1; subtest 'foos' => { todo 1; ok 0; ok 0 }｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :3noks, :3fails, :3todos}, :0status
    }, 'case six';

is_run ｢use Test; plan 1; todo 1;
    subtest 'foos' => {
        todo 1;
        ok 0;
        subtest 'bars' => {
            plan 2;
            ok 0;
            subtest 'meows' => {
                ok 0;
            }
        }
    }
    ｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :6noks, :6fails, :6todos}, :0status
    }, 'case seven';

is_run ｢use Test; plan 1; todo 1;
    subtest 'foos' => {
        todo 1;
        ok 0;
        subtest 'bars' => {
            plan 2;
            todo 'bars', 2;
            ok 0;
            subtest 'meows' => {
                ok 0;
                todo 1;
                ok 1;
            }
        }
    }
    ｣, {
        :err{.&output-has: :0noks, :0fails, :0todos},
        :out{.&output-has: :6noks, :6fails, :7todos}, :0status
    }, 'case eight';
