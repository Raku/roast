use v6;
use Test;
plan 22;

{
    # P01 (*) Find the last box of a list.
    # 
    # Example:
    # * (my-last '(a b c d))
    # (D)

    is <a b c d>.[*-1], 'd', 'Find the last box of a list.';

    sub my_last (@xs) {
        return @xs[*-1];
    }

    is my_last(<a b c d>), 'd', 'Find the last box of a list via func.';
}

{
    # P02 (*) Find the last but one box of a list.
    # 
    # Example:
    # * (my-but-last '(a b c d))
    # (C D)
    
    is <a b c d>[*-2, *-1], <c d>,
        'We should be able to grab the last two items from a list';
    
    sub my_but_last (@xs) {
        return @xs[*-2,*-1];
    }
    
    is my_but_last(<a b c d>), <c d>,
        'We should be able to grab the last two items from a list by func';
}

{
    # P03 (*) Find the K'th element of a list.
    # 
    # The first element in the list is number 1.
    # Example:
    # * (element-at '(a b c d e) 3)
    # C
    
    is <a b c d e>[3], 'd', 'We should be able to index into lists';
    my @array = <a b c d e>;
    is @array[3], 'd', '... and arrays';
    
    sub element_at (@xs, $pos) {
        return @xs[$pos];
    }
   
    is element_at(<a b c d e>, 3), 'd',
        'We should be able to index into lists by func';
    is element_at(@array, 3), 'd', '... and arrays by func';
    
}

{
    # P04 (*) Find the number of elements of a list.

    is <a b c d e>.elems, 5, 'We should be able to count the items in a list';
    my @array = <a b c d e>;
    is @array.elems, 5, '... and arrays';
}

#?niecza skip 'Unable to resolve method reverse in class Parcel'
{
    # P05 (*) Reverse a list.

    is <a b c d e>.reverse, <e d c b a>, 
        'We should be able to reverse a list';
    my @array = <a b c d e>;
    is @array.reverse, <e d c b a>, '... and arrays';
}

{
    # P06 (*) Find out whether a list is a palindrome.
    # 
    # A palindrome can be read forward or backward; e.g. (x a m a x).
    
    my @list = < a b c d e >;
    isnt @list.reverse, @list, "<a b c d e> is not a palindrome";
    
    @list = < a b c b a >;
    is @list.reverse, @list, "<a b c b a> is a palindrome";
}

{
    # P07 (**) Flatten a nested list structure.
    # 
    # 
    # Transform a list, possibly holding lists as elements into a `flat' list by
    # replacing each list with its elements (recursively).
    # 
    # Example:
    # * (my-flatten '(a (b (c d) e)))
    # (A B C D E)
    # 
    # Hint: Use the predefined functions list and append.
    
    my $flatten = { $_ ~~ List ?? ( map $flatten, @($_) ) !! $_ }; 
    my @flattened = map $flatten, ('a', ['b', ['c', 'd', 'e']]);
    is @flattened, <a b c d e>, 'We should be able to flatten lists';
    
    # XXX this doesn't work that way...
    sub my_flatten (@xs) {
        sub inner_flatten (*@xs) { return @xs; }
    
        return inner_flatten(@xs);
    }
    
    is my_flatten( ('a', ['b', ['c', 'd', 'e']]) ), <a b c d e>,
        'We should be able to flatten lists by func';
}

{
    # P08 (**) Eliminate consecutive duplicates of list elements.
    # 
    # 
    # If a list contains repeated elements they should be replaced with a single
    # copy of the element. The order of the elements should not be changed.
    # 
    # Example:
    # * (compress '(a a a a b c c a a d e e e e))
    # (A B C A D E)
    
    # parens required in the assignment.  See http://perlmonks.org/?node=587242
    my $compress = sub ($x) {
        state $previous;
        return $x ne $previous ?? ($previous = $x) !! ();
    }
    my @compressed = map $compress, <a a a a b c c a a d e e e e>;
    #?niecza todo
    is @compressed, <a b c a d e>, 'We should be able to compress lists';
}

{
    multi compress2 () { () }
    multi compress2 ($a) { $a }
    multi compress2 ($x, $y, *@xs) { $x xx ($x !=== $y), compress2($y, |@xs) }
    
    my @x = <a a a a b c c a a d e e e e>;
    is compress2(|@x), <a b c a d e>, '... even with multi subs';
}

{
    # P09 (**) Pack consecutive duplicates of list elements into sublists.
    # 
    # If a list contains repeated elements they should be placed in separate sublists.
    # 
    # Example:
    # * (pack '(a a a a b c c a a d e e e e))
    # ((A A A A) (B) (C C) (A A) (D) (E E E E))
    
    sub pack (*@array is copy) returns Array {
        my (@list, @packed);
        while @array {
            @list.push(@array.shift) while !@list || @list[0] eq @array[0];
            @packed.push([@list]);
            @list = ();
        }
        return @packed;
    }
    
    #?rakudo todo 'unknown'
    is pack(<a a a a b c c a a d e e e e>).join('+'),
        '<a a a a+b+c c+a a+d+e e e e',
        'We should be able to pack lists';
    
    # From Larry, http://perlmonks.org/?node_id=590147
    sub group (*@array is copy) {
        gather {
            while @array {
                take [ 
                    gather {
                        my $h = shift @array;
                        take $h;
                        while @array and $h eq @array[0] {
                            take shift @array;
                        }
                    }
                ];
            }
        }
    }
    is group(<a a a a b c c a a d e e e e>),
        [ [<a a a a>], [<b>], [<c c>], [<a a>], [<d>], [<e e e e>] ],
        '... even using gather/take';
}
#?rakudo skip 'groupless gather/take'
#?niecza skip 'Unable to resolve method reverse in class Parcel'
{    
    sub group2 (*@array is copy) {
        gather while @array {
            take [ 
                my $h = shift @array,
                gather while @array and $h eq @array[0] {
                    take shift @array;
                }
            ];
        }
    }
    is group2(<a a a a b c c a a d e e e e>).join('+'),
        'a a a a+b+c c+a a+d+e e e e',
        '... even using blockless gather/take';
    
}

{
    # P10 (*) Run-length encoding of a list.
    # 
    # 
    # Use the result of problem P09 to implement the so-called run-length encoding
    # data compression method. Consecutive duplicates of elements are encoded as
    # lists (N E) where N is the number of duplicates of the element E.
    # 
    # Example:
    # * (encode '(a a a a b c c a a d e e e e))
    # ((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
    
    sub encode (*@list) {
        my $count = 1;
        my ( @encoded, $previous, $x );
        
        for @list {
            $x = $_;
            if $x eq $previous {
                $count++;
                next;
            }
            if defined $previous {
                @encoded.push([$count, $previous]);
                $count = 1;
            }
            $previous = $x;
        }
        @encoded.push([$count, $x]);
        return @encoded;
    }
    
    #?rakudo todo 'unknown'
    is encode(<a a a a b c c a a d e e e e>).join('+'),
        '4 a+1 b+2 c+2 a+1 d+4 e',
        'We should be able to run-length encode lists';
}

# vim: ft=perl6
