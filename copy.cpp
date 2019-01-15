#include <iostream>

int main() {
	int ch;
	for (;;) {
		ch = std::cin.get();
		if (ch == EOF) { break; }
		std::cout.put(ch);
	}
}
