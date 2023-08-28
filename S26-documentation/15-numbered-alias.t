use Test;

# Test implementation of S26 :numbered alias ('#') for abbreviated,
# paragraph, and delimited blocks.

plan 1;

my $tnum = 0;
my $p = -1;
my $o;

# abbreviated blocks ==========================================
subtest ':numbered alias abbreviated blocks' => {

plan 19;

=para # foo
info

$o = $=pod[++$p]; sayo($o);

=defn # foo
info

$o = $=pod[++$p]; sayo($o, :defn);

=line # foo
info

$o = $=pod[++$p]; sayo($o);

=head # foo
info

$o = $=pod[++$p]; sayo($o);

=code # foo
info

$o = $=pod[++$p]; sayo($o);

=input # foo
info

$o = $=pod[++$p]; sayo($o);

=output # foo
info

$o = $=pod[++$p]; sayo($o);

=table # foo
info

$o = $=pod[++$p]; sayo($o);

=Foo # foo
info

$o = $=pod[++$p]; sayo($o);

}

#===============================================
sub sayo($o, :$defn) is test-assertion {
    is $o.config<numbered>:exists, True, 'is config<numbered>:exists';
    ok $o.config<numbered>, 'ok config<numbered>';
    if $defn {
       is $o.term, 'foo', 'is term "foo"';
    }
    else {
         #isa-ok $o.contents[0], 'Str', 'foo info';
    }
}

# vim: expandtab shiftwidth=4
