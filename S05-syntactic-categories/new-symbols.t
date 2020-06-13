use v6;
use MONKEY-TYPING;

use Test;
plan 8;

# L<S05/Syntactic categories/>

# https://github.com/Raku/old-issue-tracker/issues/4579
#?rakudo skip "RT #126142 - NYI"
{
    augment slang Regex {
        token backslash:sym<Y> { YY };
    }
    throws-like  '/foo \y/', Exception,
        'can not compile regex with unknown backslash rule';
    eval-lives-ok '/fuu \Y/', 'can compile a regex with new backslash rule';
    ok 'YY'  ~~ /^\Y$/, 'can use that rule (positive)';
    ok 'yX' !~~ /^\Y$/, 'can use that rule (negative)';
}
# https://github.com/Raku/old-issue-tracker/issues/4579
#?rakudo skip "RT #126142 - NYI"
throws-like '/\Y/', Exception, 'backslash rules are lexically scoped';

# https://github.com/Raku/old-issue-tracker/issues/4579
#?rakudo skip "RT #126142 - NYI"
{
    # nothing in the spec says that backslash rules need to be one char
    # only, and we have LTM after all
    # I feel so evil today... ;-)
    augment slang Regex {
        token backslash:<moep> { 'Hax' };
    }
    eval-lives-ok '/\moep/', 'can compile regex with multi char backslash rule';
    ok 'Haxe' ~~ m/^\moep/, '... it matches';
    ok 'Haxe' ~~ m/^\moepe$/, '... with correct end of escape sequence';
}

# vim: expandtab shiftwidth=4
