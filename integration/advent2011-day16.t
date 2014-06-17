# http://perl6advent.wordpress.com/2011/12/16/where-have-all-the-references-gone/
use v6;
use Test;
plan 11;

class My::Class {
     # attribute with accessor (indicated by the dot)
     # and default value
    has $.foo = 5;

    method new() {
        # the * specifies the storage, and means "default storage"
        pass 'new method called';
        self.bless();
    }
}
 # use it:
is My::Class.new.foo, 5, 'new object';

my @a = (1, 2);
my @b = (3, 4);

{
    temp @a;
    push @a, @b;
    is_deeply @a, [1, 2, 3, 4], 'automatic list flattening';
}

{
    temp @a;
    my $temp = @b;
    push @a, $temp;  # does not flatten the two items in $temp,
                     # because $temp is a scalar

    is_deeply @a, [1, 2, [3, 4]], 'item non-flattening';
}

{
    temp @a;
    push @a, $(@b);
    is_deeply @a, [1, 2, [3, 4]], 'item non-flattening';
}

{
    temp @a;
    push @a, item @b;
    is_deeply @a, [1, 2, [3, 4]], 'item non-flattening';
}

{
    my @a = 1, 2;
    my $scalar = @a;
    
    is +(gather for @a { 
        # two iterations
        take 1;
    }), 2, 'for @a { }';

    is +(gather for $scalar {
        # one iteration only
        take 1;
         }), 1, 'for $scalar { }';

    is +(gather for @$scalar {
        # two iterations again
        take 1;
         }), 2, 'for @$scalar { }';
}

{
    my @a = 1, 2, 3, 4, 5;
    my @b = 10, 20, 30;
    @a[3] = @b;
    is_deeply @a, [1, 2, 3, [10, 20, 30], 5], 'item context';
}

sub set_five($x is rw) {
     # no dereferencing
    $x = 5;
}
my $var;
 # no explicit reference taking
set_five $var;
is $var, 5,'reference taking';
