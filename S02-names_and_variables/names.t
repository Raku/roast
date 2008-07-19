use v6;

use Test;

plan 16;

# I'm using semi-random nouns for variable names since I'm tired of foo/bar/baz and alpha/beta/...

# L<S02/Names/>
# syn r14552

{
    my $mountain = 'Hill';
    $Terrain::mountain  = 108;
    $Terrain::Hill::mountain = 1024;
    $river = 'Terrain::Hill';
    is($mountain, 'Hill', 'basic variable name');
    is($Terrain::mountain, 108, 'variable name with package');
    is(Terrain::<$mountain>, 108, 'variable name with sigil not in front of package');
    is($Terrain::Hill::mountain, 1024, 'variable name with 2 deep package');
    is(Terrain::Hill::<$mountain>, 1024, 'varaible name with sigil not in front of 2 package levels deep');
    is($Terrain::($mountain)::mountain, 1024, 'variable name with a package name partially given by a variable ');
    is($($river)::mountain, 1024, 'variable name with package name completely given by variable');
}

{
    my $bear = 2.16;
    is($bear,       2.16, 'simple variable lookup');
    is($::{'bear'}, 2.16, 'variable lookup using $::{\'foo\'}');
    is(::{'$bear'}, 2.16, 'variable lookup using ::{\'$foo\'}');
    is($::<bear>,   2.16, 'variable lookup using $::<foo>');
    is(::<$bear>,   2.16, 'variable lookup using ::<$foo>');

    my $::<!@#$> =  2.22;
    is($::{'!@#$'}, 2.22, 'variable lookup using $::{\'symbols\'}');
    is(::{'$!@#$'}, 2.22, 'variable lookup using ::{\'$symbols\'}');
    is($::<!@#$>,   2.22, 'variable lookup using $::<symbols>');
    is(::<$!@#$>,   2.22, 'variable lookup using ::<$symbols>');
}
