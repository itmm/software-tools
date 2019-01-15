#include <iostream>

int main() {
	int ch;
	int sum = 0;
	for (;;) {
		ch = std::cin.get();
		if (ch == EOF) { break; }
		if (ch == '\n') { ++sum; }
	}
	std::cout << sum << std::endl;
}
