use v6;

module t::spec::packages::Export_PackD {
  sub this_gets_exported_lexically () is export {
    'moose!'
  }
}
