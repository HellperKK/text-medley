function randomNum(max) {
  return Math.floor(Math.random() * max);
}

function __if__(cond, ifTrue, iFalse) {
  return parseFloat(cond) !== 0 && cond !== "" ? ifTrue : iFalse;
}

function __concat__(...params) {
  return params.join("");
}

function __plus__(num, numb) {
  return (parseFloat(num) + parseFloat(numb)).toString();
}

function __minus__(num, numb) {
  return (parseFloat(num) - parseFloat(numb)).toString();
}

function __times__(num, numb) {
  return (parseFloat(num) * parseFloat(numb)).toString();
}

function __divide__(num, numb) {
  return (parseFloat(num) / parseFloat(numb)).toString();
}

function __power__(num, numb) {
  return (parseFloat(num) ** parseFloat(numb)).toString();
}

function __modulo__(num, numb) {
  return (parseFloat(num) % parseFloat(numb)).toString();
}

function __floor__(num) {
  return Math.floor(parseFloat(num)).toString();
}

function __ceil__(num) {
  return Math.ceil(parseFloat(num)).toString();
}

function __clamp__(num, min, max) {
  return Math.min(
    parseFloat(max),
    Math.max(parseFloat(min), parseFloat(num))
  ).toString();
}

function __min__(num, numb) {
  return Math.min(parseFloat(num), parseFloat(numb)).toString();
}

function __max__(num, numb) {
  return Math.max(parseFloat(num), parseFloat(numb)).toString();
}
