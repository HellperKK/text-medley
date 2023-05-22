def pick_random(arr)
    arr[rand(0...arr.length)]
end

def __if__(cond, ifTrue, ifFalse)
    (cond.to_f !== 0 && cond !== "") ? ifTrue : ifFalse

def __concat__(val, valb)
    val + valb

def __plus__(num, numb)
    (num.to_f + numb.to_f).to_s

def __minus__(num, numb)
    (num.to_f - numb.to_f).to_s

def __times__(num, numb)
    (num.to_f * numb.to_f).to_s

def __divide__(num, numb)
    (num.to_f / numb.to_f).to_s

def __power__(num, numb)
    (num.to_f ** numb.to_f).to_s

def __floor__(num)
    num.to_f.floor.to_s

def __ceil__(num)
    num.to_f.ceil.to_s

def __clamp__(num, min, max)
    [[num, min].max, max].min

def __min__(num, numb)
    [num, numb].min

def __max__(num, numb)
    [num, numb].max


=begin
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
=end