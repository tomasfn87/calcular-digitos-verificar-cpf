#include <cctype>
#include <cstring>
#include <iostream>
#include <string>

using namespace std;

class Cpf {
    private:
        string cpf, completeCpf;

        void data() {
            cout << "- Data                 : \"" << cpf << "\"/\""
                << completeCpf << "\"" << endl;}

        void memAddressAndSize() {
            cout << "- MemAddress           : " << this << endl
                <<  "- PointerSize          : " << sizeof(this) << endl
                <<  "- ObjectSize           : " << sizeof(*this) << endl;}

        void testRemoveNonNumChars() {
            cout << "- testRemoveNonNumChars: \"" << removeNonNumChars(cpf)
                << "\"/\"" << removeNonNumChars(completeCpf) << "\"" << endl;}
    public:
        Cpf(string cpf="", string completeCpf=""):
            cpf(cpf), completeCpf(completeCpf) {}

        ~Cpf() {}

        string removeNonNumChars(string s) {
            string onlyNums;
            for (char c : s) {
                if (isdigit(c)) {
                    onlyNums += c;}}
            return onlyNums;}

        void testClass() {
            data();
            memAddressAndSize();
            testRemoveNonNumChars();}};

void demo(string option) {
    Cpf* cpf = new Cpf();
    cout << "Cpf()" << endl;
    cpf->testClass();
    if (option == "--delete-test") {
        cout << "- deleting " << "cpf" << endl;
        delete cpf;
        cpf = nullptr;}
    cout << endl;

    Cpf* cpf1 = new Cpf("test...1...2...3", "testing...1...2...3");
    cout << "Cpf(\"test...1...2...3\", \"testing...1...2...3\")" << endl;
    cpf1->testClass();
    if (option == "--delete-test") {
        cout << "- deleting " << "cpf1" << endl;
        delete cpf1;
        cpf1 = nullptr;}
    cout << endl;

    Cpf* cpf2 = new Cpf("111.444.777", "111.444.777-35");
    cout << "Cpf(\"111.444.777\", \"111.444.777-35\")" << endl;
    cpf2->testClass();}

int main(int argc, char* argv[]) {
    cout << "CLI args: " << endl;
    for (int i = 0; i < argc; i++) {
        cout << "- " << i+1 <<  ") " << argv[i] << endl;}
    cout << endl;

    string option1, option2;
    if (argc > 1)
        option1 = argv[1];
    if (argc > 2 && option1 == "--demo")
        option2 = argv[2];
    if (option1 == "--demo")
        demo(option2);
    return 0;}