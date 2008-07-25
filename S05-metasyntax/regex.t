use v6;
use Test;

plan 11;

# L<S05/Regexes are now first-class language, not strings>

eval_dies_ok('qr/foo/', 'qr// is gone');

#?rakudo 2 skip 'rx// syntax not implemented'
isa_ok(rx/oo/, Regex);
isa_ok(rx (o), Regex);
eval_dies_ok('rx(o)', 'rx () whitespace if the delims are parens');
#?rakudo todo 'regex {} does not make a Regex object'
isa_ok(regex {oo}, Regex);

eval_dies_ok('rx :foo:', 'colons are not allowed as rx delimiters');

#?rakudo todo 'my $var = /foo/ does not make a Regex object'
{
    my $var = /foo/;
    isa_ok($var, Regex, '$var = /foo/ returns a Regex object');
}

#?rakudo skip 'my $match = m{oo} does not match on $_'
{
    $_ = 'foo';
    my $match = m{oo};
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

#?rakudo skip 'my $match = m/oo/ parsefail'
{

    $_ = 'foo';
    my $match = m/oo/;
    is($match, 'oo', 'm{} always matches instead of making a Regex object');
}

# we'll just check that this syntax is valid for now
{
    lives_ok({token foo {bar}}, 'token foo {...} is valid');
    lives_ok({regex baz {qux}}, 'regex foo {...} is valid');
}
