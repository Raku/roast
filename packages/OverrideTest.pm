use v6.c;
module OverrideTest {
    sub test_tc($y) is export(:DEFAULT) {
        tc($y);
    }
}
