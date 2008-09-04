use Test;

# This is specific to rakudo, and SOOO ugly. I will say no more than that,
# otherwise I could spend days ranting about how stupid this all is --moritz

my $contents = slurp('t/spec/S05-mass/pge_tests');
my @lines = split("\n", $contents);
@lines = grep { .substr(0, 1) ne '#' }, @lines;
@lines = grep { .chars > 2 }, @lines;
plan +@lines;
my $count = +@lines;

my $count = 0;
my $skip = any(92, 108, 109, 118, 122 .. 128, 156 .. 161, 
        213 .. 225, 241, 243, 245, 254 .. 260, 265 .. 280,
        411, 445, 447, 449, 467, 472,
);

my $todo = any( 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
        58, 59, 60, 61, 62, 63, 66, 67, 68, 69, 70, 71, 91, 119, 121, 135, 
        138, 150, 155, 162, 163, 164, 165, 166, 182, 196, 197, 198, 201, 208,
        212, 227, 229, 231, 281, 284, 285, 288, 289, 296, 298, 299, 306, 308,
        309, 316, 318, 319, 326, 451, 459, 470, 471, 477, 478, 480, 481, 482,
        483, 484, 485, 486, 487, 489, 490, 492, 493, 494, 496, 497, 498, 499,
        500, 501, 502, 503, 504, 505, 507, 508, 510, 511, 512, 514, 515, 516,
        517, 518, 519, 520, 521, 522, 523, 525, 526, 528, 529, 530, 532, 533,
        534, 535, 536, 537, 538, 539, 540, 541, 543, 544, 546, 547, 548, 550,
        551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 564, 565, 566,
        568, 569, 570, 571, 572, 575, 576, 
);

my $segfault_limit = 500;
do_tests($segfault_limit);
my $remaining = @lines - $segfault_limit;

skip($remaining, 'Tests would segfault :(');


sub do_tests ($segfault_limit) {
    for @lines -> $line {
        $count++;
        if $count > $segfault_limit {
            return;
        }
        my @st = split("\t", $line);
        # weed out empty fields, since we can't split on \t+ yet
        my @s;
        for @st {
            @s.push($_) if .chars > 0;
        }
        my $regex   =  @s[0];
        my $teststr =  @s[1];
        $teststr    = '' if $teststr eq "''";
        my $match   = (@s[2] eq 'y');
        my $descr   =  @s[3];
        if ( $count == $skip ) {
            skip(1, "parse/match failure");
        } else {
#        diag "matching '$regex' against '$teststr' with expected result '$match'";
            todo("unkown") if $count == $todo;
            my $result  =  eval "'$teststr' ~~ /$regex/";
            ok !($result xor $match), $descr;
        }
    }
}

# vim: ft=perl6
