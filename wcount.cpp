#include <iostream>

int main() {
	int ch;
	int sum = 0;
	bool inWord = false;
	for (;;) {
		ch = std::cin.get();
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
