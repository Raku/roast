use v6;
use Test;

# Tests of IO::Path.extension

my @tests = gather {
    constant $joiner = "\c[BLACK HEART SUIT]\c[ROMAN NUMERAL TEN]";
    sub prefix:<pIO> ($p) is looser(&[~]) { $p.IO }
    for ['foo', 'foo.txt.tar.gz'.IO], ['', '.txt.tar.gz'.IO] -> ($pre, $path) {
        %( :$path, :args(.key), :expected(.value) ).take for
            \(                               ) => 'gz',
            \(       :1parts                 ) => 'gz',
            \(       :parts(1..1)            ) => 'gz',
            \(       :parts(0..1)            ) => 'gz',
            \(       :2parts                 ) => 'tar.gz',
            \(       :parts(2..2)            ) => 'tar.gz',
            \(       :parts(0..2)            ) => 'tar.gz',
            \(       :3parts                 ) => 'txt.tar.gz',
            \(       :parts(3..3)            ) => 'txt.tar.gz',
            \(       :parts(0..3)            ) => 'txt.tar.gz',
            \(       :parts(0..9)            ) => 'txt.tar.gz',
            \(       :parts(0..∞)            ) => 'txt.tar.gz',
            \(       :parts(  ^∞)            ) => 'txt.tar.gz',
            \(       :parts(1^..^3)          ) => 'tar.gz',
            \(       :parts(1^..*)           ) => 'txt.tar.gz',
            \(       :parts(0..*)            ) => 'txt.tar.gz',
            \(       :4parts                 ) => '',
            \(       :parts(4..4)            ) => '',
            \(       :parts(3^..4)           ) => '',
            \(       :parts(2^..4)           ) => 'txt.tar.gz',
            \(       :parts(0..4)            ) => 'txt.tar.gz',
            \(       :0parts                 ) => '',
            \(       :parts(0..0)            ) => '',

            \(''                             ) => pIO "$pre.txt.tar",
            \('',    :1parts                 ) => pIO "$pre.txt.tar",
            \('',    :parts(1..1)            ) => pIO "$pre.txt.tar",
            \('',    :parts(0..1)            ) => pIO "$pre.txt.tar",
            \('',    :2parts                 ) => pIO "$pre.txt",
            \('',    :parts(2..2)            ) => pIO "$pre.txt",
            \('',    :parts(0..2)            ) => pIO "$pre.txt",
            \('',    :3parts                 ) => pIO ($pre||'.'),
            \('',    :parts(3..3)            ) => pIO ($pre||'.'),
            \('',    :parts(0..3)            ) => pIO ($pre||'.'),
            \('',    :parts(0..9)            ) => pIO ($pre||'.'),
            \('',    :parts(0..∞)            ) => pIO ($pre||'.'),
            \('',    :parts(0..*)            ) => pIO ($pre||'.'),
            \('',    :4parts                 ) => pIO "$pre.txt.tar.gz",
            \('',    :parts(4..4)            ) => pIO "$pre.txt.tar.gz",
            \('',    :parts(0..4)            ) => pIO ($pre||'.'),
            \('',    :0parts                 ) => pIO "$pre.txt.tar.gz",
            \('',    :parts(0..0)            ) => pIO "$pre.txt.tar.gz",

            \('BAR'                          ) => pIO "$pre.txt.tar.BAR",
            \('BAR', :1parts                 ) => pIO "$pre.txt.tar.BAR",
            \('BAR', :parts(1..1)            ) => pIO "$pre.txt.tar.BAR",
            \('BAR', :parts(0..1)            ) => pIO "$pre.txt.tar.BAR",
            \('BAR', :2parts                 ) => pIO "$pre.txt.BAR",
            \('BAR', :parts(2..2)            ) => pIO "$pre.txt.BAR",
            \('BAR', :parts(0..2)            ) => pIO "$pre.txt.BAR",
            \('BAR', :3parts                 ) => pIO "$pre.BAR",
            \('BAR', :parts(3..3)            ) => pIO "$pre.BAR",
            \('BAR', :parts(0..3)            ) => pIO "$pre.BAR",
            \('BAR', :parts(0..9)            ) => pIO "$pre.BAR",
            \('BAR', :parts(0..∞)            ) => pIO "$pre.BAR",
            \('BAR', :parts(0..*)            ) => pIO "$pre.BAR",
            \('BAR', :4parts                 ) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(4..4)            ) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(0..4)            ) => pIO "$pre.BAR",
            \('BAR', :0parts                 ) => pIO "$pre.txt.tar.gz.BAR",
            \('BAR', :parts(0..0)            ) => pIO "$pre.txt.tar.gz.BAR",

            \('BAR',               :joiner<_>) => pIO "$pre.txt.tar_BAR",
            \('BAR', :1parts,      :joiner<_>) => pIO "$pre.txt.tar_BAR",
            \('BAR', :parts(1..1), :joiner<_>) => pIO "$pre.txt.tar_BAR",
            \('BAR', :parts(0..1), :joiner<_>) => pIO "$pre.txt.tar_BAR",
            \('BAR', :2parts,      :joiner<_>) => pIO "$pre.txt_BAR",
            \('BAR', :parts(2..2), :joiner<_>) => pIO "$pre.txt_BAR",
            \('BAR', :parts(0..2), :joiner<_>) => pIO "$pre.txt_BAR",
            \('BAR', :3parts,      :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :parts(3..3), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :parts(0..3), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :parts(0..9), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :parts(0..∞), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :parts(0..*), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :4parts,      :joiner<_>) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(4..4), :joiner<_>) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(0..4), :joiner<_>) => pIO  $pre ~ '_BAR',
            \('BAR', :0parts,      :joiner<_>) => pIO "$pre.txt.tar.gz_BAR",
            \('BAR', :parts(0..0), :joiner<_>) => pIO "$pre.txt.tar.gz_BAR",

            \('',                  :joiner<_>) => pIO "$pre.txt.tar_",
            \('',    :1parts,      :joiner<_>) => pIO "$pre.txt.tar_",
            \('',    :parts(1..1), :joiner<_>) => pIO "$pre.txt.tar_",
            \('',    :parts(0..1), :joiner<_>) => pIO "$pre.txt.tar_",
            \('',    :2parts,      :joiner<_>) => pIO "$pre.txt_",
            \('',    :parts(2..2), :joiner<_>) => pIO "$pre.txt_",
            \('',    :parts(0..2), :joiner<_>) => pIO "$pre.txt_",
            \('',    :3parts,      :joiner<_>) => pIO  $pre ~ '_',
            \('',    :parts(3..3), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :parts(0..3), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :parts(0..9), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :parts(0..∞), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :parts(0..*), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :4parts,      :joiner<_>) => pIO "$pre.txt.tar.gz",
            \('',    :parts(4..4), :joiner<_>) => pIO "$pre.txt.tar.gz",
            \('',    :parts(0..4), :joiner<_>) => pIO  $pre ~ '_',
            \('',    :0parts,      :joiner<_>) => pIO "$pre.txt.tar.gz_",
            \('',    :parts(0..0), :joiner<_>) => pIO "$pre.txt.tar.gz_",

            \('BAR',               :$joiner ) => pIO "$pre.txt.tar{$joiner}BAR",
            \('BAR', :1parts,      :$joiner ) => pIO "$pre.txt.tar{$joiner}BAR",
            \('BAR', :parts(1..1), :$joiner ) => pIO "$pre.txt.tar{$joiner}BAR",
            \('BAR', :parts(0..1), :$joiner ) => pIO "$pre.txt.tar{$joiner}BAR",
            \('BAR', :2parts,      :$joiner ) => pIO "$pre.txt{$joiner}BAR",
            \('BAR', :parts(2..2), :$joiner ) => pIO "$pre.txt{$joiner}BAR",
            \('BAR', :parts(0..2), :$joiner ) => pIO "$pre.txt{$joiner}BAR",
            \('BAR', :3parts,      :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :parts(3..3), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :parts(0..3), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :parts(0..9), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :parts(0..∞), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :parts(0..*), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :4parts,      :$joiner ) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(4..4), :$joiner ) => pIO "$pre.txt.tar.gz",
            \('BAR', :parts(0..4), :$joiner ) => pIO "{$pre}{$joiner}BAR",
            \('BAR', :0parts,      :$joiner ) => pIO "$pre.txt.tar.gz{$joiner}BAR",
            \('BAR', :parts(0..0), :$joiner ) => pIO "$pre.txt.tar.gz{$joiner}BAR",

            \('',                  :$joiner  ) => pIO "$pre.txt.tar{$joiner}",
            \('',    :1parts,      :$joiner  ) => pIO "$pre.txt.tar{$joiner}",
            \('',    :parts(1..1), :$joiner  ) => pIO "$pre.txt.tar{$joiner}",
            \('',    :parts(0..1), :$joiner  ) => pIO "$pre.txt.tar{$joiner}",
            \('',    :2parts,      :$joiner  ) => pIO "$pre.txt{$joiner}",
            \('',    :parts(2..2), :$joiner  ) => pIO "$pre.txt{$joiner}",
            \('',    :parts(0..2), :$joiner  ) => pIO "$pre.txt{$joiner}",
            \('',    :3parts,      :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :parts(3..3), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :parts(0..3), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :parts(0..9), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :parts(0..∞), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :parts(0..*), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :4parts,      :$joiner  ) => pIO "$pre.txt.tar.gz",
            \('',    :parts(4..4), :$joiner  ) => pIO "$pre.txt.tar.gz",
            \('',    :parts(0..4), :$joiner  ) => pIO  $pre ~ $joiner,
            \('',    :0parts,      :$joiner  ) => pIO "$pre.txt.tar.gz{$joiner}",
            \('',    :parts(0..0), :$joiner  ) => pIO "$pre.txt.tar.gz{$joiner}"
        ;
    }

    %( <path args expected> Z=> $_ ).take for
        [ 'foo',                \('doc', :parts(0..3)), pIO 'foo.doc'     ],
        [ 'foo.txt',            \('doc', :parts(0..3)), pIO 'foo.doc'     ],
        [ 'foo.tar.gz',         \('doc', :parts(0..3)), pIO 'foo.doc'     ],
        [ 'foo.txt.tar.gz',     \('doc', :parts(0..3)), pIO 'foo.doc'     ],
        [ 'foo.txt.tar.gz.ace', \('doc', :parts(0..3)), pIO 'foo.txt.doc' ],

        [ '.',                  \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '.txt',               \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '.tar.gz',            \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '.txt.tar.gz',        \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '.txt.tar.gz.ace',    \('doc', :parts(0..3)), pIO '.txt.doc'    ],

        [ '..',                 \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '...',                \('doc', :parts(0..3)), pIO '.doc'        ],
        [ '....',               \('doc', :parts(0..3)), pIO '..doc'       ],

        [ 'a.b.c',              \(       :parts(2**64-1)), ''             ],
        [ 'a.b.c',              \(       :parts(2**65)  ), ''             ],
        [ 'a.b.c',              \('doc', :parts(2**64-1)), pIO 'a.b.c'    ],
        [ 'a.b.c',              \('doc', :parts(2**65)  ), pIO 'a.b.c'    ],

        # Empty-string extension
        [ 'a.', \(     ),     ''      ],
        [ 'a.', \('doc'), pIO 'a.doc' ],
}

plan 2 + @tests;

is-deeply .<path>.IO.extension(|.<args>), .<expected>,
    "'{.<path>}'.IO.extension {.<args>.perl}"
for @tests;

throws-like { "foo.txt".IO.extension: :parts('a'..'z') }, Exception,
  'using non-numeric Range as parts throws';
throws-like { "foo.txt".IO.extension: :parts(5..NaN) }, Exception,
  'using Range with NaN end point as parts throws';

# vim: ft=perl6
