# Homework 4

## Nonlocal

### Q1

编写make_bank,实现存款,取款,提示无效信息三种功能,取款时资金不够则返回"Insufficient funds"

```python
def bank(message, amount):
    "*** YOUR CODE HERE ***"
    nonlocal balance
    if message == "withdraw":
        if balance < amount:
            return "Insufficient funds"
        balance -= amount
        return balance
    elif message == "deposit":
        balance += amount
        return balance
    else: return "Invalid message"
return bank
```

### Q2

编写make_withdraw,初始会创建账户余额和密码,密码输入错误将提示,一共错三次将无法访问账户,余额不足也会给出提醒

```python
password_err = []
def withdraw(amount,password_attempt):
    nonlocal password_err,password,balance
    if len(password_err) >= 3:
        return "Frozen account. Attempts: " + str(password_err)
    if password_attempt != password:
        password_err.append(password_attempt)
        return 'Incorrect password'
    if amount > balance:
        return 'Insufficient funds'
    balance -= amount
    return balance
return withdraw
```

## Iterators and Generators

### Q3

给定一个迭代器t和次数k,查找列表中第一个出现k次的数字

```python
num = next(t)
times = 1
for x in t:
    if x == num:
        times += 1
        if times == k:
            return x
    else:
        num = x
        times = 1
```

### Q4

递归实现全排列,没有用提示的方法,而是使用dfs普通枚举方法,**yield返回时需要复制一份数组再返回.**

```python
out = [0 for i in range(len(seq))]
vis = [False for i in range(len(seq))]
def ex_premutation(u):
    if u == len(seq):
        # Can't yield a 'out' in here
        res = out[:]
        yield res
    else:
        i = 0
        while i < len(seq):
            if not vis[i]:
                vis[i] = True
                out[u] = seq[i]
                yield from ex_premutation(u + 1)
                vis[i] = False
            i += 1
yield from ex_premutation(0)
```

## Extra Questions

### Q5

给账户增加联名功能,新联名的账户可以更改密码并使用新密码来访问原先的账户,但在所有联名的账户中输错密码共三次所有联名账户都会被锁定.

1. 首先增加联名账户要更改密码时对原先密码进行确认,如果原密码错误则返回错误,否则返回一个新联名的账户

2. 在新账户中可以使用新密码和旧密码,如果使用的是新密码,内部直接调用旧密码,否则将这个尝试的密码传入上一层的账户中尝试

```python
def joint(amount, password_attemp):
    nonlocal new_pass,old_pass
    if password_attemp == new_pass:
        return withdraw(amount,old_pass)
    else:return withdraw(amount,password_attemp)
res = withdraw(0,old_pass)
if type(res) == str:return res
else:return joint
```

### Q6

高级生成器:返回生成器的生成器,问题是给定参数m,返回m个生成器,第一个生成器是 m 的倍数生成器,即余数为 0 的数字.第二个是自然数的生成器,除以 m 时余数为 1.最后一个生成器产生自然数,除以 m 时余数为 m - 1.

**两次yield**

```python
"*** YOUR CODE HERE ***"
def generator(x):
    nonlocal m
    n = naturals()
    while True:
        num = next(n)
        if num % m == x:
            yield num
for i in range(m):
    yield generator(i)
```

