# May need review for v6.d. [6.d-REVIEW]
use experimental :collation;
use Test;
plan 14;
{
    my $*COLLATION = Collation.new;
    $*COLLATION.set(:!tertiary, :!quaternary);
    is-deeply 'a' coll 'A', Same, "!tertiary, !quaternary returns ‘Same’ for ‘a’ coll ‘A’";
}
subtest {
    plan 81;
    my @choices = -1, 0, 1;
    # 81 total possibilities
    for (@choices xx 4).flat.combinations(4).unique(:with(&[eqv])) -> @picked {
        my $*COLLATION = Collation.new;
        $*COLLATION.set(
            primary=>@picked[0],
            secondary=>@picked[1],
            tertiary => @picked[2],
            quaternary => @picked[3]
        );
        ok $*COLLATION.primary == @picked[0] &&
           $*COLLATION.secondary == @picked[1] &&
           $*COLLATION.tertiary == @picked[2],
           "\$*COLLATION.set(primary=>@picked[0],secondary=>@picked[1],tertiary => @picked[2],quaternary => @picked[3]";
    }
}
{
    my $*COLLATION = Collation.new;
    is-deeply 'a' coll 'b', Less, "a is less than b";
    is-deeply 'a' coll 'Z', Less, "a is less than Z";
    is-deeply "\c[woman facepalming]" coll "\c[man facepalming]", Less, "woman facepalming is less than man facepalming";
    is-deeply 'a' coll 'A', Less, "a is less than A";
    $*COLLATION.set(:tertiary(0), :quaternary(0));
    is-deeply 'a' coll 'A', Same, "-tertiary -quaternary a is Same as A";
    $*COLLATION = Collation.new.set(tertiary => -1);
    is-deeply 'a' coll 'A', More;
    is-deeply $*COLLATION.gist, "collation-level => 101, Country => International, Language => None, primary => 1, secondary => 1, tertiary => -1, quaternary => 1", 'gist';
}
{
    my $*COLLATION = Collation.new;
    $*COLLATION.set(:primary(0), :secondary(0), :tertiary(0), :quaternary(0));
    say $*COLLATION;
    my @a = <a A o b C c z Z>;
    is @a, @a.collate, "collation 0 for everything doesn't sort at all";
}
{
    my $*COLLATION = Collation.new;
    $*COLLATION.set(:primary(0), :secondary(0), :tertiary(0), :quaternary(-1));
    my @a = <a A o b C c z Z>;
    is @a.collate,  @a.sort.reverse, "collation 0 for everything doesn't sort at all";
    is 'a' coll 'A', Less;
    # 'a A o b C c z Z' 1
    # 'a A o b C c z Z' -1
}
{
    my $*COLLATION = Collation.new;
    is-deeply <a á A Á ó ø 1 z t ṫ>.collate, <1 a A á Á ó ø t ṫ z>, '<a á A Á ó ø 1 z t ṫ>.collate';
    $*COLLATION.set(secondary => -1, tertiary => -1);
    is-deeply <a á A Á ó ø 1 z t ṫ>.collate, <1 Á á A a ø ó ṫ t z>, '!secondary, !tertiary; <a á A Á ó ø 1 z t ṫ>.collate';
}
# TODO add test with "\c[woman facepalming]", "\c[man facepalming]"
