use v6.c;

module t::spec::packages::Export_PackD {
  sub this_gets_exported_lexically () is export {
    'moose!'
  }
}
