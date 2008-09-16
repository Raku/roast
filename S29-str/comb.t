use v6;

use Test;

plan 12;

# L<S29/Str/=item comb>

# comb Str
#?rakudo 2 skip 'comb with default matcher'
is "".comb, (), 'comb on empty string';
is "a bc d".comb, <a bc d>, 'default matcher and limit';

#?pugs todo 'feature'
#?rakudo skip 'limit for comb'
is "a bc d".comb(:limit(2)), <a bc>, 'default matcher with supplied limit';

#?rakudo skip 'comb with default matcher'
{
    my @list =  ('split this string'.comb).map: { "$_" };
    is @list.join('|'), 'split|this|string', 'Str.comb';
}

#?rakudo skip 'm:Perl5/../'
{
    is "a ab bc ad ba".comb(m:Perl5/\ba\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(m:Perl5/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

{
    is "a ab bc ad ba".comb(/<< a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

#?pugs todo 'feature'
#?rakudo skip 'm:Perl5'
is eval('"a ab bc ad ba".comb(m:Perl5/\S*a\S*/, 2)'), <a ab>, 'matcher and limit';

is "forty-two".comb(/./).join('|'), 'f|o|r|t|y|-|t|w|o', q{Str.comb(/./)};

isa_ok("forty-two".comb(/./), List);

# comb a list

#?pugs todo 'feature'
#?rakudo skip 'm:Perl5'
is eval('(<a ab>, <bc ad ba>).comb(m:Perl5/\S*a\S*/)'), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

# needed: captures in pattern return Match objects
