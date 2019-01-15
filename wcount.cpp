#include <iostream>

int main() {
	int sum = 0;
	bool inWord = false;
	for (;;) {
		int ch = std::cin.get();
		if (ch == EOF) { break; }
		if (ch <= ' ') {
			inWord = false;
		} else if (! inWord) {
			inWord = true;
			++sum;
		}
	}
	std::cout << sum << std::endl;
}
