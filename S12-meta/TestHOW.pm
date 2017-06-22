class TestHOW is Metamodel::ClassHOW {
  method add_method(Mu $obj, $name, $code)
  { callsame; }
}
my package EXPORTHOW {}
  EXPORTHOW::<class> = TestHOW;
