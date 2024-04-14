#include <iostream>
#include <string>

using namespace std;

class Sayer {
    private: string what, toWhom, punctuation;
    public:
        Sayer(
            string what = "Hello",
            string toWhom = "World",
            string punctuation = "!"):
                what(what), toWhom(toWhom), punctuation(punctuation) {}
        ~Sayer() {}
        void hello() {
            cout << what << ", " << toWhom << punctuation << endl;}};

int main() {
    // no args
    Sayer* h =  new Sayer;
    h->hello();
    delete h;
    //  1 arg
    Sayer* h1 = new Sayer("Stop spinning");
    h1->hello();
    delete h1;
    //  2 args
    Sayer* h2 = new Sayer("There's nothing to worry about", "buddy");
    h2->hello();
    delete h2;
    //  3 args
    Sayer* h3 = new Sayer("Please listen", "my friend", "...");
    h3->hello();
    return 0;}
