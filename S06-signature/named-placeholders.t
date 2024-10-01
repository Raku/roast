use Test;

plan 4;

#L<S06/Placeholder variables/>

sub one_placeholder is test-assertion {
    is $:bla,  2, "A single named placeholder works";
}

one_placeholder(:bla(2));

sub two_placeholders is test-assertion {
    is $:b, 1, "Named dispatch isn't broken for placeholders";
    is $:a, 2, "Named dispatch isn't broken for placeholders";
}

two_placeholders(:a(2), :b(1));

# https://github.com/rakudo/rakudo/issues/1356
{
    use isms 'Perl5';
    { is-deeply $:F, 42, 'named placeholder $:F ok' }(:42F)
}

# vim: expandtab shiftwidth=4
