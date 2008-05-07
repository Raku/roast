use v6-alpha;

use Test;

plan 10;
#?rakudo 10 skip "can't parse"

# L<S29/Str/=item comb>

# comb Str
is "".comb, (), 'comb on empty string';
is "a bc d".comb, <a bc d>, 'default matcher and limit';

#?pugs todo 'feature'
is "a bc d".comb(:limit(2)), <a bc>, 'default matcher with supplied limit';

is_deeply @('split this string'.comb).map: { "$_" },
           <split this string>,
           q{Str.comb};

is "a ab bc ad ba".comb(m:Perl5/\ba\S*/), <a ab ad>,
    'match for any a* words';
is "a ab bc ad ba".comb(m:Perl5/\S*a\S*/), <a ab ad ba>,
    'match for any *a* words';

#?pugs todo 'feature'
is eval('"a ab bc ad ba".comb(m:Perl5/\S*a\S*/, 2)'), <a ab>,
    'matcher and limit';

is_deeply "forty-two".comb(/./),
           qw/f o r t y - t w o/,
           q{Str.comb(/./)};

is_deeply "forty two".comb(/./),
           (qw/f o r t y/, ' ', qw/t w o/),
           q{Str.comb(/./)};

# comb a list

#?pugs todo 'feature'
is eval('(<a ab>, <bc ad ba>).comb(m:Perl5/\S*a\S*/)'), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

# needed: captures in pattern return Match objects
