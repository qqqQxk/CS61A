# Project3 Ants Vs. SomeBees

## 核心概念

1. **地图** 整个地图类似PVZ的草地,最右方是蜂巢和蜜蜂,左方可以放置蚂蚁
2. **place** 玩家可以在每个地方放置一只蚂蚁。但是，一个地方可以有很多蜜蜂。
3. **蜂巢** 蜜蜂的出发点。
4. **蚂蚁** 蚂蚁是游戏中玩家放入地图的可用部队。每种类型的蚂蚁都会采取不同的行动，放置需要耗费不同的食物量。两种最基本的蚂蚁类型是收割蚁，它在每回合向蜂群添加一种食物，以及投掷蚁，每回合向蜜蜂扔一片叶子。您将实施更多
5. **蜜蜂** 蜜蜂是游戏中的敌对部队，玩家必须保卫地图。如果没有蚂蚁挡路，蜜蜂就会前进到隧道中的下一个地方，或者它会蜇伤挡路的蚂蚁。当至少有一只蜜蜂到达隧道尽头时，蜜蜂获胜

## Class

1. GameState：表示地图和有关游戏的一些状态信息，包括可用的食物量、经过的时间、蚁后居住的位置以及游戏中的所有地点。
2. Place：表示存放昆虫的单个地点。最多一只蚂蚁可以在一个地方，但在一个地方可以有很多蜜蜂。放置对象在左侧有一个出口，在右侧有一个入口。蜜蜂通过移动到一个地方的出口来穿过隧道。
3. Beehive：代表蜜蜂开始的地方（在隧道的右侧）。
4. AntHomeBase：代表蚂蚁防守的地方（在隧道的左侧）。如果蜜蜂来到这里，则会输掉游戏
5. Insect：蚂蚁和蜜蜂的共同职业父类。所有昆虫都有一个护甲属性，代表它们剩余的生命值，还有一个place属性，代表它们当前所在的地点。每个回合，游戏中每只活跃的昆虫都会执行其动作。
6. Ant：代表蚂蚁。每个 Ant 子类都有特殊属性或特殊操作，以区别于其他 Ant 类型。例如，一只收割蚁为蚁群获取食物，一只投掷蚁攻击蜜蜂。每种蚂蚁类型还有一个food_cost属性，指示部署该类型蚂蚁的一个单位的成本。 
7. Bees：代表蜜蜂。每个回合，如果没有蚂蚁挡住它的路径，蜜蜂就会移动到当前位置的出口，或者蜇伤一只挡住它路径的蚂蚁

## Phase 1

### P1

在Ant的子类中增加对应的cost_food属性,在HarvesterAnt的action函数中使food+1

### P2

构造Place时,如果当前Place有exit(即exit不为None),则将出口的入口绑定为当前Place

### P3

实现投掷蚁的攻击功能,每次选择前方离自己最近的的一个格子上的蜜蜂攻击(如果蜜蜂有多个就随机选一个)

```python
# 投掷蚁继承了insect的place属性,可以获得自己的位置
p = self.place
bees = []
while p is not beehive:		# 从当前位置往蜂巢位置找
    if p.bees:				# 如果这个位置有蜜蜂,就退出区选一个
        bees = p.bees[:]	
        break
    p = p.entrance
return rANTdom_else_none(bees) # REPLACE THIS LINE
```

## Phase2

### P4

实现投掷蚁的两个变种:

1. 长投掷,只能攻击五个距离外的敌人
2. 短投掷,只能攻击当前位置到三个距离内的敌人

**要求**:在ThrowerAnt中设置min_range, max_range,配合nearest_bee来实现

```python
# ThrowerAnt中增添类属性
min_range, max_range = -float('inf'),float('inf')
# 更改原先的nearest_bee函数
p = self.place
bees = []
i = 0
while p is not beehive:
    if p.bees and self.min_range <= i <= self.max_range:
        bees = p.bees[:]
        break
    p = p.entrance
    i += 1
return rANTdom_else_none(bees) # REPLACE THIS LINE
# ShortThrower增加类属性
min_range = 0
max_range = 3
# LongThrower增加类属性
min_range = 5
max_range = float('inf')
```

### P5

实现火蚁,当前位置被攻击时,将伤害返回给当前位置的所有蜜蜂,如果火蚁死亡,则额外造成伤害

```python
cause_damage = amount
if self.armor - amount <= 0:
    cause_damage += self.damage
for b in self.place.bees[:]:
    Insect.reduce_armor(b,cause_damage)
# 火蚁最好放到最后再死,否则上面的self.place会提前置为None
Ant.reduce_armor(self, amount)
```

## Phase3

### P6

实现饥饿蚁,当其不在消化过程中时,吃掉一个当前位置的蜜蜂并进入消化状态

```python
time_to_digest = 3		# 类属性
    def __init__(self, armor=1):
        self.digesting = 0		# 初始时消化时间设置为0
        Ant.__init__(self,armor)

    def eat_bee(self, bee):
        Insect.reduce_armor(bee,bee.armor)		# 直接消灭当前蜜蜂

    def action(self, gamestate):
        if self.digesting:		# 当前在消化中,时间减一
            self.digesting -= 1
        else:
            # 挑一个当前位置的蜜蜂吃掉
            b = rANTdom_else_none(self.place.bees)
            if b is not None:
                self.eat_bee(b)
                self.digesting = self.time_to_digest
```

### P7

实现防御蚁类,很简单,设置名称,食物消耗情况,构造函数...

```python
class WallAnt(Ant):
    name = 'Wall'
    food_cost = 4
    implemented = True  # Change to True to view in the GUI
    def __init__(self,armor = 4):
        Ant.__init__(self,armor)
```

## Phase4

### P8

增加水形场景,Insect class和Bee class都增加is_watersafe的类属性,实现add_insect方法(调用已有的函数进行实现)

```python
Place.add_insect(self,insect)
if not insect.is_watersafe:
    insect.reduce_armor(insect.armor)
```

### P9

实现防水的蚂蚁

```python
class ScubaThrower(ThrowerAnt):
    name = 'Scuba'
    food_cost = 6
    is_watersafe = True
    implemented = True  # Change to True to view in the GUI
```

### Extra

完成蚁后类,以下是一些要点或注意事项(写到这里对各类的继承关系已经有点昏头了)

1. 构造函数应该调用ScubaThrower的构造函数
2. 类属性应该使用类名.属性访问
3. 蚁后也属于投掷蚁的一种,行动时会攻击敌人
4. 真蚁后或冒充者在生命都可以使用继承来的reduce_armor方法来改变生命值
5. 样例中可能会主动调用remove_from方法,这个方法应该只能移除假蚁后

## Optional

### 1

忍者蚁,会隐身(不会挡蜜蜂的路),对每个路过的蜜蜂造成固定量的伤害

```python
def action(self, gamestate):
    for b in self.place.bees[:]:
        Insect.reduce_armor(b, self.damage)
```





