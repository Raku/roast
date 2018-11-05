use v6.d;
module OverrideTest {
    sub test_tc($y) is export(:DEFAULT) {
        tc($y);
    }
}
