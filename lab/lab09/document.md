# Midterm Review

## Recursion and Tree Recursion

### Q2

subseqs函数传入一个序列s, 返回一个列表, 列表中包含序列s中的所有子序列

```python
'''
insert_into_all 将item添加至嵌套列表中每一个列表的前面
subseqs产生s的所有子序列:
最基本的情况是s为空,只需返回一个嵌套空列表
之后所有情况在创建s[1:]的子序列的情况后,与增加了s[0]的嵌套序列拼接得到整个s的子序列
'''
def insert_into_all(item, nested_list):
    return [[item] + l[:] for l in nested_list]

def subseqs(s):
    if len(s) == 0:
        return [[]]
    else:
        ans = subseqs(s[1:])
        return ans[:] + insert_into_all(s[0],ans)
```

### Q3

incseqs函数传入一个序列s, 返回一个列表, 列表中包含序列s中所有递增的子序列

比如传入[1,3,2]

输出[[], [1], [1, 2], [1, 3], [2], [3]]

```python
'''如果s为空直接返回空嵌套列表
否则如果当前s的首位是小于前一位则去后面的序列中查找
否则如果当前s的首位大于等于前一位,
1.选择直接去后面的序列查找(前一位数字不变)
2.选择直接去后面的序列查找(前一位数字变为当前的s[0]首位)
将1,2两种情况加一起返回
'''
def inc_subseqs(s):
    def subseq_helper(s, prev):
        if not s:
            return [[]]
        elif s[0] < prev:
            return subseq_helper(s[1:],prev)
        else:
            a = subseq_helper(s[1:],prev)
            b = subseq_helper(s[1:],s[0])
            return insert_into_all(s[0], b) + a
    return subseq_helper(s, 0 if len(s) == 0 else s[0])
```

### Q4

盲猜是卡特兰数,但是不会证明

```python
def num_trees(n):
    if n == 1:
        return 1
    return num_trees(n - 1) * (4 * n - 6) // n
```

## Generators

### Q5

完全没看懂题意,简单根据样例推算了一下

```python
def make_generators_generator(g):
    def gen(i):
        # 调用g()只产生小于i的结果
        for e in g():
            if e <= i:
                yield e
    # 这里调用一次g()迭代g产生的所有可能结果
    for e in g():
        yield gen(e)
```

### Q6

根据题意正常模拟没难度

```python
class Keyboard:
    """A Keyboard takes in an arbitrary amount of buttons, and has a
    dictionary of positions as keys, and values as Buttons.
    """

    def __init__(self, *args):
        self.buttons = dict()
        for b in args:
            self.buttons[b.pos] = b

    def press(self, info):
        """Takes in a position of the button pressed, and
        returns that button's output"""
        if info in self.buttons:
            self.buttons[info].times_pressed += 1
            return self.buttons[info].key
        return ''

    def typing(self, typing_input):
        """Takes in a list of positions of buttons pressed, and
        returns the total output"""
        output = ''
        for t in typing_input:
            output += self.press(t)
        return output
```

### Q7

考察nonlocal的用法

在maker里创建全局的count使所有的函数都能修改

在make_counter里创建局部的count使对应的函数才能修改

```python
def make_advanced_counter_maker():
    g_count = 0
    def make_counter():
        any_count = 0
        def any_counter(s):
            nonlocal g_count
            nonlocal any_count
            "*** YOUR CODE HERE ***"
            if s == 'count':
                any_count += 1
                return any_count
            elif s == 'global-count':
                g_count += 1
                return g_count
            elif s == 'reset': any_count = 0
            elif s == 'global-reset': g_count = 0
        return any_counter
    return make_counter
```

## Mutable Lists

### Q8

交换两个列表的前m个和前n个数字使交换数字的总和相等

用到了sum内置函数来求前n个列表数字的和

```python
def trade(first, second):
    m, n = 1, 1
    equal_prefix = lambda: sum(first[:m]) == sum(second[:n])
    while m < len(first) and n < len(second) and not equal_prefix():
        if sum(first[:m]) < sum(second[:n]):
            m += 1
        else:
            n += 1

    if equal_prefix():
        first[:m], second[:n] = second[:n], first[:m]
        return 'Deal!'
    else:
        return 'No deal!'
```

### Q9

打乱一个数字,将第后一半的数字逐个插入到前一半数字的后面:

012345->031425

```python
def shuffle(cards):
    assert len(cards) % 2 == 0, 'len(cards) must be even'
    half = len(cards) // 2
    shuffled = []
    for i in range(half):
        shuffled.append(cards[i])
        shuffled.append(cards[i + half])
    return shuffled
```

## Linked Lists

### Q10

向链表中插入一个数(下标从0开始)

如<1,2,3>对应的下标分别为0,1,2

insert(link,9001,0)即将下标为0的位置改为9001,其后的数字仍为123,链表就变为

<9001,1,2,3>

```python
def insert(link, value, index):
    if link != Link.empty and index == 0:
        t = Link(link.first,link.rest)
        link.first = value
        link.rest = t
    elif link != Link.empty and index > 0:
        insert(link.rest,value,index - 1)
    else:
        print("IndexError")

```

### Q11

获取一个链表的深度

这个链表的first可以是链表,rest是链表

```python
def deep_len(lnk):
    if lnk == Link.empty:
        return 0
    elif not isinstance(lnk,Link):
        return 1
    else:
        return deep_len(lnk.first) + deep_len(lnk.rest)
```

### Q12

将链表形式转为字符串形式

注意字符串组合次序即可

```python
def make_to_string(front, mid, back, empty_repr):
    def printer(lnk):
        if lnk == Link.empty:
            return empty_repr
        else:
            return front + str(lnk.first) + mid + printer(lnk.rest) + back
    return printer
```

### Q13

给定树的分支数,删除树中多于的分支(这些分支结点必须是同层中最大的那些)

```python
def prune_small(t, n):
    while len(t.branches) > n:
        largest = max(t.branches, key=lambda x: x.label)
        t.branches.remove(largest)
    for b in t.branches:
        prune_small(b,n)
```



