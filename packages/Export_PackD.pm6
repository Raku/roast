use v6;

module packages::Export_PackD {
  sub this_gets_exported_lexically () is export {
    'moose!'
  }
}
