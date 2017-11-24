use v6;

module packages::Export_PackB {
  use packages::Export_PackA;

  our sub does_export_work () {
    try { exported_foo() } == 42;
  }
}
