# Lab 6

## Nonlocal Codewriting

### Q1

编写一个函数，该函数接受整数 a 并返回一个单参数函数。此函数应接受某个值 b，并在第一次调用时返回 a + b，类似于 make_adder。但是，第二次调用它时，它应该返回 a + b + 1，然后第三次返回 a + b + 2，依此类推。

在上级函数里设置一个变量i,在内置函数中将i设置为nonlocal,每次add后自增

```python
i = 0
def adder(x):
    nonlocal i
    res = x + a + i
    i += 1
    return res
return adder
```

### Q2



编写一个函数make_fib，该函数返回一个函数，该函数在每次调用时返回下一个斐波那契数。（斐波那契数列以 0 开头，然后是 1，之后每个元素都是前两个元素的总和。

设置三个非本地变量,在内置函数中根据i的大小来返回第几个斐波那契数

```python
a0,a1 = 0,1
i = 0
def fib():
    nonlocal a0,a1,i
    res = 0
    if i == 0:
        res += a0
    elif i == 1:
        res += a1
    else:
        res += (a0 + a1)
        a0, a1 = a1, res
    i += 1
    return res
return fib
```

## Mutability

### Q4

给定指定数字,在一个列表中寻找该数字并在其后面添加指定的数字,最后返回列表(寻找的数字和添加的数字相同时再寻找时跳过添加的数字)

**python list传入函数可以认为是地址传递,二者在内外是相同的**

```python
i = 0
while i < len(lst):
    if lst[i] == entry:
        lst.insert(i + 1,elem)
        i += 2
    else: i += 1
return lst
```



