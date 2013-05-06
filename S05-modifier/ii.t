use v6;
use Test;

plan 18;

#?pugs emit skip_rest("unimpl");
#?kp6 emit skip_rest("unimpl");

#L<S05/Modifiers/"The :ii">

#    target,      substution,   result
my @tests = (
    ['Hello',    'foo',         'Foo'],
    ['hEllo',    'foo',         'fOo'],
    ['A',        'foo',         'FOO'],
    ['AA',       'foo',         'FOO'],
    ['a b',      'FOO',         'fOo'],
    ['a b',      'FOOB',        'fOob'],
    ['Ab ',      'ABCDE',       'AbCDE'],
# someone with more spec-fu please check the next two tests:
    ['aB ',      'abcde',       'aBcde'],
    ['aB ',      'ABCDE',       'aBCDE'],

);

for @tests -> $t {
    my $test_str = $t[0];
    $test_str ~~ s:i:ii/ .* /$t[1]/;
    is $test_str, $t[2], ":ii modifier: {$t[0]} ~~ s:ii/.*/{$t[1]}/ => {$t[2]}";
}

#L<S05/Modifiers/"If the pattern is matched with :sigspace">

#    target,        substution,   result,         name
my @smart_tests = (
    ['HELLO',       'foo',         'FOO',         'uc()'],
    ['HE LO',       'foo',         'FOO',         'uc()'],
    ['hello',       'fOo',         'foo',         'lc()'],
    ['he lo',       'FOOOoO',      'fooooo',      'lc()'],
    ['He lo',       'FOOO',        'Fooo',        'ucfrst(lc())'],
    ['hE LO',       'fooo',        'fOOO',        'lcfrst(uc())'],
    ['hE LO',       'foobar',      'fOOBAR',      'lcfrst(uc())'],
    ['Ab Cd E',     'abc de gh i', 'Abc De Gh I', 'wordcase()'],
);

for @smart_tests -> $t {
    my $test_str = $t[0];
    $test_str ~~ s:i:ii:sigspace/.*/$t[1]/;
    # some of these tests actuall pass in Rakudo, so skipping them to avoid
    # too many passing TODOs
    #?rakudo skip 'some NYI'
    is $test_str, $t[2], ":i:ii:sigspace modifier: {$t[0]} ~~ s:ii:s/.*/{$t[1]}/ => {$t[2]}";
}

{
    $_ = 'Abc';
    s:ii/ab/xy/;
    is $_, 'Xyc', ':ii implies :i';
}

done;

# vim: syn=perl6 sw=4 ts=4 expandtab
