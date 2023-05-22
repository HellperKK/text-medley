function randomNum(max: number): number {
  return Math.floor(Math.random() * max);
}

function __if__(cond: string, ifTrue: string, iFalse: string): string {
  return parseFloat(cond) !== 0 && cond !== "" ? ifTrue : iFalse;
}

function __concat__(...params: Array<string>): string {
  return params.join("");
}

function __plus__(num: string, numb: string): string {
  return (parseFloat(num) + parseFloat(numb)).toString();
}

function __minus__(num: string, numb: string): string {
  return (parseFloat(num) - parseFloat(numb)).toString();
}

function __times__(num: string, numb: string): string {
  return (parseFloat(num) * parseFloat(numb)).toString();
}

function __divide__(num: string, numb: string): string {
  return (parseFloat(num) / parseFloat(numb)).toString();
}

function __power__(num: string, numb: string): string {
  return (parseFloat(num) ** parseFloat(numb)).toString();
}

function __modulo__(num: string, numb: string): string {
  return (parseFloat(num) % parseFloat(numb)).toString();
}

function __floor__(num: string): string {
  return Math.floor(parseFloat(num)).toString();
}

function __ceil__(num: string): string {
  return Math.ceil(parseFloat(num)).toString();
}

function __clamp__(num: string, min: string, max: string): string {
  return Math.min(
    parseFloat(max),
    Math.max(parseFloat(min), parseFloat(num))
  ).toString();
}

function __min__(num: string, numb: string): string {
  return Math.min(parseFloat(num), parseFloat(numb)).toString();
}

function __max__(num: string, numb: string): string {
  return Math.max(parseFloat(num), parseFloat(numb)).toString();
}


function __count__(value):string {
    const _rand = randomNum(6);
    if (_rand === 0) {
        return value + ", " + __count__(__plus__(value,"1"));
    }
    if (_rand === 1) {
        return value + ", " + __count__(__plus__(value,"1"));
    }
    if (_rand === 2) {
        return value + ", " + __count__(__plus__(value,"1"));
    }
    if (_rand === 3) {
        return value + ", " + __count__(__plus__(value,"1"));
    }
    if (_rand === 4) {
        return value + ", " + __count__(__plus__(value,"1"));
    }
    if (_rand === 5) {
        return "end";
    }
    throw new Error("index out of range");
}

function __main__():string {
    const _rand = randomNum(1);
    if (_rand === 0) {
        return __count__("0");
    }
    throw new Error("index out of range");
}