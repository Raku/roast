use v6.c;

module t::spec::packages::Export_PackB {
  use t::spec::packages::Export_PackA;

  sub does_export_work () {
    try { exported_foo() } == 42;
  }
}
