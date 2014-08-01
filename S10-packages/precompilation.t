use Test;

plan 1;

# RT #76456
{
    my $cur  = CompUnitRepo::Local::File.new("t/spec/packages");
    my ($cu) = $cur.candidates('RT76456');
    ok $cu.precomp(:force), 'precompiled a parameterized role';
    unlink $cu.precomp-path if $cu.precomp-path.IO.e;
}
