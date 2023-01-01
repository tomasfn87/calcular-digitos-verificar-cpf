import limpar_numero from "../limpar_numero";
import { expect } from "chai";

describe('Limpar número', function() {
  it('../limpar_numero.ts.limpar_numero - "12345" -> "12345"', function() {
    let result = limpar_numero("12345");
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - 12345 -> "12345"', function() {
    let result = limpar_numero(12345);
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - [12345] -> "12345"', function() {
    let result = limpar_numero([12345]);
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - [1,2,3,4,5], 5 -> "12345"', function() {
    let result = limpar_numero([1,2,3,4,5], 5);
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - "1,2,3,4,5", 5 -> "12345"', function() {
    let result = limpar_numero('1,2,3,4,5', 5);
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - "1a2b3c4d5e", 5 -> "12345"', function() {
    let result = limpar_numero('1a2b3c4d5e', 5);
    expect(result).equal("12345");
  });

  it('../limpar_numero.ts.limpar_numero - ["1a2","b",3,"c4d",5,"e"], 5 -> "12345"', function() {
    let result = limpar_numero(['1a2','b',3,'c4d',5,'e'], 5);
    expect(result).equal("12345");
  });
});
