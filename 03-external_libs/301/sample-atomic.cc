#include <boost/atomic.hpp>
#include <thread>
#include <iostream>

boost::atomic<int> a{0};
void thread()
{
  a.fetch_add(1, boost::memory_order_relaxed);
}

int main(int argc, char *argv[]) {
    std::cout << "CMAKE Boost -- Hello world" << std::endl;
    std::cout << " - App is built using " << BUILD_TYPE << std::endl;

    std::thread t1{thread};
    std::thread t2{thread};
    t1.join();
    t2.join();
    std::cout << a << '\n';
    
    (void)argc;
    (void)argv;

    return 0;
}
