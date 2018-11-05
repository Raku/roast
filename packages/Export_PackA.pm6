use v6.d;

module Export_PackA {
  our sub exported_foo () is export {
    42;
  }
}
