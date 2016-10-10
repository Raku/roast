use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# Tests for alternate exception handler Exceptions::JSON
plan 1;

sub json-ex ($code) {
    'use MONKEY-SEE-NO-EVAL; %*ENV<RAKUDO_EXCEPTIONS_HANDLER>="JSON";'
        ~ 'EVAL "' ~ $code.subst(:g, '"', '\"') ~ '";'
}

{ # RT#129810
    is_run json-ex('use FakeModuleRT129810'), {
        :err(/'"X::CompUnit::UnsatisfiedDependency"' .+ 'FakeModuleRT129810'/),
        :out(''),
        :1status,
    }, 'using wrong module gives us a JSON error instead of crashing';
}

# vim: ft=perl6
