use v6.c;
use Test;

plan 8;

#L<S06/Placeholder variables/>

sub positional_slurpy {
    is @_[0],  1, "Leftover positional args get passed to @_ if present";
    is +@_, 1, 'one item filled into @_';
}

positional_slurpy(1);

sub named_slurpy {
    is %_<a>, 1, "Leftover named args get passed to %_ if present";
}

named_slurpy(:a(1));

sub both {
    is @_[1], 3, "Positional and named placeholder slurpies play well together";
    is %_<a>, 4, "Positional and named placeholder slurpies play well together";
    is @_[0], 5, "Positional and named placeholder slurpies play well together";
    is %_<b>, 6, "Positional and named placeholder slurpies play well together";
}

both(5, :b(6), 3, :a(4));

{
    my @result;
    sub perl5sub {
        push @result, @_[0];
        push @result, @_[1];
    }
    perl5sub(<foo bar>);
    is(@result, [<foo bar>], 'use @_ in sub');
}


# vim: syn=perl6
