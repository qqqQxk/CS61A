# Lab 7

## Iterators and Generators

### Q1

yield生成it和指定数的乘法

```python
for i in it:
    yield i * multiplier
```

使用yield from,可以利用map函数

```python
yield from mao(lambda x: x * multiplier, it)
```

### Q2

递归生成器,注意在函数前面使用yield from

```python
yield n
if n != 1:
    if n % 2 == 0:yield from hailstone(n // 2)
    else: yield from hailstone(3 * n + 1)
```

## Magic: The Lambda-ing

### Q4

实现Card类的构造函数和power方法

```python
self.name = name
self.attack = attack
self.defense = defense
```

```python
return self.attack - other_card.defense / 2
```

### Q5

调用Deck的draw进行随机抽牌,init中抽五张,draw中抽一张,play打出一张

```python
# __init__
self.hand = [deck.draw() for _ in range(5)]
# draw
self.hand.append(self.deck.draw())
# play
card = self.hand.pop(card_index)
return card
```

## Optional Question

### Q6

实现导师牌效果,让对手丢弃前三张牌,再抽取三张牌

```python
for _ in range(3):
    opponent.play(0)
for _ in range(3):
    opponent.draw()

print('{} discarded and re-drew 3 cards!'.format(opponent.name))
```

### Q7

交换TA牌的攻击和防御

```python
other_card.attack,other_card.defense = other_card.defense,other_card.attack
```

### Q8

教授牌将对手卡牌的攻击和防御添加到己方牌组中的所有牌中,然后删除对手牌组里与对手卡牌具有相同攻击或防御力的所有卡牌.

**enumerate()函数**

将一个可迭代的对象（如列表、元组或字符串）组合为一个索引序列，同时列出数据和数据下标，一般用在 for 循环当中。

```python
value = ["a","b","c"]
for index, value in enumerate(values):
    print(index, value)
"""
0 a
1 b
2 c
"""
```



```python
attack, defense = other_card.attack,other_card.defense
lst = player.deck.cards
i = 0
# 将对方攻击防御力加到己方卡牌组中
while i < len(lst):
    lst[i].attack += attack
    lst[i].defense += defense
    i += 1
optlst = opponent.deck.cards[:]
# 删除对方卡牌组里的牌
for index, item in enumerate(optlst):
    if item.attack == attack or item.defense == defense:
        opponent.deck.cards.remove(item)
discarded = orig_opponent_deck_length - len(opponent.deck.cards)
```

