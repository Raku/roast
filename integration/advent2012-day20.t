# http://perl6advent.wordpress.com/2012/12/20/day-20-dynamic-variables-and-dsl-y-things/

use v6;
use Test;
plan 2;

my @piles =
    [0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 0, 1, 1, 0, 1],
    [1, 1, 1, 1, 0, 0, 0, 0, 1];

sub nim-svg(@piles) {
    my $width = max map *.elems, @piles;
    my $height = @piles.elems;

    my @elements = gather for @piles.kv -> $row, @pile {
        for @pile.kv -> $column, $is_filled {
            if $is_filled {
                take 'circle' => [
                    :cx($column + 0.5),
                    :cy($row + 0.5),
                    :r(0.4)
                ];
            }
        }
    }
    
##    say SVG.serialize('svg' => [ :$width, :$height, @elements ]);
    return [ :$width, :$height, @elements ];
}

my $svg-serialize-input = ["width" => 9, "height" => 3, "circle" => ["cx" => 8.5, "cy" => 0.5, "r" => 0.4], "circle" => ["cx" => 0.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 1.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 2.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 3.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 5.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 6.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 8.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 0.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 1.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 2.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 3.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 8.5, "cy" => 2.5, "r" => 0.4]];

is_deeply nim-svg(@piles), $svg-serialize-input ;

sub nim(&block) {
    my @*piles;
    my @*current-pile;

    &block();
    finish-last-pile();
    
    nim-svg(@*piles);
}

sub _(@rest?) {
    unless @rest {
        finish-last-pile();
    }
    @*current-pile = 0, @rest;
    return @*current-pile;
}

sub o(@rest?) {
    unless @rest {
        finish-last-pile();
    }
    @*current-pile = 1, @rest;
    return @*current-pile;
}

sub finish-last-pile() {
    if @*current-pile {
        push @*piles, [@*current-pile];
    }
    @*current-pile = ();
}

my $dsl-y = nim {
    _ _ _ _ _ _ _ _ o;
    o o o o _ o o _ o;
    o o o o _ _ _ _ o;
};

is_deeply $dsl-y, $svg-serialize-input ;


