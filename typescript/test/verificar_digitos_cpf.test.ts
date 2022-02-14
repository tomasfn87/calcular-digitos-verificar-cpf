import verificar_cpf from "../verificar_digitos_cpf";
import { comparar_dvs } from "../verificar_digitos_cpf";
import { expect } from "chai";

describe('Verificar dígitos CPF', function() {
  it('../verificar_digitos_cpf.ts.comparar_dvs - [[3,5],[3,5]] -> true', function() {
    let result = comparar_dvs([3,5], [3,5]);
    expect(result).equal(true);
  });

  it('../verificar_digitos_cpf.ts.comparar_dvs - [[3,6],[3,5]] -> false', function() {
    let result = comparar_dvs([3,6], [3,5]);
    expect(result).equal(false);
  });

  it('../verificar_digitos_cpf.ts.verificar_cpf - "11144477735" -> true', function() {
    let result = verificar_cpf('11144477735');
    expect(result).equal(true);
  });

  it('../verificar_digitos_cpf.ts.verificar_cpf - 11144477735 -> true', function() {
    let result = verificar_cpf(11144477735);
    expect(result).equal(true);
  });

  it('../verificar_digitos_cpf.ts.verificar_cpf - "11144477736" -> false', function() {
    let result = verificar_cpf('11144477736');
    expect(result).equal(false);
  });

  it('../verificar_digitos_cpf.ts.verificar_cpf - 11144477736 -> false', function() {
    let result = verificar_cpf(11144477736);
    expect(result).equal(false);
  });
});
