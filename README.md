# batfish-l2-topology-test

## Blog

* [BatfishでL2 Topologyを出せるかどうか調べてみる \- Qiita](https://qiita.com/corestate55/items/50ba0ae3e204d84fb03e)

## Network

### sample1

* different L2 segments

```
    host11    12    13    14       host21    22    23    24
     .101| .102| .103| .104|        .101| .102| .103| .104|
         |     |     |     |            |     |     |     |
   gi1/0/1     2     3     4            5     6     7     8
         |     |     |     |            |     |     |     |
       --+-----+-----+-----+-- VL100  --+-----+-----+-----+-- VL200
         |            192.168.1.0/24                 192.168.2.0/24
         |.1
       Vlan100
       GRT
```

### sample2

* same ip subnet but different L2 segment.

```
    host11    12    13    14       host21    22    23    24
     .101| .102| .103| .104|        .101| .102| .103| .104|
         |     |     |     |            |     |     |     |
   gi1/0/1     2     3     4            5     6     7     8
         |     |     |     |            |     |     |     |
       --+-----+-----+-----+-- VL100  --+-----+-----+-----+-- VL200
         |            192.168.1.0/24    |            192.168.1.0/24
         |.1                            |.1
       Vlan100                         Vlan200
       GRT                             VRF(user2)
```

## Resources

### commands

```python
from pybatfish.client.commands import *
from pybatfish.question.question import load_questions
from pybatfish.question import bfq
load_questions()

# sample1
bf_init_snapshot('/path/to/batfish-l2-topology-test/sample1', name='sample1', overwrite=True)

# sample2
bf_init_snapshot('/path/to/batfish-l2-topology-test/sample2', name='sample2', overwrite=True)

# layer3
ans = bfq.edges(edgeType='layer3')
ans.answer().frame()

# layer1
ans = bfq.edges(edgeType='layer1')
ans.answer().frame()

# select edges by host name
df = ans.answer().frame()
df.loc[list(map(lambda d: d.hostname=='host11', df.Interface.values))]
```
