# Homework 3

## Mobiles

### Q1

完成planet的构造函数和大小选择器,根据mobiles的照样画葫芦即可.

```python
def planet(size):
    """Construct a planet of some size."""
    assert size > 0
    "*** YOUR CODE HERE ***"
    return ['planet', size]

def size(w):
    """Select the size of a planet."""
    assert is_planet(w), 'must call size on a planet'
    "*** YOUR CODE HERE ***"
    return w[1]
```

### Q2

判断一个mobile是否平衡,规则是其两个arm的长度和重量相乘都相等即有:

l1 * w1 = l2 * w2

同时如果arm上还有mobile的话,需要判断上面的mobile是否平衡,如果有一个不平衡,则整个mobile不平衡

```python
def judge(m):
    l1,l2 = length(left(m)),length(right(m))
    w1,w2 = total_weight(end(left(m))),total_weight(end(right(m)))
    if l1 * w1 == l2 * w2:
        return True
    else: return False
f1,f2 = True,True
if is_mobile(end(left(m))):		# 判断左边手臂是否平衡
    f1 = balanced(end(left(m)))
if is_mobile(end(right(m))):	# 判断右边手臂是否平衡
    f2 = balanced(end(right(m)))
f3 = judge(m)					# 判断当前手臂是否平衡
if f1 and f2 and f3:
    return True					# 都平衡整体才平衡
else: return False
```

### Q3

根据mobile构造一颗树,label是整个mobile的重量,仍然是递归来做

```python
if is_planet(m):
    return tree(size(m))
if is_mobile(m):
    return tree(total_weight(m),[totals_tree(end(left(m))),totals_tree(end(right(m)))])
```

## Tree

### Q4

将等于寻找值的叶子结点的标记值换为固定值

```python
if is_leaf(t):
    if label(t) == find_value:
        return tree(replace_value)
    return tree(label(t))
else:
    return tree(label(t),[replace_leaf(b,find_value,replace_value) for b in branches(t)])
```

### Q5

对树进行前序遍历并记录遍历的路径

```python
def pre(ans,r):
    ans.append(label(r))
    for b in branches(r):
        pre(ans,b)
ans = []
pre(ans,t)
return ans
```

### Q6

编写一个函数has_path，它接受一个树t和一个字符串单词.如果有一个路径从路径上的条目拼出单词的根开始，则返回True，否则返回False. 您可以假设每个节点的标签都是一个字符.

利用前序遍历来找路径是否存在

```python
def trie(t,word,level):
    if label(t) == word[level]:
        if level >= len(word) - 1:
            return True
        for b in branches(t):
            if trie(b,word,level + 1):
                return True
    return False
return trie(t,word,0)
```

## Extra Questions

### Q7

补全数据抽象

```python
def lower_bound(x):
    """Return the lower bound of interval x."""
    "*** YOUR CODE HERE ***"
    return x[0]

def upper_bound(x):
    """Return the upper bound of interval x."""
    "*** YOUR CODE HERE ***"
    return x[1]
def mul_interval(x, y):
    """Return the interval that contains the product of any value in x and any
    value in y."""
    x_l,y_l = lower_bound(x),lower_bound(y)
    x_u,y_u = upper_bound(x),upper_bound(y)
    p1 = x_l * y_l
    p2 = x_l * y_u
    p3 = x_u * y_l
    p4 = x_u * y_u
    return interval(min(p1, p2, p3, p4), max(p1, p2, p3, p4))
```

### Q8

实现区间减法

```python
def sub_interval(x, y):
    """Return the interval that contains the difference between any value in x
    and any value in y."""
    "*** YOUR CODE HERE ***"
    x_l, y_l = lower_bound(x), lower_bound(y)
    x_u, y_u = upper_bound(x), upper_bound(y)
    p1 = x_l - y_l
    p2 = x_l - y_u
    p3 = x_u - y_l
    p4 = x_u - y_u
    return interval(min(p1, p2, p3, p4), max(p1, p2, p3, p4))
```

### Q9

实现区间除法,y区间中不能含有0,增加断言

```python
def div_interval(x, y):
    """Return the interval that contains the quotient of any value in x divided by
    any value in y. Division is implemented as the multiplication of x by the
    reciprocal of y."""
    "*** YOUR CODE HERE ***"
    assert upper_bound(y) * lower_bound(y) > 0
    reciprocal_y = interval(1/upper_bound(y), 1/lower_bound(y))
    return mul_interval(x, reciprocal_y)
```

### Q10

上下界相等即可

### Q12

求二次函数给定范围内的区间:

```python
def f(t):
    return a * t * t + b * t + c
x1, x2 = lower_bound(x),upper_bound(x)
ex = -b / (a + a)
if x1 <= ex <= x2:
    return interval(min(f(ex),f(x1),f(x2)),max(f(ex),f(x1),f(x2)))
else:
    return interval(min(f(x1),f(x2)),max(f(x1),f(x2)))
```

