import cpf;

import <iostream>;
import <memory>;
import <string>;
import <sstream>;

using namespace std;

void smartCompareCpfObjects(
    string cpfA, Cpf& pCpfA, string cpfB, Cpf& pCpfB) {
    cout << "- `" << cpfA << "` is " << (pCpfA != pCpfB ? "not " : "")
        << "equal to `" << cpfB << "`;" << endl
        <<  "    `&" << cpfA << "`: " << &pCpfA
        << "; `&" << cpfB << "`: " << &pCpfB << "." << endl;}

Cpf* createDefaultCpfObject(string varName) {
    Cpf* c = new Cpf();
    cout << "Cpf* " << varName << " = new Cpf()" << endl;
    return c;}

Cpf* createCpfObject(string varName, string cpf, string completeCpf) {
    Cpf* c = new Cpf(cpf, completeCpf);
    cout << "Cpf* " << varName << " = new Cpf(\"" << cpf << "\", "
        << "\"" << completeCpf << "\")" << endl;
    return c;}

Cpf* copyCpfObject(
    string newCpf, string oldCpf, Cpf* pOldCpf) {
    cout << "Cpf* " << newCpf << " = new Cpf(*" << oldCpf << ")" << endl;
    Cpf* pNewCpf = new Cpf(*pOldCpf);
    return pNewCpf;}

void deleteTest(string varName, Cpf* cpf, string option="") {
    if (option == "--delete-test") {
        cout << "- deleting `" << varName << "`" << endl;
        delete cpf;
        cpf = nullptr;}}

void demo(string option) {
    Cpf* cpf = createDefaultCpfObject("cpf");
    cpf->debugClass();
    deleteTest("cpf", cpf, option);
    cout << endl;

    Cpf* cpf1 = createCpfObject("cpf1", "0", "00");
    cpf1->debugClass();
    deleteTest("cpf1", cpf1, option);
    cout << endl;

    Cpf* cpf2 = createCpfObject("cpf2", "test...1 2 3", "testing...1 2 3");
    cpf2->debugClass();
    deleteTest("cpf2", cpf2, option);
    cout << endl;

    Cpf* cpf3 = createCpfObject("cpf3", "003.444.777", "003.444.777-62");
    cpf3->debugClass();
    cout << endl;

    Cpf* cpf4 = copyCpfObject("cpf4", "cpf3", cpf3);
    cout << endl;

    Cpf* cpf5 = createCpfObject("cpf5", "03.444.777", "03.444.777-62");
    cpf5->debugClass();
    cout << endl;

    Cpf* cpf6 = createCpfObject("cpf6", "3444777", "344477762");
    cpf6->debugClass();
    cout << endl;

    smartCompareCpfObjects("cpf3", *cpf3, "cpf4", *cpf4);
    cout << endl;
    smartCompareCpfObjects("cpf3", *cpf3, "cpf5", *cpf5);
    cout << endl;
    smartCompareCpfObjects("cpf3", *cpf3, "cpf6", *cpf6);

    if (option == "--delete-test") {
        cout << endl;
        deleteTest("cpf3", cpf3, option);
        cout << endl;

        cout << "`cpf4` is accessible after deleting `cpf3`" << endl;
        cpf4->debugClass();}}

void help_user() {
    cout << "Digite uma das opções abaixo:" << endl
        << "- '-c' ou '--calcular' e um número de CPF sem os dígitos " 
        << "verificadores;" << endl
        << "- '-f' ou '--formatar' e um número de CPF completo;" << endl
        << "- '-v' ou '--verificar' e um número de CPF completo;" << endl
        << "- '--demo';" << endl
        << "- '--demo --delete-test'." << endl;}

int main(int argc, char* argv[]) {
    string option1, option2;
    if (argc > 1)
        option1 = argv[1];
    if (argc > 2)
        option2 = argv[2];
    if (option1 == "--demo") {
        cout << "CLI args: " << endl;
        for (int i = 0; i < argc; i++) {
            cout << "- " << i+1 <<  ") " << argv[i] << endl;}
        cout << endl;
        demo(option2);
        return 0;}
    if (argc > 2 && !Cpf::hasANumber(option2)) {
        cout << "ERRO: o CPF informado não possui números." << endl << endl;
        help_user();
        return 1;}
    if (option1 == "--calcular" || option1 == "-c") {
        unique_ptr<Cpf> inputCpf(new Cpf(option2, ""));
        int* dvs = inputCpf->calculateVerificationDigits();
        stringstream cCpf;
        cCpf << inputCpf->clean(false) << dvs[0] << dvs[1];
        unique_ptr<Cpf> completeCpf(new Cpf("", cCpf.str()));
        cout << "CPF informado: " << inputCpf->format(false) << endl
            <<  "CPF completo : " << completeCpf->format() << endl
            <<  "               " << completeCpf->clean() << endl
            <<  "{ " << dvs[0] << ", " << dvs[1] << " }" << endl;}
    else if (option1 == "--formatar" || option1 == "-f") {
        unique_ptr<Cpf> cpf(new Cpf("", option2));
        cout << "CPF formatado: " << cpf->format() << endl;}
    else if (option1 == "--verificar" || option1 == "-v") {
        unique_ptr<Cpf> cpf(new Cpf("", option2));
        bool v = cpf->verify();
        cout << "O CPF " << cpf->format() << " é " << (v ? "" : "in")
            << "válido." << endl;
        if (!v)
            return 2;}
    else {
        help_user();
        return 1;}
    return 0;}
