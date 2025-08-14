#include <boost/regex.hpp>
#include <string>
#include <iostream>

int main()
{
  std::string s = "Boost Libraries";
  boost::regex expr{"\\w+\\s\\w+"};
  std::cout << "Boost.Regex:: " << std::boolalpha << boost::regex_match(s, expr) << '\n';
}
