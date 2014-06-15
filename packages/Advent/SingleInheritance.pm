my class SingleInheritanceClassHOW
    is Metamodel::ClassHOW
{
    method add_parent(Mu $obj, Mu $parent) {
        if +self.parents($obj, :local) > 0 {
            die "Multiple inheritance is forbidden!";
        }
        callsame;
    }
}
my module EXPORTHOW { }
EXPORTHOW.WHO.<class> = SingleInheritanceClassHOW;
