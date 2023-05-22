function randomNum(max: number): number {
  return Math.floor(Math.random() * max);
}

function __if__(cond: string, ifTrue: string, iFalse: string): string {
  return parseFloat(cond) !== 0 && cond !== "" ? ifTrue : iFalse;
}

function __concat__(val: string, valb: string): string {
  return val + valb;
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
