use v6;

module Export_PackD {
  sub this_gets_exported_lexically () is export {
    'moose!'
  }
}

# vim: expandtab shiftwidth=4
