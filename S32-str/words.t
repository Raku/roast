use v6;

use Test;

plan 4;

# L<S32::Str/Str/=item words>

# words on Str
is "".words, (), 'words on empty string';
is "a bc d".words, <a bc d>, 'default matcher and limit';
is " a bc d ".words, <a bc d>, 'default matcher and limit (leading/trailing ws)';

{
    my @list =  'split this string'.words;
    is @list.join('|'), 'split|this|string', 'Str.words';
}

