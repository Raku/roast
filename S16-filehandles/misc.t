use v6;
use lib 't/spec/packages';

use Test;
use Test::Util;

plan 2;

# RT#126487
{
    is_run 'say $*IN.words.unique',
        'cat dog cat dog bird dog Snake snake Snake',
        { out => "(cat dog bird Snake snake)\n", err => '', :0status },
    '$*IN.words.unique with no new line at the end must NOT hang';
}

# RT#121149
{
    is_run 'say $*IN.get', 'Hello, World!',
        { out => "Hello, World!\n", err => '', status => 0 },
        '.get from $*IN works correctly';

}
