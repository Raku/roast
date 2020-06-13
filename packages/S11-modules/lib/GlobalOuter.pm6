class GlobalOuter {
   method load() {
      require "GlobalInner.pm6";
      return ::('GlobalInner') !~~ Failure;
   }
}

# vim: expandtab sw=4
