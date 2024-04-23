g++ -std=c++20 -fmodules-ts -x c++-system-header cctype;
g++ -std=c++20 -fmodules-ts -x c++-system-header iostream;
g++ -std=c++20 -fmodules-ts -x c++-system-header memory;
g++ -std=c++20 -fmodules-ts -x c++-system-header sstream;
g++ -std=c++20 -fmodules-ts -x c++-system-header string;
g++ -std=c++20 -fmodules-ts -c cpf.cpp;
g++ -std=c++20 -fmodules-ts main.cpp cpf.o -o cpf;