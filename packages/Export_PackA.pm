use v6.c;

module t::spec::packages::Export_PackA {
  our sub exported_foo () is export {
    42;
  }
}
