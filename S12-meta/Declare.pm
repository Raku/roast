role Controller {
}

my package EXPORTHOW {
    class DECLARE::controller is Metamodel::ClassHOW {
        method compose(Mu $type) {
            self.add_role($type, Controller);
            callsame;
        }
    }
}
