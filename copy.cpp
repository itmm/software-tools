#include <iostream>

int main() {
	for (;;) {
		int ch = std::cin.get();
		if (ch == EOF) { break; }
		std::cout.put(ch);
	}
}
