use v6;
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
        sub { fail X::Str::Subst::Adverb.new: :name<foo>, :got<bar> }()
    }, X::Str::Subst::Adverb, :name<foo>, :got<bar>, 'typed fail';

    check-test-fail {
        fails-like { sub { fail }().sink }, Exception, 'plain fail (thrown)'
    }
    check-test-fail {
        fails-like { (my $f := sub { fail }()).so; $f }, Exception,
          'plain fail (handled)'
    }
    check-test-fail {
        fails-like {
            sub { fail X::Str::Subst::Adverb.new: :name<foo>, :got<bar> }().sink
        }, X::Str::Subst::Adverb, :name<foo>, :got<bar>, 'typed fail (thrown)';
    }
    check-test-fail { fails-like { 42 }, 'non-Failure return' }
}

subtest 'Str arg' => {
    plan 11;
    fails-like ｢sub { fail }() ｣, Exception;
    fails-like ｢sub { fail }() ｣, Exception, 'plain fail';
    fails-like ｢
        sub { fail X::Str::Subst::Adverb.new: :name<foo>, :got<bar> }()
    ｣, X::Str::Subst::Adverb, :name<foo>, :got<bar>, 'typed fail';

    check-test-fail {
        fails-like ｢ sub { fail }().sink ｣, Exception, 'plain fail (thrown)'
    }
    check-test-fail {
        fails-like ｢ (my $f := sub { fail }()).so; $f ｣, Exception,
          'plain fail (handled)'
    }
    check-test-fail {
        fails-like ｢
            sub { fail X::Str::Subst::Adverb.new: :name<foo>, :got<bar> }().sink
        ｣, X::Str::Subst::Adverb, :name<foo>, :got<bar>, 'typed fail (thrown)';
    }
    check-test-fail { fails-like ｢ 42 ｣, 'non-Failure return' }
}
