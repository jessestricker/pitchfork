#include <cstdlib>
#include <iostream>

#include <utils/helper.hpp>
#include <utils/utils.hpp>

int main() {
  std::cout << utils::get_greeting() << '\n';

  if (utils::get_answer() == 42) {
    return EXIT_SUCCESS;
  } else {
    return EXIT_FAILURE;
  }
}
