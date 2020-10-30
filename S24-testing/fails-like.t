use v6;
use Test;

plan 2;

sub check-test-fail (&test-to-run) is test-assertion {
    my $message = 'should fail';
    todo $message;
    nok test-to-run(), $message;
}

subtest 'Callable arg' => {
    plan 13;
    fails-like { sub { fail }() }, Exception;
    fails-like { sub { fail }() }, Exception, 'plain fail';
    fails-like {
        sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }()
    }, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail';

    fails-like {
        sub { fail X::Syntax::Reserved.new: :instead, :pos<bar> }()
    }, X::Syntax::Reserved, instead => * === True, 'whatever bool matcher';

    throws-like {
        fails-like {
            sub { fail X::Syntax::Reserved.new: :instead, :pos<bar> }()
        }, X::Syntax::Reserved, :instead;
    }, X::Match::Bool, message => *.contains('instead'), 'bool matcher throws';

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
    plan 13;
    fails-like ｢sub { fail }() ｣, Exception;
    fails-like ｢sub { fail }() ｣, Exception, 'plain fail';
    fails-like ｢
        sub { fail X::Syntax::Reserved.new: :instead<foo>, :pos<bar> }()
    ｣, X::Syntax::Reserved, :instead<foo>, :pos<bar>, 'typed fail';

    fails-like ｢
        sub { fail X::Syntax::Reserved.new: :instead, :pos<bar> }()
    ｣, X::Syntax::Reserved, instead => * === True, 'whatever bool matcher';

    throws-like {
        fails-like ｢
            sub { fail X::Syntax::Reserved.new: :instead, :pos<bar> }()
        ｣, X::Syntax::Reserved, :instead;
    }, X::Match::Bool, message => *.contains('instead'), 'bool matcher throws';

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

# vim: expandtab shiftwidth=4
