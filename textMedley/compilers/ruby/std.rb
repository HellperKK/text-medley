#TODO think why numbers are converted into floats instead of ints

def randomNum(max)
  rand(0...max)
end

def __if__(cond, ifTrue, ifFalse)
  (cond.to_f != 0 && cond != "") ? ifTrue : ifFalse
end

def __concat__(val, valb)
  val + valb
end

def __plus__(num, numb)
  (num.to_f + numb.to_f).to_s
end

def __minus__(num, numb)
  (num.to_f - numb.to_f).to_s
end

def __times__(num, numb)
  (num.to_f * numb.to_f).to_s
end

def __divide__(num, numb)
  (num.to_f / numb.to_f).to_s
end

def __power__(num, numb)
  (num.to_f ** numb.to_f).to_s
end

def __floor__(num)
  num.to_f.floor.to_s
end

def __ceil__(num)
  num.to_f.ceil.to_s
end

def __clamp__(num, min, max)
  [[num, min].max, max].min
end

def __min__(num, numb)
  [num, numb].min
end

def __max__(num, numb)
  [num, numb].max
end
