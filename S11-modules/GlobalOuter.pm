class GlobalOuter {
   method load() {
      require "S11-modules/GlobalInner.pm";
      return ::('GlobalInner') !~~ Failure;
   }
}
