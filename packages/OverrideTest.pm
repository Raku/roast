module OverrideTest {
    sub test_ucfirst($y) is export(:DEFAULT) {
        ucfirst($y);
    }
}
