#include <iostream>

int main() {
	int sum = 0;
	for (;;) {
		if (std::cin.get() == EOF) {
			break;
		}
		++sum;
	}
	std::cout << sum << std::endl;
}
