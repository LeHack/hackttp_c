#include "CppUTest/TestHarness.h"
#include <string.h>
#include <simple.h>

TEST_GROUP(SimpleTestGroup) {};

TEST(SimpleTestGroup, CheckOutput) {
	const char *output = get_hello_text();

	LONGS_EQUAL(15, strlen(output));
    STRCMP_EQUAL("Hello world10!\n", output);
}
