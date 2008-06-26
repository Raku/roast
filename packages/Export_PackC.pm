use v6;

module t::spec::packages::Export_PackC {
  sub foo_packc () is export {
    1;
  }
}
