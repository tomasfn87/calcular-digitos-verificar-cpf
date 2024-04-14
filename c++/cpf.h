#ifndef HELLO_H
#define HELLO_H

#include <string>

class Sayer {
    private: std::string what, toWhom, punctuation;
    public:
        Sayer(
            std::string what = "Hello",
            std::string toWhom = "World",
            std::string punctuation = "!");
        ~Sayer();
        void hello();};

#endif
