# Lab 5 

## List Comprehensions

### Q1

给定两个长度相等列表,将其内部的数据成对的组成一个大列表(使用列表推导式)

```python
return [[s[i],t[i]] for i in range(len(s))]
```

## Data Abstraction

### Q2

计算两个城市之间的距离(使用数据抽象)

```python
x1, y1 = get_lat(city_a), get_lon(city_a)
x2, y2 = get_lat(city_b), get_lon(city_b)
dis = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
return sqrt(dis)
```

### Q3

给定坐标,比较两个城市哪个离坐标最近

```python
city_c = make_city('Compare',lat,lon)
distance1 = distance(city_c,city_a)
distance2 = distance(city_c,city_b)
if distance1 <= distance2:
    return get_name(city_a)
else: return get_name(city_b)
```

## Trees

### Q5

遍历树,找出是否有存有'berry'的结点(dfs一遍即可)

```python
if label(t) == 'berry':
    return True
if is_leaf(t):
    return False
for i in branches(t):
    if berry_finder(i):
        return True
return False
```

### Q6

在原先树的所有叶子结点上再添加n个结点,n个结点的序号放在leaves列表中,

思路:模仿给定的建树过程,递归建树(使用树的构造器)

```python
# 如果是叶子结点,直接返回一个由叶子结点为根,leaves中序号为叶子的树
if is_leaf(t):
    return tree(label(t),[tree(l) for l in leaves])
# 否则,遍历原树种的分支,将每个分支的叶子结点扩建后,重新加到现树根上
return tree(label(t),[sprout_leaves(branch,leaves) for branch in branches(t)])
```



## Optional Question

时间紧迫,这部分先跳过

