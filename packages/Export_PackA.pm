use v6;

module t::spec::packages::Export_PackA {
  our sub exported_foo () is export {
    42;
  }
}
