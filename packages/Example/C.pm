package Example::C {
    # snick in a test for RT #122896
    sub f () is cached is export { }
}
