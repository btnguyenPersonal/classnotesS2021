# HW 2
###### 1. 
- I/O bound are more likely to have voluntary context switches because they need less time on the CPU so they have more of a chance to finish their job before the time slice has ended
- CPU bound are more likely to have nonvoluntary context switches because they need more time on the CPU so they have more of a chance to not have finished their job before the time slice has ended
###### 2.
- FIFO queue cannot result in starvation because every process that comes later never has priority over the processes that come first, so have many I/O bound processes can never starve the CPU bound process
- STCF can result in starvation because it always takes the smallest job and prioritizes it first, so many small I/O bound processes will always be prioritized first, so the CPU bound process will never work
- RR can not result in starvation because each job is always given an allotted time slice, so every job is given the exact same amount of time, so many I/O bound processes cannot stop a large CPU bound process from stopping
- Lottery cannot result in starvation because every process has a chance to execute based on how many tickets it has
###### 3.
STCF will always be more efficient when there are many jobs, because RR always has more `os_overhead` because it needs to have constant context switches every time interval, whereas the STCF only has to switch when the job is done
###### 4.
a.
| Job | Arrival Time | Runtime
|---|---|---
|A|0|20
|B|2|20
|C|5|5
|D|10|10

||00|05|10|15|20|25|30|35|40|45|50
|---|---|---|---|---|---|---|---|---|---|---|---|
|FIFO|A|A|A|A|B|B|B|B|C|D|D
|SFJ|A|C|D|D|A|A|A|B|B|B|B
|STCF|A|C|D|D|A|A|A|B|B|B|B
|RR|A|B|C|D|A|B|D|A|B|A|B

b.

FIFO
| Job | Arrival | Running | Completion | Turn around
|---|---|---|---|---
|A|0|20|20|20
|B|2|20
|C|5|5
|D|10|10
//TODO

##### 5.
|Job|Arrival Time|Runtime
|---|---|---
|A|0|200
|B|5|20
|C|10|10
|D|50|10
```
   00 10 20 30 40 50 60 70 ... 240
Q2 A  B  C        D
Q1          A        B
Q0                      A
```

##### 6.
- A is less nice so its vruntime grows more slowly with actual time
- Therefore, it will run for more actual time than B which has the same vruntime
