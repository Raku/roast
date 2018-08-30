use v6;

module packages::Export_PackA {
  our sub exported_foo () is export {
    42;
  }
}
