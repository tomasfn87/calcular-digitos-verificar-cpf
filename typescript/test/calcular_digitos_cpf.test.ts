import obter_dvs from "../calcular_digitos_cpf";
import { calcular_dv, obter_lista_digitos } from "../calcular_digitos_cpf";
import { expect } from "chai";

describe('Calcular dígitos CPF', function() {
  it('../calcular_digitos_cpf.ts.calcular_dv - [1,1,1,4,4,4,7,7,7] -> 3', function() {
    let result = calcular_dv([1,1,1,4,4,4,7,7,7]);
    expect(result).to.eql(3); // and it also works just fine here, so I'll be testing it #4
  });

  it('../calcular_digitos_cpf.ts.calcular_dv - [1,1,1,4,4,4,7,7,7,3] -> 5', function() {
    let result = calcular_dv([1,1,1,4,4,4,7,7,7,3]);
    expect(result).to.eql(5); // and it also works just fine here, so I'll be testing it #4
  });

  it('../calcular_digitos_cpf.ts.obter_lista_digitos - "111444777" -> [1,1,1,4,4,4,7,7,7]', function() {
    let result = obter_lista_digitos('111444777');
    expect(result).to.eql([1,1,1,4,4,4,7,7,7]); // needed to use chai .to.eql to compare arrays #1
  });

  it('../calcular_digitos_cpf.ts.obter_lista_digitos - "111.444.777-35" -> [1,1,1,4,4,4,7,7,7]', function() {
    let result = obter_lista_digitos('111.444.777-35');
    expect(result).to.eql([1,1,1,4,4,4,7,7,7]); // needed to use chai .to.eql to compare arrays #1
  });

  it('../calcular_digitos_cpf.ts.obter_lista_digitos - 111444777 -> [1,1,1,4,4,4,7,7,7]', function() {
    let result = obter_lista_digitos(111444777);
    expect(result).to.eql([1,1,1,4,4,4,7,7,7]); // needed to use chai .to.eql to compare arrays #2
  });

  it('../calcular_digitos_cpf.ts.obter_dvs - "111444777" -> [3,5]', function() {
    let result = obter_dvs('111444777');
    expect(result).to.eql([3, 5]); // needed to use chai .to.eql to compare arrays #3
  });

  it('../calcular_digitos_cpf.ts.obter_dvs - "11144477746" -> [3,5]', function() {
    let result = obter_dvs('11144477746');
    expect(result).to.eql([3, 5]); // needed to use chai .to.eql to compare arrays #3
  });
  
  it('../calcular_digitos_cpf.ts.obter_dvs - "11144477" -> []', function() {
    let result = obter_dvs('11144477');
    expect(result).to.eql([]); // needed to use chai .to.eql to compare arrays #3
  });
});
