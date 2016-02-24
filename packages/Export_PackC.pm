use v6.c;

module t::spec::packages::Export_PackC {
  sub foo_packc () is export {
    1;
  }
}
