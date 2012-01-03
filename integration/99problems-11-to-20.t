use v6;
use Test;
plan 25;

{
    # P11 (*) Modified run-length encoding.
    # 
    # Modify the result of problem P10 in such a way that if an element has no
    # duplicates it is simply copied into the result list. Only elements with
    # duplicates are transferred as (N E) lists.
    # 
    # Example:
    # * (encode-modified '(a a a a b c c a a d e e e e))
    # ((4 A) B (2 C) (2 A) D (4 E))
    
    sub encode (*@list)returns Array {
        my $count = 1;
        my (@encoded, $previous, $x);
        
        for @list {
            $x = $_;
            if $x eq $previous {
                $count++;
                next;
            }
            if defined $previous {
                @encoded.push( 1 == $count ?? $previous !! [$count, $previous]);
                $count = 1;
            }
            $previous = $x;
        }
        @encoded.push([$count, $x]);
        return @encoded;
    }
    is encode(<a a a a b c c a a d e e e e>),
        [ [<4 a>], 'b', [<2 c>], [<2 a>], 'd', [<4 e>] ],
        'We should be able to run-length encode lists';
}

{
    # P12 (**) Decode a run-length encoded list.
    # 
    # Given a run-length code list generated as specified in problem P11.
    # Construct its uncompressed version.
    
    sub decode(*@list) returns List {
        gather {
            for @list -> $elem {
                take $elem.isa(Array) ?? $elem[1] xx $elem[0] !! $elem;
            }
        }
    }
    is decode( [4, "a"], "b", [2, "c"], [2, "a"], "d", [4, "e"] ),
        <a a a a b c c a a d e e e e>,
        'We should be able to decode run-length encoded lists';
    
}

#?rakudo skip 'parse error'
{
    # P13 (**) Run-length encoding of a list (direct solution).
    # 
    # Implement the so-called run-length encoding data compression method directly.
    # I.e. don't explicitly create the sublists containing the duplicates, as in
    # problem P09, but only count them. As in problem P11, simplify the result list
    # by replacing the singleton lists (1 X) by X.
    # 
    # Example:
    # * (encode-direct '(a a a a b c c a a d e e e e))
    # ((4 A) B (2 C) (2 A) D (4 E))
    
    sub encode_direct {
        my @chars = @_;
        my $encoded;
        my $prev_ch = '';
        my $ch_cnt = 0;
        while (my $ch = @chars.shift) {
            if ($ch ~~ $prev_ch) {
                $ch_cnt++;
                # If it's the last char, add it.
                if (@chars.elems == 0) {
                    if ($ch_cnt != 1) {
                        $encoded ~= $ch_cnt;
                    }
                    $encoded ~= $ch;
                }
            }
            # the very first one..
            elsif ($prev_ch eq '') { 
                $ch_cnt++;
                # If it's the last char, add it.
                if (@chars.elems == 1) {
                    if ($ch_cnt != 1) {
                        $encoded ~= $ch_cnt;
                    }
                    $encoded ~= $ch;
                }
            }
            # not a match, but a new letter
            else {
                if ($ch_cnt != 1) {
                    $encoded ~= $ch_cnt;
                }
                $encoded ~= $prev_ch;
                $ch_cnt = 1;
            }
            $prev_ch = $ch;
        }
    
        return $encoded;
    }
    
    
    # Alternative solution
    
    sub encode_direct2(*@array is copy) returns Str {
        my ($packed, $count);
        while @array {
          if @array[0] eq @array[1] {
              $count++;
          }
          else {
              $packed ~=( $count ?? ($count+1) ~ @array[0] !! @array[0] );
              $count=0;
          }
          @array.shift;
        }
        return $packed;
    }
    
    is encode_direct(()),'', 'We should be able to encode_direct an empty list';
    #?niecza todo
    is encode_direct(<a>), 'a', '.. or a one-element iist';
    #?niecza todo
    is encode_direct(<a a>), '2a', '.. or a n-ary list with always same element';
    is encode_direct(<a a a a b c c a a d e e e e>),
        '4ab2c2ad4e',
        '.. or a generic list'; 
    is encode_direct2(()),'', 'We should be able to encode_direct2 an empty list';
    is encode_direct2(<a>), 'a', '.. or a one-element iist';
    is encode_direct2(<a a>), '2a', '.. or a n-ary list with always same element';
    is encode_direct2(<a a a a b c c a a d e e e e>),
        '4ab2c2ad4e',
        '.. or a generic list'; 
}

#?rakudo skip 'Null PMC access in isa()'
{
    # P14 (*) Duplicate the elements of a list.
    # 
    # Example:
    # * (dupli '(a b c c d))
    # (A A B B C C C C D D)
    
    is map({ $_ xx 2 }, <a b c c d>), <a a b b c c c c d d>,
        'We should be able to duplicate the elements of a list';
}

#?rakudo skip 'Null PMC access in isa()'
#?niecza skip 'Feed ops NYI'
{    
    my @result = eval '<a b c c d> ==> map { $_ xx 2 }';
    #?pugs todo 'feed ops'
    is @result, <a a b b c c c c d d>,
        'We should be able to duplicate the elements of a list';
}

{
    # P15 (**) Replicate the elements of a list a given number of times.
    # 
    # Example:
    # * (repli '(a b c) 3)
    # (A A A B B B C C C)
    
    sub repli (@list, Int $count) {
        return map { $_ xx $count }, @list;
    }
    is repli(<a b c>, 3), <a a a b b b c c c>,
        'We should be able to replicate array elements';
}

{
    # P16 (**) Drop every N'th element from a list.
    # 
    # Example:
    # * (drop '(a b c d e f g h i k) 3)
    # (A B D E G H K)
    
    sub drop(@list, Int $nth) {
        return map { @list[$_] }, grep { ($_+1) % $nth }, 0 .. @list.elems - 1;
    }
    is drop(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements';
    
    sub drop2(@list, Int $nth) {
        return map { @list[$_] if ($_+1) % $nth }, ^@list;
    }
    is drop2(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements based on if returning ()';
    
    sub drop3(@list, Int $nth) {
        gather for ^@list {
            take @list[$_] if ($_+1) % $nth;
        }
    }
    is drop3(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using gather';
    
    sub drop4(@list, Int $nth) {
        return (@list[$_] if ($_+1) % $nth) for ^@list;
    }
    #?rakudo skip 'infinite loop'
    #?niecza todo
    is drop4(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using (statement if) for';
    
    sub drop5(@list, Int $nth) {
        return @list[$_] if ($_+1) % $nth for ^@list;
    }
    #?rakudo skip 'infinite loop'
    #?niecza todo
    is drop5(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using list comprehension';
}

#?niecza skip 'Unable to resolve method splice in class Array'
{
    # P17 (*) Split a list into two parts; the length of the first part is given.
    # 
    # Do not use any predefined predicates.
    # 
    # Example:
    # * (split '(a b c d e f g h i k) 3)
    # ( (A B C) (D E F G H I K))
    
    sub splitter ( @array is copy, Int $length ) {
        my @head = @array.splice(0, $length);
        return (\@head, \@array);
    }
    my ( $a, $b ) = splitter(<a b c d e f g h i j k>, 3);
    is $a, <a b c>,
        'The first array in the split should be correct';
    is $b, <d e f g h i j k>, '... as should the second';
}

{
    # P18 (**) Extract a slice from a list.
    # 
    # Given two indices, I and K, the slice is the list containing the elements
    # between the I'th and K'th element of the original list 
    # (both limits included).
    # Start counting the elements with 1.
    # 
    # Example:
    # * (slice '(a b c d e f g h i k) 3 7)
    # (C D E F G)
    
    my @array = <a b c d e f g h i j k>;
    is @array[3..7], <d e f g h>, 'We should be able to slice lists';
}

{
    # P19 (**) Rotate a list N places to the left.
    # 
    # Examples:
    # * (rotate '(a b c d e f g h) 3)
    # (D E F G H A B C)
    # 
    # * (rotate '(a b c d e f g h) -2)
    # (G H A B C D E F)
    # 
    # Hint: Use the predefined functions length and append, as well as the result of
    # problem P17.
    
    sub rotate (Int $times is copy, *@list is copy) returns Array {
        if $times < 0 {
            $times += @list.elems;
        }
        @list.push: @list.shift for 1 .. $times;
        return @list;
    }
    is rotate(3, <a b c d e f g h>), <d e f g h a b c>,
        'We should be able to rotate lists forwards';
    is rotate(-2, <a b c d e f g h>), <g h a b c d e f>,
        '... and backwards';
}

#?niecza skip 'Unable to resolve method splice in class Array'
{
    # P20 (*) Remove the K'th element from a list.
    # 
    # Example:
    # * (remove-at '(a b c d) 2)
    # (A C D)
    
    my @array = <a b c d>;
    is @array.splice(1,1), <b>, 
        'We should be able to remove elements from a list';
    is @array, <a c d>, '... and have the correct list as the result';
}

# vim: ft=perl6
