require "deterministic"
include Deterministic::Prelude::Result

File.open(ARGV[0].to_s) do |f|
  f.read do |contents|
    parse(contents)
  end
end

def parse(string)
  constructSyntaxList(tokenize(string))
end

def tokenize(string)
  string.replace("(", " ( ").replace(")", " ) ").split()
end

def constructSyntaxList(tokenList)
  token = tokenList.shift
  if token == '('
    nestedList = []
    while tokenList.first != ')'
      nestedList.push(constructSyntaxList(tokenList))
    end
    tokenList.shift
    nestedList
  else
    atom(token)
  end
end

def atom(token)
  try! { Integer(token, 10) }
    .or_else { try! { Float(token) } }
    .or_else { Success(token) }.value
end

def evaluate (exp eval)
  case
  when exp.kind_of?(Array)
  else
end
