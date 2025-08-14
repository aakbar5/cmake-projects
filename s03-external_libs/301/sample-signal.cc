#include <boost/signals2.hpp>
#include <iostream>

using namespace boost::signals2;

int main()
{
  signal<void()> s;
  s.connect([]{ std::cout << "Boost.Signal:: Hello, world!\n"; });
  s();
}