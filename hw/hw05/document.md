# HW5

## OOP

### Q1

根据题意模拟即可,在输入字符串时选中对应位置进行替换

```python
    def __init__(self,goods,price):
        self.goods = goods
        self.price = price
        self.num = 0
        self.funds = 0
    def vend(self):
        # sell goods
        if self.num == 0:
            return 'Inventory empty. Restocking required.'
        elif self.funds < self.price:
            need = self.price - self.funds
            return 'You must add ${0} more funds.'.format(need)
        elif self.funds >= self.price:
            change = self.funds - self.price
            self.num -= 1
            self.funds = 0
            if change == 0: return 'Here is your {0}.'.format(self.goods)
            else: return 'Here is your {0} and ${1} change.'.format(self.goods,change)
    def add_funds(self,funds):
        if self.num == 0:
            return 'Inventory empty. Restocking required. Here is your ${0}.'.format(funds)
        else:
            self.funds += funds
            return 'Current balance: ${0}'.format(self.funds)
    def restock(self,num):
        self.num += num
        return 'Current {0} stock: {1}'.format(self.goods,self.num)
```

### Q2

创建Mint时调用update函数,self.year = Mint.current_year

```python
# Coin worth方法
# 如果硬币保存超过50年,每一年价值加一分
def worth(self):
    if Mint.current_year - self.year > 50:
        return self.cents + Mint.current_year - self.year - 50
    else: return self.cents
```

## Linked Lists

### Q3

题目给出一个数字n,要求正序创建一个链表,如给出1234,创建Link(1, Link(2, Link(3, Link(4))))

```python
# 不让使用reverse,选择直接暴力拿到首位数字,然后递归处理
if n < 10:
    return Link(n)
else:
    tmp,count = n,0
    while tmp >= 10:
        tmp //= 10
        count += 1
	return Link(tmp,store_digits(n - tmp * (10 ** count)))
```

## Trees

### Q4

判断一棵树是否是二叉搜索树

```python
def bst_max(root):	# 搜寻root为根的树中最大的编号
    num = root.label
    for b in root.branches:
        num = max(num,bst_max(b))
    return num

def bst_min(root): # 搜寻root为根的树中最小的编号
    num = root.label
    for b in root.branches:
        num = min(num,bst_max(b))
    return num
if t.is_leaf():		# 当前二叉树只有一个结点,肯定是二叉搜索树
    return True
elif len(t.branches) > 2:	# 二叉搜索树任一节点最多有两个分支
    return False
elif len(t.branches) == 1:	# 如果只有一个分支, 这个分支可以是左/右分支
    if is_bst(t.branches[0]) and (bst_max(t.branches[0]) <= t.label or bst_min(t.branches[0]) > t.label):
        return True
    else: return False
b = t.branches				# 两个分支的情况,左右分支都是二叉搜索树,那么这棵树才有可能是二叉搜索树
if is_bst(b[0]) and bst_max(b[0]) <= t.label and is_bst(b[1]) and bst_min(b[1]) > t.label:
    return True
else: return False
```

### Q5

对一棵树进行前序遍历,记录遍历路径

```python
res = []
def bultin_preorder(root):
    res.append(root.label)
    for b in root.branches:
        bultin_preorder(b)
bultin_preorder(t)
return res
```

### Q6

用生成器生成从根节点t到某个叶子结点的路径

实际上还是递归寻找,从根节点一直向下找,如果找到了就yield一个结果,然后继续向下找直到树根

```python
path = []
def generate_path(r):
    path.append(r.label)
    if r.label == value:
        yield path[:]		# 这里要返回列表的复制,不然生成器返回浅拷贝
    for b in r.branches:
        yield from generate_path(b)
    path.pop()
yield from generate_path(t)
```



