#include <cctype>
#include <cstring>
#include <iostream>
#include <string>

using namespace std;

class Cpf {
    private:
        string cpf, completeCpf;
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
 
        void data() {
            cout << "- Data                 : \"" << cpf << "\"/\"";
            cout << completeCpf << "\"" << endl;}
 
        void testRemoveNonNumChars() {
            cout << "- testRemoveNonNumChars: \"" << removeNonNumChars(cpf);
            cout << "\"/\"" << removeNonNumChars(completeCpf) << "\"";
            cout << endl;}};

void demo(string option) {
    Cpf* cpf = new Cpf();
    cout << "Cpf()" << endl;
    cpf->data();
    cout << "- MemAddress           : " << cpf << endl;
    cout << "- Size                 : " << sizeof(cpf) << endl;
    cpf->testRemoveNonNumChars();
    if (option == "--delete-test") {
        cout << "- deleting " << "cpf" << endl;
        cpf = nullptr;
        delete cpf;}
    cout << endl;

    Cpf* cpf1 = new Cpf("test...1...2...3", "testing...1...2...3");
    cout << "Cpf(\"test...1...2...3\", \"testing...1...2...3\")" << endl;
    cpf1->data();
    cout << "- MemAddress           : " << cpf1 << endl;
    cout << "- Size                 : " << sizeof(cpf1) << endl;
    cpf1->testRemoveNonNumChars();
    if (option == "--delete-test") {
        cout << "- deleting " << "cpf1" << endl;
        cpf1 = nullptr;
        delete cpf1;}
    cout << endl;

    Cpf* cpf2 = new Cpf("111.444.777", "111.444.777-35");
    cout << "Cpf(\"111.444.777\", \"111.444.777-35\")" << endl;
    cpf2->data();
    cout << "- MemAddress           : " << cpf2 << endl;
    cout << "- Size                 : " << sizeof(cpf2) << endl;
    cpf2->testRemoveNonNumChars();}

int main(int argc, char* argv[]) {
    cout << "CLI args: " << endl;
    for (int i = 0; i < argc; i++) {
        cout << "- " << i+1 <<  ") " << argv[i] << endl;}
    cout << endl;

    string option1;
    string option2;
    if (argc > 1)
        option1 = argv[1];
    if (argc > 2 && option1 == "--demo")
        option2 = argv[2];
    if (option1 == "--demo")
        demo(option2);
    return 0;}