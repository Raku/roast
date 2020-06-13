use v6;
use Test;

my @tests = 4, '5', 6e0, 7.0, DateTime.now, Duration.new(42), now,
    Date.today, '.'.IO, class Foo {}.new;

plan 3 + 2*@tests + 4;

for @tests {
    is-deeply .minpairs, (0 => $_,).Seq, .^name ~ '.minpairs';
    is-deeply .maxpairs, (0 => $_,).Seq, .^name ~ '.maxpairs';
}

is-deeply (<a b c>, 4e0, '5', 6.0).maxpairs,
    (0 => ("a", "b", "c"),).Seq, 'maxpairs on a List of mixed types';
is-deeply (<a b c>, 4e0, '5', 6.0).minpairs,
    (1 => 4e0,).Seq, 'minpairs on a List of mixed types';

# https://irclog.perlgeek.de/perl6-dev/2017-03-22#i_14307973
subtest 'Setty.maxpairs/.minpairs' => {
    plan 2;

    my class Foo does Setty {
        multi method pairs { 42 }
    }

    is-deeply Foo.new.maxpairs, 42, 'Setty.maxpairs returns .pairs';
    is-deeply Foo.new.minpairs, 42, 'Setty.minpairs returns .pairs';
}

# https://stackoverflow.com/questions/53692604/perl-6-maxpairs-warns-about-stringification-of-undefined-values
{
    my @a;
    @a[2,3,4,6] = <foo bar foo bar>;
    {
        my $failed;
        CONTROL { $failed = True }
        is-deeply @a.maxpairs, (2 => "foo", 4 => "foo").Seq,
          'maxpairs on sparse';
        nok $failed, 'maxpairs should not have warned';
    }
    {
        my $failed;
        CONTROL { $failed = True }
        is-deeply @a.minpairs, (3 => "bar", 6 => "bar").Seq,
          'minpairs on sparse';
        nok $failed, 'minpairs should not have warned';
    }
}

# vim: expandtab shiftwidth=4
