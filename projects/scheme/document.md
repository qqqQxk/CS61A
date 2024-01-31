# Project4

## Part1: The Evaluator

### P1

实现Frame类中的define和lookup函数,前者定义一个名字和值并绑定到环境中,后者根据名字寻找值

```python
def define(self, symbol, value):
    # BEGIN PROBLEM 1
    "*** YOUR CODE HERE ***"
    self.bindings[symbol] = value
    # END PROBLEM 1
    
def lookup(self, symbol):
    # BEGIN PROBLEM 1
    "*** YOUR CODE HERE ***"
    if symbol in self.bindings:
        return self.bindings[symbol]
    elif self.parent is not None:
        pa = self.parent
        while pa is not None:
            if symbol in pa.bindings:
                return pa.bindings[symbol]
            else: pa = pa.parent
    # END PROBLEM 1
    raise SchemeError('unknown identifier: {0}'.format(symbol))
```

### P2

实现内置过程

```python
if isinstance(procedure, BuiltinProcedure):
    # BEGIN PROBLEM 2
    "*** YOUR CODE HERE ***"
    a = args
    args_l = []
    while a is not nil:
        args_l.append(a.first)
        a = a.rest
    if procedure.need_env is True:
        args_l.append(env)
    # END PROBLEM 2
    try:
        # BEGIN PROBLEM 2
        "*** YOUR CODE HERE ***"
        return procedure.py_func(*args_l)
        # END PROBLEM 2
    except TypeError as err:
        raise SchemeError('incorrect number of arguments: {0}'.format(procedure))
```



### P3

执行一个过程(递归解析并返回结果)

题目已给出原子情况,只需要填写非原子情况:

1. 评估表达式的第一项(操作符)
2. 评估表达式的后面所有项(操作数)
3. 应用apply函数返回评估结果

```python
else:
    # BEGIN PROBLEM 3
    "*** YOUR CODE HERE ***"
    procedure = scheme_eval(first,env)
    args, a = nil, nil
    while rest is not nil:
        if args is nil:
            args = Pair(scheme_eval(rest.first,env),nil)
            a = args
        else:
            a.rest = Pair(scheme_eval(rest.first,env),nil)
            a = a.rest
        rest = rest.rest
    return scheme_apply(procedure,args,env)
    # END PROBLEM 3
```

### P4

define第一部分: 定义符号的值

传入的expression是一个Pair(symbol, Pair(val_exp,nil))的形式

```python
if scheme_symbolp(signature):
    # assigning a name to a value e.g. (define x (+ 1 2))
    validate_form(expressions, 2, 2) # Checks that expressions is a list of length exactly 2
    # BEGIN PROBLEM 4
    "*** YOUR CODE HERE ***"
    val_exp = expressions.rest.first
    env.define(signature,scheme_eval(val_exp,env))
    return signature
```

### P5

实现quote: 不去解析quote后的表达式,当成一个符号来对待

```python
def do_quote_form(expressions, env):
    validate_form(expressions, 1, 1)
    # BEGIN PROBLEM 5
    "*** YOUR CODE HERE ***"
    return expressions.first
    # END PROBLEM 5
```



## Part2: Procedures

### P6

实现begin功能, 在一个()内执行多条语句

即如果检测到begin的话直接里面的语句全部执行

```python
def eval_all(expressions, env):
    """Evaluate each expression in the Scheme list EXPRESSIONS in
    """
    # BEGIN PROBLEM 6
    exp = expressions
    res = None
    while exp is not nil:
        res = scheme_eval(exp.first,env)
        exp = exp.rest
    return res
    # replace this with lines of your own code
    # END PROBLEM 6
```

### P7

定义lambda表达式

传入必须包括参数和函数体同时参数必须为正确嵌套形式

之后返回一个LambdaProcedure的实例即可

```python
def do_lambda_form(expressions, env):
    validate_form(expressions, 2)
    formals = expressions.first
    validate_formals(formals)
    # BEGIN PROBLEM 7
    "*** YOUR CODE HERE ***"
    body = expressions.rest
    return LambdaProcedure(formals,body,env)
    # END PROBLEM 7
```

### P8

创建子环境

在继承父环境的基础上,将传入的参数符号和值绑定到当前子环境中

```python
def make_child_frame(self, formals, vals):
    """Return a new local frame whose parent is SELF, in which the symbols
    """
    if len(formals) != len(vals):
        raise SchemeError('Incorrect number of arguments to function call')
    # BEGIN PROBLEM 8
    "*** YOUR CODE HERE ***"
    args,v = [],[]
    p,q = formals,vals
    while p is not nil:
        args.append(p.first)
        v.append(q.first)
        p,q = p.rest,q.rest
    child = Frame(self)
    for x,y in zip(args,v):
        child.bindings[x] = y
    return child
    # END PROBLEM 8
```

### P9

执行定义的lambda表达式:

1. 根据传入的过程和参数来确定是哪一个lambda表达式和其参数
2. 用这个过程的所在帧创建一个子帧(参数为lambda的formals和传入的args)
3. 返回eval_all应用的结果

```python
elif isinstance(procedure, LambdaProcedure):
    # BEGIN PROBLEM 9
    "*** YOUR CODE HERE ***"
    formals, vals = procedure.formals, args
    childf = procedure.env.make_child_frame(formals,vals)
    return eval_all(procedure.body,childf)
    # END PROBLEM 9
```

### P10

实现让用户自定义函数

1. 根据给出的signature得到函数名和函数参数
2. 从给出的表达中得到函数体
3. 构造一个以该参数和函数体为主的lambda表达式
4. 在当前环境中绑定函数名和该表达式,返回函数名

```python
elif isinstance(signature, Pair) and scheme_symbolp(signature.first):
    # defining a named procedure e.g. (define (f x y) (+ x y))
    # BEGIN PROBLEM 10
    "*** YOUR CODE HERE ***"
    symbol = signature.first
    formals = signature.rest
    validate_formals(formals) #check the fromals 
    body = expressions.rest
    func = LambdaProcedure(formals,body,env)
    env.define(symbol,func)
    return symbol
    # END PROBLEM 10
```

### P11

动态作用域实现:

创建一个动态作用域的函数

调用该函数时,其使用的环境的父环境是调用该函数的表达式所在的环境.

```python
def do_mu_form(expressions, env):
    """Evaluate a mu form."""
    validate_form(expressions, 2)
    formals = expressions.first
    validate_formals(formals)
    # BEGIN PROBLEM 11
    "*** YOUR CODE HERE ***"
    body = expressions.rest
    return MuProcedure(formals,body)
    # END PROBLEM 11

elif isinstance(procedure, MuProcedure):
    # BEGIN PROBLEM 11
    "*** YOUR CODE HERE ***"
    childf = env.make_child_frame(procedure.formals,args)
    return eval_all(procedure.body,childf)
    # END PROBLEM 11    
```

## Part3: Special Forms

### P12

实现and和or,短路原则,根据已给的if仿照着写

```python
def do_and_form(expressions, env):
    """Evaluate a (short-circuited) and form.
    """
    # BEGIN PROBLEM 12
    "*** YOUR CODE HERE ***"
    exp = expressions
    res = True
    while exp is not nil:
        res = scheme_eval(exp.first,env)
        if is_scheme_false(res):
            break
        exp = exp.rest
    return res
    # END PROBLEM 12
def do_or_form(expressions, env):
    """Evaluate a (short-circuited) or form.
    """
    # BEGIN PROBLEM 12
    "*** YOUR CODE HERE ***"
    exp = expressions
    res = False
    while exp is not nil:
        res = scheme_eval(exp.first,env)
        if is_scheme_true(res):
            break
        exp = exp.rest
    return res
    # END PROBLEM 12
```

### P13

实现cond(if elif ....elif else)

整体框架已搭好,clause应为Pair(exp/else,Pair(body,nil))

执行前置exp,然后如果为真就执行后置的body并返回结果

```python
if is_scheme_true(test):
    # BEGIN PROBLEM 13
    "*** YOUR CODE HERE ***"
    if clause.rest is not nil:
        return eval_all(clause.rest,env)
    else: return test
    # END PROBLEM 13
```

### P14

实现let中的环境处理(绑定符号和对应值)

规则:

1. let创建的环境中符号名必须各不相同
2. let创建的环境中至少要有一个<符号-值>的对应
3. let创建的环境中符合对应的值只能为1个,如(y 2 3)是非法的

```python
def make_let_frame(bindings, env):
    """Create a child frame of Frame ENV that contains the definitions given in
    BINDINGS. The Scheme list BINDINGS must have the form of a proper bindings
    list in a let expression: each item must be a list containing a symbol
    and a Scheme expression."""
    if not scheme_listp(bindings):
        raise SchemeError('bad bindings list in let form')
    names = vals = nil
    # BEGIN PROBLEM 14
    "*** YOUR CODE HERE ***"
    validate_form(bindings,1)
    b, n, v = bindings, nil, nil
    while b is not nil:
        pa = b.first
        validate_form(pa,2,2)
        if names is nil:
            names, vals = Pair(pa.first,nil), Pair(scheme_eval(pa.rest.first,env),nil)
            n, v = names, vals
        else:
            n.rest, v.rest = Pair(pa.first,nil), Pair(scheme_eval(pa.rest.first,env),nil)
            n, v = n.rest, v.rest
        b = b.rest
    validate_formals(names)
    # END PROBLEM 14
    return env.make_child_frame(names, vals)
```

## Part4: Write Some Scheme

### P15

```scheme
;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (pair i lst)
    (if(null? lst)
        (list)
        (append (list(list i (car lst))) (pair (+ i 1) (cdr lst)))
    )
  )
  (pair 0 s)
)
; END PROBLEM 15
```

### P16

```scheme
;; Problem 16

;; Merge two lists S1 and S2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? s1 s2)
  ; BEGIN PROBLEM 16
  (cond ((and (null? s1) (null? s2)))
        ((null? s1) s2)
        ((null? s2) s1)
        (else
            (if(ordered? (car s1) (car s2))
                (append (list (car s1)) (merge ordered? (cdr s1) s2))
                (append (list (car s2)) (merge ordered? s1 (cdr s2)))
            )
        )
  )
)
; END PROBLEM 16
```





