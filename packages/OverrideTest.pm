use v6;
module OverrideTest {
    sub test_tc($y) is export(:DEFAULT) {
        tc($y);
    }
}
