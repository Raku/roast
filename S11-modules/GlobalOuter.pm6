class GlobalOuter {
   method load() {
      require "S11-modules/GlobalInner.pm6";
      return ::('GlobalInner') !~~ Failure;
   }
}
