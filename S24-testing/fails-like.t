use v6.d;
use Test;

plan 2;

sub check-test-fail (&test-to-run) {
    my $message = 'should fail';
    todo $message;
    nok test-to-run(), $message;
}

subtest 'Callable arg' => {
    plan 11;
    fails-like { sub { fail }() }, Exception;
    fails-like { sub { fail }() }, Exception, 'plain fail';
    fails-like {
        sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }()
    }, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail';

    check-test-fail {
        fails-like { sub { fail }().sink }, Exception, 'plain fail (thrown)'
    }
    check-test-fail {
        fails-like { (my $f := sub { fail }()).so; $f }, Exception,
          'plain fail (handled)'
    }
    check-test-fail {
        fails-like {
            sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }().sink
        }, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail (thrown)';
    }
    check-test-fail { fails-like { 42 }, 'non-Failure return' }
}

subtest 'Str arg' => {
    plan 11;
    fails-like ｢sub { fail }() ｣, Exception;
    fails-like ｢sub { fail }() ｣, Exception, 'plain fail';
    fails-like ｢
        sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }()
    ｣, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail';

    check-test-fail {
        fails-like ｢ sub { fail }().sink ｣, Exception, 'plain fail (thrown)'
    }
    check-test-fail {
        fails-like ｢ (my $f := sub { fail }()).so; $f ｣, Exception,
          'plain fail (handled)'
    }
    check-test-fail {
        fails-like ｢
            sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }().sink
        ｣, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail (thrown)';
    }
    check-test-fail { fails-like ｢ 42 ｣, 'non-Failure return' }
}
