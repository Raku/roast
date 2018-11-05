use v6.d;

module Export_PackB {
  use Export_PackA;

  our sub does_export_work () {
    try { exported_foo() } == 42;
  }
}
