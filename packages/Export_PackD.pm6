use v6.d;

module Export_PackD {
  sub this_gets_exported_lexically () is export {
    'moose!'
  }
}
