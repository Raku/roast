use v6;
use Test;
plan 2;

class Widget {
    has $.name;
    subset PosReal of Real where * >= 0;
    subset Size where {   .does(PosReal)
		       or .does(Callable) and .signature ~~ :(PosReal --> PosReal)
		       or .does(Whatever) or .does(WhateverCode) };

    has Size $.size is rw;
    has Widget @.sub-widgets;

    method compute-layout($remaining-space? is copy, $unspecified-size? is copy) {
        $remaining-space //= $!size;

        if @!sub-widgets == 0 {  # Terminal
            my $computed-size = do given $!size {
                when Real     { $_                  };
                when Callable { .($remaining-space) };
                when Whatever { $unspecified-size   };
            }

            self.draw($computed-size);
        }
        else {  # Container
            my @static-sizes   =  grep Real,     @!sub-widgets».size;
            my @dynamic-sizes  =  grep Callable, @!sub-widgets».size;
            my $nb-unspecified = +grep Whatever, @!sub-widgets».size;

            $remaining-space -= [+] @static-sizes;

            $unspecified-size = ([-] $remaining-space, @dynamic-sizes».($remaining-space))
                                 / $nb-unspecified;

            .compute-layout($remaining-space, $unspecified-size) for @!sub-widgets;
        }
    }

    method draw(Real $size is copy) {
        take "+{'-' x 25}+";
        take "$!name ($size lines)".fmt("| %-23s |");
        take "|{' ' x 25}|" while --$size > 0;
    }
}

my $interface =
    Widget.new(name => 'interface', size => 11, sub-widgets => (
        Widget.new(name => 'menu bar', size => 1),
        Widget.new(name => 'main part', size => *, sub-widgets => (
            Widget.new(name => 'subpart 1', size => * / 3),
            Widget.new(name => 'subpart 2', size => *))),
        Widget.new(name => 'status bar', size => 1)));

my @drawing = gather { $interface.compute-layout; }; # Draw
is_deeply @drawing, [q:to"END_LAYOUT_1".lines], 'initial layout';
+-------------------------+
| menu bar (1 lines)      |
+-------------------------+
| subpart 1 (3 lines)     |
|                         |
|                         |
+-------------------------+
| subpart 2 (6 lines)     |
|                         |
|                         |
|                         |
|                         |
|                         |
+-------------------------+
| status bar (1 lines)    |
END_LAYOUT_1

$interface.size += 3;       # Resize
@drawing = gather { $interface.compute-layout }; # Redraw
is_deeply @drawing, [q:to"END_LAYOUT_2".lines], 'resized layout';
+-------------------------+
| menu bar (1 lines)      |
+-------------------------+
| subpart 1 (4 lines)     |
|                         |
|                         |
|                         |
+-------------------------+
| subpart 2 (8 lines)     |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
+-------------------------+
| status bar (1 lines)    |
END_LAYOUT_2
