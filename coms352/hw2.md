# HW 2
###### 1. 
- I/O bound are more likely to have voluntary context switches because they need less time on the CPU so they have more of a chance to finish their job before the time slice has ended
- CPU bound are more likely to have nonvoluntary context switches because they need more time on the CPU so they have more of a chance to not have finished their job before the time slice has ended
###### 2.
- FIFO queue cannot result in starvation because every process that comes later never has priority over the processes that come first, so have many I/O bound processes can never starve the CPU bound process
- STCF can result in starvation because it always takes the smallest job and prioritizes it first, so many small I/O bound processes will always be prioritized first, so the CPU bound process will never work
- RR can not result in starvation because each job is always given an allotted time slice, so every job is given the exact same amount of time, so many I/O bound processes cannot stop a large CPU bound process from stopping
- Lottery can result in starvation because if there are so many I/O bound processes and one CPU bound processes, it can happen that the CPU bound process is never picked, so it is never worked on
###### 3.
STCF will always be more efficient when there are many jobs, because RR always has more `os_overhead` because it needs to have constant context switches every time interval, whereas the STCF only has to switch when the job is done
###### 4.

