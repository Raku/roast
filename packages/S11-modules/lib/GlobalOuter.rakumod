class GlobalOuter {
   method load() {
      require "GlobalInner.rakumod";
      return ::('GlobalInner') !~~ Failure;
   }
}

# vim: expandtab shiftwidth=4
