use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# Tests for alternate exception handler Exceptions::JSON
plan 3;

sub json-ex ($code) {
    'use MONKEY-SEE-NO-EVAL; %*ENV<RAKUDO_EXCEPTIONS_HANDLER>="JSON";'
        ~ 'EVAL q|' ~ $code.subst(:g, '|', '\|') ~ '|;'
}

is_run json-ex('class X::Foo is Exception {}.new.throw'), {
    :err(/'"X::Foo"' .+ 'message' .+ 'null'/),
    :out(''),
    :1status,
}, 'can handle exception without `message` method';

is_run json-ex('justsomerandomsyntaxerror'), {
    :err(/'"X::Undeclared::Symbols"' .+ 'justsomerandomsyntaxerror'/),
    :out(''),
    :1status,
}, 'can handle X::Undeclared::Symbols exception';

{ # RT#129810
    is_run json-ex('use FakeModuleRT129810'), {
        :err(/'"X::CompUnit::UnsatisfiedDependency"' .+ 'FakeModuleRT129810'/),
        :out(''),
        :1status,
    }, 'using wrong module gives us a JSON error instead of crashing';
}

# vim: ft=perl6
