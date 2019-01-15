#include <iostream>

int main() {
	int sum = 0;
	for (;;) {
		int ch = std::cin.get();
		if (ch == EOF) { break; }
		if (ch == '\n') { ++sum; }
	}
	std::cout << sum << std::endl;
}
