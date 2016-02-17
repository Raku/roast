class GlobalOuter {
   method load() {
      require "t/spec/S11-modules/GlobalInner.pm";
      return ::('GlobalInner') !~~ Failure;
   }
}
