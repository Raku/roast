use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

grammar JSON::Tiny::Grammar {
    token TOP       { \s* <value> \s* }
    rule object     { '{' ~ '}' <pairlist>     }
    rule pairlist   { <pair> * % \,            }
    rule pair       { <string> ':' <value>     }
    rule array      { '[' ~ ']' <arraylist>    }
    rule arraylist  {  <value> * % [ \, ]        }

    proto token value {*};
    token value:sym<number> {
	'-'?
	[ 0 | <[1..9]> <[0..9]>* ]
	[ \. <[0..9]>+ ]?
	[ <[eE]> [\+|\-]? <[0..9]>+ ]?
    }
    token value:sym<true>    { <sym>    };
    token value:sym<false>   { <sym>    };
    token value:sym<null>    { <sym>    };
    token value:sym<object>  { <object> };
    token value:sym<array>   { <array>  };
    token value:sym<string>  { <string> }

    token string { :ignoremark ('"') ~ \" [ <str> | \\ <str=.str_escape> ]* }
    token str { <-["\\\t\x[0A]]>+ }
    token str_escape { <["\\/bfnrt]> | 'u' <utf16_codepoint>+ % '\u' }
    token utf16_codepoint { <.xdigit>**4 }
}

# Tests for alternate exception handlers
plan 3;

sub json-ex ($code) {
    'use MONKEY-SEE-NO-EVAL; %*ENV<RAKU_EXCEPTIONS_HANDLER>="JSON";'
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

# https://github.com/Raku/old-issue-tracker/issues/5726
#?rakudo.js.browser skip "EVAL time use doesn't work in the browser"
#?rakudo.jvm todo 'X::CompUnit::UnsatisfiedDependency+{X::Comp}'
{
    is_run json-ex('use FakeModuleRT129810'), {
        :err({
            my $json = JSON::Tiny::Grammar.parse($_);
            my $exception = $json<value><object>;
            my $exception_obj = $exception<pairlist><pair>[0]<value><object>;
            my $specification = $exception_obj<pairlist><pair>
                .first(*<string><str> eq 'specification');
            my $short-name = $specification<value><string><str>.Str;
            $short-name eq 'FakeModuleRT129810';
        }),
        :out(''),
        :1status,
    }, 'using wrong module gives us a JSON error instead of crashing';
}

# vim: expandtab shiftwidth=4
