use v6;
unit module Test::Misc;

# routines used by:
#   S26-documentation/12-non-breaking-space.t
#   S32-str/space-chars.t

sub int2hexstr($int, :$plain --> Str) is export(:int2hexstr) {
    # Given an int, convert it to a hex string
    if !$plain {
        return sprintf("0x%04X", $int);
    }
    else {
        return sprintf("%X", $int);
    }
}

sub show-space-chars($str --> Str) is export(:show-space-chars) {
    # Given a string with space chars, return a version with the hex
    # code shown for them and place a pipe separating all chars in the
    # original string.
    my @c = $str.comb;
    my $new-str = '';
    for @c -> $c {
        $new-str ~= '|' if $new-str;
        if $c ~~ /\s/ {
            my $int = $c.ord;
            my $hex-str = int2hexstr($int);
            $new-str ~= $hex-str;
        }
        else {
            my $int = $c.ord;
            my $hex-str = int2hexstr($int, :plain);
            $new-str ~= $hex-str;
        }
    }
    return $new-str;
}
