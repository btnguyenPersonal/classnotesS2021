# Intro to Operating Systems

By Matt Tancreti

Operating Systems are mostly written in C

Each process can get virtual CPUs

Memory Virtualisation - programs can write anywhere in the memory

## Program vs Process

_program_ is instructions stored on the disk &rarr; an executable file

_process_ is a running program

| Memory          | CPU             |
| :---:           | :---:           |
| Stack           | Registers       |
| Heap            | Program Counter |
| Code            | Stack Pointer   |
| Static Data     |                 |
| process id      |                 |
| state = RUNNING |                 |

__Registers__ &rarr; data stored directly on CPU

__Program Counter__ &rarr; which instructions are executed next

__Address Space__ &rarr; where data is stored in memory

__Stack and Frame Pointer__ &rarr; what are the parameters of functions?

## Scheduler

The scheduler is part of the OS

Job is to make sure that only one program is running at once

Context Switch

  Save CPU context of descheduled process

  Load CPU context of descheduled process

Every process must have a _parent_

  When a process is deleted it goes into zombie state, because it may need the exit id

## POSIX (Portable Operating System Interface)

Standard programming interface provided by UNIX like system

## `fork() //Process Creation`

```c

pid_t fork()

```

```c

printf("A");
fork();
printf("B");
[~]$ A
B
B

```

Creates a new process by duplicating the calling process

Child process has a copy of parent's address space

On Success

  Both parent and child continue execution at the point of return from `fork()`

  `return pid of the child process` to the parent process

  `return 0` to child process

On Failure:

  Does not create child and `returns -1`

Scheduler picks which parent or child process goes first

___Note___: Calling `fork()` twice will create 4 processes

## `wait() // Wait for Child`

```c

pid_t wait(int *wstatus)

```

Suspend execution for he parent until one of its children terminates

On Success

  Returns pid of the child process that terminated

## `exec() // Change the Program`

```c

int exec(const char *pathname, char *const argv[]);

```

Replaces the current program with a new one, command line args are passed in argv

example usage:

```c

char *argv[] = {"wc", "README",0};
exec('wc", argc);

```

# Interprocess Communication

## `|||||||||||||||||||||||||PIPES|||||||||||||||||||||||||`

```sh

status () {

  echo -n " $(amixer | grep 'Front Left:' | awk '{print $5}') \
  $(date '+%m/%d/%Y ')$(date '+%r' | awk '{print $1}' | \
  sed s/:[0-9][0-9]$//) $(date '+%r' | awk '{print $2}') "

}

```

## `pipe() // Connect two processes`

```c

int pipe(int p[2]);

```

On Success

  New file descriptor points to source of provided file descriptor

  Returns new file descriptor

On Failure

  Returns -1

## Limited Direct Execution

__Time-sharing__ &rarr; each process can share the CPU so each can make progress

## How do processes share time?

  multiprogramming - when a process waits for I/O, the OS can have another take of the CPU

  multitasking - each process gets a time-slice, a time limit before the next process gets to execute on the CPU

## How does the OS keep control?

  Hardware provides interrupts, kernel mode, and user mode to keep the user in control

## Direct Execution

Lets the code do everything on the computer

CPU has bit that indicates if in _user mode_ or _kernel mode_

  Cannot read/write outside of address space bounds

  Cannot read/write I/O devices

When in kernel mode, all instructions allowed

Normal processes only execute in user mode, the OS executes in kernel mode

## Process mode

Protects the computer from altering sensitive data

## System Call

Problem: how can users perform privileged operations?

## Jobs

Real processes alternate between needing CPU time and waiting for I/O

Jobs with Time-Sharing, can switch between them when needed

__Preemption__ will kick off processes in the middle of a job before it's done to make sure that other jobs can be done

Metrics

  Time of arrival &rarr; job first enters ready state

  Time of completion &rarr; time when job finishes

  Time of first run &rarr; time when job starts its first run on the CPU

  __Turnaround Time__ = __Time of completion__ - __Time of arrival__

Why different metrics?

  __Turnaround time__ &rarr; tells time to complete jobs, good for CPU bound processes, where getting enough CPU runtime is the main concern

  __Response time__ &rarr; tells how long to respond to I/O, good for I/O bound(interactive) processes, which have short CPU bursts and frequent I/O

  There are other metrics, later we will look at _fairness_

FIFO

  Always pick out job that comes first

  Preemption: None

  Advantage: Easy to implement

  Disadvantage: Large upfront CPU processes can hurt turnaround and response time

Shortest Job First (SJF)

  Always pick out the shortest by job length

  Preemption: None

  Advantage: Optimal average turnaround and response time when all jobs arrive _at the same time_

  Disadvantage: If short jobs arrive after starting a long job?

Shortest Time-to-Completion first (STCF)

  like SJF, but when a new job comes in, it will kick that job off first

  Preemption: if a new job arrive with a shorter time to completion, it preempts

  Advantage: short jobs don't need to wait for a long job to complete

  Disadvantage: sometimes response time can be bad (Bad for I/O bound processes)

Round Robin (RR)

  Implementation: FIFO queue

  Preemption: Job on CPU gets __time-slice__, preempt when time expired

  Advantage: Low response time, Guaranteed response time

  Disadvantage: high turnaround time, and frequent context switches reduce CPU efficiency

Problem with SJF and STCF: Oracle

  Scheduler doesn't know how long it will take for a job to complete

  SJF and STCF needs the ability to see into the future

Multi-Level Feedback Queue

  SJF and STCF have good features, but they require oracle vision and they have serious flaws for some workloads

  RR has low response time, but it treats all jobs equally which can result in poor turnaround time and frequent context switches

  __Rule 1__ &rarr; `if Priority(A) > Priority(B), A runs and B doesn't`

  __Rule 2__ &rarr; `if Priority(A) = Priority(B), A and B run in RR`

## Examples of Common Processes

Process 1: waits for user to press key, performs short task such as adding char to display buffer and then waits for next key press.

Process 2: Perform a long math computation

## CPU bound vs I/O bound processes

  Jobs that need fast response but little CPU time should be highest priority

  Jobs that need long CPU time and little I/O should be lowest priority



## Adding Feedback to Multi-Level Queue

![](../pic/multilevelqueue.png)

  __Rule 3__ &rarr; When a job enters the system, it is placed at the highest priority (the topmost queue)

  __Rule 4a__ &rarr; If a job uses up an entire time slice while running, its priority is reduced

  __Rule 4b__ &rarr; If a job gives up the CPU before the time slice is up, it stays at the same priority level.

## Problem: Starvation

  ![](../pic/starve.png)

  What happens if we turn up the rate of I/O bound jobs?

  One job can freeze if there are too many I/O jobs

## Priority boosts

  ![](../pic/priorityboost.png)

  __Rule 5__ &rarr; After some time period S, move all the jobs in the system to the topmost queue

## Problem: Gaming the System

  ![](../pic/gamingsystem.png)

  Smart programmers will catch on: ___"I can make my application run faster if I never let a complete quanta expire"___

  Could add some randomness to the quanta

## Optimization: Lower Priority, Longer Quanta

  ![](../pic/optimizequanta.png)

  Longer quanta in the lower queues can reduce frequency of context switches

# The Complete MLFQ

  __Rule 1__ &rarr; `if Priority(A) > Priority(B), A runs and B doesn't`

  __Rule 2__ &rarr; `if Priority(A) = Priority(B), A and B run in RR`

  __Rule 3__ &rarr; When a job enters the system, it is placed at the highest priority (the topmost queue)

  __Rule 4__ &rarr; Once a job uses up its time allotment at a given level (regardless of how many times it has given up the CPU), its priority is reduced (i.e., it moves down one queue).

  __Rule 5__ &rarr; After some time period S, move all the jobs in the system to the topmost queue

## Fair Scheduling

  Each job is assigned numbered _tickets_

  Every time slice, scheduler randomly picks a winning tickets and the job runs for that time slice

  Over time, jobs runtime is proportional to percent of tickets held

### Lottery scheduler doesn't assign priorities how to assign tickets

  In effect, the lottery scheduler is a kind of priority scheduler

 - More tickets means higher priority

 - But, fairer than priority, low ticket jobs can't be completely starved

  For example, how can we create the effect of SJF?

 - Assign number of tickets inversely proportional to each job's runtime

  __Pros__: No job can be starved, everyone gets their fair share of runtime

  __Cons__: A short job can be unlucky and have higher response time

## Stride Scheduling

  Lottery has good fairness over the long run, but randomness can result in suboptimal choices over a short time

  __Stride Scheduling__ is deterministic (not random) but has same fairness

  For each job set its __stride__ is $(10000/ numTickets)$

  Every time a job executes, increment it's _pass_ counter by its _stride_

  Scheduler always picks the job with the lowest pass counter to run next

## Linux Completely Fair Scheduler (CFS)

  CFS gives a proportion of CPU time to each process, there are two questions

  When to preempt the currently running process?

 - Every process assigned a time slice within one `sched_latency`

      - If equal priority, each process gets a $1/N$ slice of `sched_latency`

      - Therefore, every process should run atleast once in `sched_latency`

      - ___Note___: `sched_latency` is scheduler latency

  Which process to run next?

 - The process with the smallest __virtual runtime (vruntime)__

## Nice Values

  Nice value set by user to indicate "priority", weights the $1/N$ time slice a process gets before preemption

```c

current_time_slice =
    current_weight / processes_weights_total * sched_latency

```

  Lower nice value will receive larger time slice

  Higher nice value will receive smaller time slice

  `time_slice` of all processes still add up to `sched_latency`

## Virtual Runtime

  weighted version of the real runtime of each process

  ```c

  vruntime = vruntime + (weight ratio based on nice value) * runtime

  ```

  If nice = 0: weight ratio = 1 and vruntime = actual run time

  if nice < 0: weight ratio < 1 and vruntime < actual run time

  if nice > 0: weight ratio > 1 and vruntime > actual run time

## Efficiency

  Scheduler gets called often, efficiency matters

  CFS uses _binary search_ tree to quickly find process with lowest runtime

## Multiprogramming

  Processes share main memory

  Simplest scheme is to assign contiguous regions of memory

  Becomes costly when a process needs to grow its memory

## Process Address Space

  A processes view of memory is called its _address space_

  Address space starts at 0

  Address space is contiguous

  All address available at any time

  At the top are static items(code, global variables, and constants)

  Also need stack which comes from the bottom

## Memory Virtualisation

  ![](../pic/memoryreloc.png)

  in reality, the memory for each process is broken up a lot

  However, the OS handles everything so we don't have to think about it

## Base and Bounds Translation

  ```c

  128: mov 1000, %eax

  ```

  1. program counter is incremented to 128

  1. CPU beings fetching instructions by reading from address 128

  1. MMU translates 128 to 32,896 and memory is read

  1. CPU decodes instruction and requests a read from address 1000

  1. MMU translates 1000 to 33,768 and memory is read

  1. CPU finishes execution of instructions

## Exception Handling

  Memory access out of bounds results in a trap

  OS typically terminates process

## Hardware Requirements

  | Hardware Requirements | Common Implementation |

  |---|---|

  | Privilege mode | Kernel mode

  | Base and bounds registers

  | Translate virtual address | MMU intercepts all addresses between

  | Privileged instructions to update base and bounds |

  | Ability to raise exceptions |

## Segmentation

  Base and bounds means direct translation from address space to physical memory

  Assumes program knows in advance how much dynamic memory will be required

  Growing process's memory dynamically is very difficult

  > How to remove limitations of physical memory from address?

  Problem

 - What happens when address space is full?

 - Using base and bounds, process needs to be copied to a larger space in memory

 - All pointers need to be updated!

```c

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("code %p\n", main);
  printf("heap %p\n", malloc(1));
  printf("stack %p\n", &argc[1]);
  return 0;
}

```

Solution:

  Just make the address space massive (up to limits of addressable size)

---

  Just like memory virtualisation, can put anything anywhere

| 13  | 12  | 11  | 10  | 9   | 8   | 7   | 6   | 5   | 4   | 3   | 2   | 1   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S   | S   | O   | O   | O   | O   | O   | O   | O   | O   | O   | O   | O   |

S = Segment

O = Offset

## Independent Direction of Segment Growth

  We can even allow segments to grow in different directions

  A set of registers can indicate if a segment grows up or down

  ![](../pic/fragmentmemory.png)

## Sharing

  Protection registers can enable sharing

  Example: two processes are executing the same code. If code segment is read-only no danger of processes corrupting each other

  |Segment|Base register|Size register|Grows Positive?|Protection|

  | ---   | --- | --- | --- | ---          |
  | Code  | 32K | 2K  | 1   | Read-Execute |
  | Heap  | 34K | 2K  | 1   | Read-Write   |
  | Stack | 28K | 2K  | 0   | Read-Write   |

## Free Memory

  Segments are in contiguous regions of physical memory

  To allocate a new segment, OS must keep a list of free memory

  Simple solution is a linked list of free regions of memory

  On a new allocation search for first open spot that has sufficient memory(first fit strategy)

  Best fit strategy searches for smallest regions of free memory that will fit the segment

## Fragmentation

  Segmentation made code, stack and heap independently relocatable

  Segments can become arbitrarily large contiguous

  Resulted in external fragmentation

  Small gaps that are not big enough to put anything there

## Paging

  Address space divided into equal sized pages that can be stored in frames

  ![](../pic/paging.png)

## Page Table

  __Virtual Page Number (VPN)__ is the index of the table

  __Physical Frame Number (PFN)__ points to the frame in physical memory

  __Valid bit__ indicates if table entry is valid(not all of address space needs to be mapped)

  Makes it easy to grow and shrink our process memory, just get to a new page that can be located anywhere

  ---

  ![](../pic/pagetable.png)

## Virtual Address Bits

  Virtual address divided into VPN and offset

  ![](../pic/virtualaddress.png)

  ![](../pic/vpnbits.png)

  If total address space is $2^m$ bytes and page size is $2^n$ bytes

 - VPN is m-n bits

 - offset is n bits

  ___Question___: If address space is $1GB$ and page size is $4KB$ how many bits in the VPN?

 - Answer: $1GB$ = $2^{30}$, $4KB$ = $2^{12}$, therefore VPN is $30-12=18$ bits

 - Check: $4KB$ $\times$ $2^{18}$ = 1GB

  ---

  ![](../pic/physoffset.png)

## Address Translation

  ![](../pic/addrtranslation.png)

## Unused Pages

  Unused pages don't need to be mapped to physical memory

  Process is unaware of pages, when it requests more memory allocated for heap of stack the OS maps pages as needed

## Free Memory Management

  OS needs to know which frames are not in use, simple method is linked list

  No external fragmentation - no unusable gaps between frames

  ---

  ![](../pic/internalfrag.png)

## Page size

  Small page size means bigger page table (more page table entries)

  Bigger page size means more internal fragmentation

  Typical page size is 8KB in Linux

## Basics of the Heap

  Heap is managed at user level provided by language libraries

 - In C `malloc()` and `free()`

 - In Java `new` and the __garbage collector__

  ___Compaction___ (moving allocated spaces together and make larger contiguous free space) not possible for heap

## Problem of External Fragmentation

  want to allocate a 20 byte object, but nowhere to put a 20 byte object, an example of external fragmentation

  A __free list__ is used to track free fragments of memory

## Free space operations

  _splitting_ divides a free space into two parts so one part can be allocated

  _coalescing_ is merging contiguous free spaces into one



## Tracking Allocated Regions

  ```c

  typedef struct {
    int size;
    int magic;
  } header_t;

  ```

  __size__ &rarr; number of bytes allocated to the program

  __magic__ &rarr; a secret number that can be checked to see if it is the start of the region

  __head__ &rarr; a pointer to the first free region of memory

  __next__ &rarr; points to the next free region of memory or 0 if it is the last region

  Linked list is embedded into the heap

## How to chose a free chunk?

  Is it always best to chose the first free chunk that fits?

  Strategies

 - Best Fit &rarr; find chunk that will result in least fragmentation

 - Worst Fit &rarr; find chunk that will result in the largest left over chunk

 - First Fit &rarr; find first chunk that fits

 - Next Fit &rarr; find the second best chunk that fits

  __Alternate Approaches__:

 - Segregated Lists - manage common sized objects separately

 - Buddy Allocation - tree like structure that allocates blocks in powers of 2

## TLB

  Page table is stored in main memory

  Every memory access requires additional read to loop up page table entry

  Store a cache of "popular" page table entries with the MMU hardware

  Cache can be accessed in single CPU cycle (main memory > 100 cycles!)

## TLB Cache

  Look for VPN in TLB cache

  If found (TLB hist) return entry

  Else (TLB hist) get entry from page table in main memory

  Store entry to cache (possibly replacing some other entry)

## Why does Cache work?

  Spatial locality &rarr; address of memory access is likely to be close to the previous access

  Temporal locality &rarr; addresses likely to repeat in time

## Why does spatial locality exist?

  __Sequential__ memory access is common

  ex: iterating through an array

  ```c

  for (int i = 0; i < count; i++) {
     sum += a[i];
  }

  ```

## Replacement Policy

  To add a new TLB cache entry we need to replace an old one, how to pick which to replace?

  Least-recently-used &rarr; replace the entry that was used the longest ago

  Random &rarr; replace a random entry

## Swap

  Users have expectation they can run many programs concurrently

  Memory requirements of all processes combined can easily exceed physical memory

  Observation

 - At any time, many idle processes

 - Only a few pages account for most memory accesses

  __Idea__: rarely used pages can be stored on disk

  ---

  How can OS take advantage of large slow disk space to give illusion of infinite space?

  ---

## Swap Space

  When physical memory is full, less used pages moved to swap space

  Swap space divided into blocks that can hold one page

  Preset Bit

 - Page table has __preset bit__ to indicate if page is in physical memory (`1`) or in swap (`0`)

## What to do when page not present?

  When a program tries to access memory that is on a page currently in swap a page fault occurs

  The page fault is just a trap, it is managed by OS code called the page-fault handler

  The page-fault handler needs to move the page back to main memory

  It may require making room by __swapping__ some other page into swap space

## Why not put everything on disk?

  Main memory is 100x slower than CPU

  SSD drive is 100x slower than main memory

  Swap enables large easy to use address spaces, but cost of page fault is enormous, really want to avoid page faults

## Replacement Policy

  Need to decide on page to evict (page out) so a page can be brought back to memory (page in)

  There are many page-replacement policies, just like we saw with TLB cache

 - FIFO

 - LRU

 - Random

## Proactive Free Space Management

  Assume main memory is full

 - What happens when use starts a new application?

 - Several page faults! Really slow!

  OS proactively moves pages to swap to always keep a small amount for memory free for responding to sudden activity

  Two thresholds high watermark and low watermark

 - When free memory drops below low watermark OS start background task to start pushing pages to swap space

 - Task stop when free memory passes high watermark

## How to make smaller page tables?

  __Idea:__ One Page table per segment

  - use segment number to determine which page table to use

  __Problems:__

  - Need to use segmentation (not as flexible as pure paging)

  - Page table size is now dynamic (it can grow and shrink with segment)

    - Needs to be managed as dynamic memory

    - External fragmentation between page tables

  __Idea:__ Multi-Level Page tables

  - Chop page tables into page sized units

  - Don't store page table unit where all page table entires are marked invalid

  - Keep a page table directory to record where page table units are located

  - Sub-page tables inside of page tables

  __Advantages:__

  - Grow number of page tables in proportion to size of allocated address space

  - Page tables parts fit into page size chunks of memory

    &rarr; __No external fragmentation__

  __Disadvantages:__

  - Indirection means one extra lookup step to find page table entry

  What about more than one level of indirection?

  - makes the page table size exponentially smaller

  Alternative: Inverted Page Table ___(SUCKS)___

  - Page table index is PFN which translates to VPN (inverted from normal page table)

  - All processes share one big page table

  - Lookup can be made faster using hashtable

## Replacement Policy

__cache hit__ &rarr; page is in main memory

__cache miss__ &rarr; page is in swap space instead

Reference Strings &rarr; if program accesses 0, 0, 0, 1, 1, 1, 2, 0, 1

  - Would be converted to 0, 1, 2, 0, 1

---

_Optimal Comparison_ (not real) &rarr; assume we can predict the future and always chose to evict the page that will be used furthest out (or any page that will never be used again)

First attempt is _FIFO_, despite simplicity not a good choice because causes paradoxical corner-case behavior known as _Belady's anomaly_

  - Advantage:
    - easy to implement and fast (O(1) operations) can be implemented in a fixed size cache using a circular buffer

  - Belady's Anomaly &rarr; more cache space gives a worse performance

Random &rarr; evict from cache at random

  - Advantages

    - easy to implement and fast

    - no corner cases

  - Disadvantages

    - sometimes will kick out a popular page and give lots of misses

LRU (least recently used)

  - evice the page used the least recently

  - Advantages

    - Better performance than FIFO

    - Provable that larger cache size is always a subset of smaller

    - No Belady's anomaly possible

  - Disadvantages

    - slow

    - accounting to do on every single page access

## So which is actually faster?

No locality (completely access was random)

  - Then all of the policies gives the exact same as random

  - cache that can store 50% of total pages only gives 50% hit rate

80-20 Workload (80% of accesses are of 20% of the pages)

  - A few pages get the most accesses

  - Most pages get a few accesses

  - LRU performs the closest to optimal, FIFO and RAND perform the same

Looping-Sequential Workload

  - Assume loop repeatedly reads pages 1 to 49 in increasing order

  - When a cache size is below 50, LRU and FIFO have same corner case that causes every access to be a miss

  - Random avoids corner cases

Clock Algorithm

  - LRU performs the closest in optimal for typical workloads, but it is really costly on every access

  - A way to approximate LRU cheaply

  - Add extra use bit to page table entry, on every memory access MMU set use bit of page to 1

  - When looking for page to evict

    - Visit pages in round-robin order

    - If page use bit is 0, chose that page to evict

    - Else set use bit to 0 and continue search

## Concurrency

2 types

  - Multiprogramming - to utilize the CPU efficiently when programs block for I/O

  - Multitasking - to give all programs a fair slice of the CPU and make progress

What about providing concurrency within a process?
  - Programs have tasks that need to block for I/O
  - Programs want to be responsive to the user while performing tasks in the background

  - Programs want to distribute their computations across multiple CPUs to complete faster

#### What is a thread?

  - multiple points of execution of a program within a single process

  - each thread has is own stack segment

  - Program, data, and heap are shared with the process

#### Thread Control Block

  - Everything that was learned for process scheduling, it is the same for thread scheduling

#### Concurrency vs Parallelism

__Concurrent__ means multiple threads making progress in time but may be implemented by time-sharing

__Parallel__ means multiple threads instructions executing independently on multiple CPU cores

- __Concurrency__ allows I/O overlap and responsiveness

- __Parallelism__ of threads enables performance increases

## Why use threads?

Threads provide more convenience and better performance

- Simple memory sharing (all threads share same data and heap)

- Lower cost of thread creation (don't need to allocate new address space, just stack)

- Lower cost of context switch (only stack and registers change)


// can switch at any of the three assembly instructions, so an interrupt can mess it up

```
                  mov 0x8049a1c, %eax
counter++; --->   add $0x1, %eax
                  mov %eax, 0x8049a1c
```

#### Bug: Race Condition

Storing and loading to the same shared variable, has problems with concurrency

## Thread library

__Thread library__ provides API for creating and manging threads

Can be implemented in two places

- Entirely in user space, the library requires no special OS suport

- OS supported, uses system calls to operate at kernel level

Examples of common thread libraries

- POSIX pthreads: can be implemented at user level or kernel level

- Windows threads: implemented at kernel level

- Java threads: JVM implements threads using thread libraries available on host system

## `pthread_create()`

New thread executes concurrently with the parent thread

The new thread runs until on of the following happens

- It returns

## `pthread_exit()`

Exits from the thread instead of just the process

## `pthread_join()`

Joins two threads into one

## Synchronizing threads

```c
while (n != *id);
```

This will keep asking if `n != id` until that is true

## Locks

Provide mutual exclusion to a critical section of code

Mutual excision - only one thread at a time

Critical section - a section of code that can only be executed by one thread at a a time and the thread must execute the code to completion before another thread can enter

- Shared variables can be used in a critical section

In pthreads a lock is called a __mutex lock__ (short for mutual exclusion)

```c
lock_t mutex; // globally allocated lock called mutex
...
lock(&mutex);
balance = balance + 1;
unlock(&mutex);
```

## Goals

__Mutual Exclusion__ - prevent mutliple threads from entering a critical section

__Fairness__ - does each thread contending for lock get fair opportunity to enter, do not want to starve a thread by always giving priority to others

__Performance__ - time overhead of entering and exiting critical section

## Simple Hardware Solution - Disable Interrupts

Simple solution is to disable interrupts

When thread has control of CPU it can only be preempted by hardware interrupt (OS is not running so has no control)

Many negative aspects

- Enable and disable interrupts are privileged instructions

- OS loses control - user program can keep CPU for as long as it wants

- Can result in important interrupts getting delayed or lost

```c
void lock () {
  DisableInterrupts();
}
void unlock () {
  EnableInterrupts();
}
```

## Simple Software Solution

```c
typedef struct __lock_t { int flag; } lock_t;

void init(lock_t *mutex) {
  // 0 -> lock is available, 1 -> held;
  mutex -> flag = 0;
}

void lock(lock_t *mutex) {
  while (mutex-> flag == 1) // TEST the flag
    ;                       // spin-wait (do nothing)
  mutex-> flag = 1;         // now SET it!
}

void unlock(lock_t *mutex) {
  mutex->flag = 0;
}
```

This has a race condition bug!

# Peterson's Algorithm

- A Software Solution that works!

```c
int flag[2];
int turn;

void init() {
  // indicate you inntend to hold the lock w/ 'flag'
  flag[0] = flag[1] = 0;
  // whose turn is it? (thread 0 or 1)
  turn = 0;
}
void lock() {
  // 'self' is the thread ID of caller
  flag[self] = 1;
  // make it other thread's turn
  turn = 1 - self;
  while ((flag[1-self] == 1) && (turn == 1-self))
        ; // spin-wait while it's not your turn
}
void unlock() {
  // simply undo your intent
  flag[self] = 0;
}
```

No race condition!

Problem: modern compilers will reorder code when it is safe to do so, so doesn't actually work with modern machine

## Hardware Support - Test-and-Set

Common hardware support is a test-and-set instruction

```c
int TestAndSet(int *old_ptr, int new) {
  int old = *old_ptr; //fetch old value at old_ptr
  *old_ptr = new; // return the new value;
  return old; // return the old value
}
```

## Using Test-and-Set to Build a lock?

```c
typedef struct __lock_t {
  int flag;
} lock_t;
void init(lock_t *lock) {
  lock->flag = 0;
}
void lock(lock_t *lock) {
  while (TestAndSet(&lock->flag, 1) == 1)
    ; // spin-wait (do nothing)
}
void unlock(lock_t *lock) {
  lock->flag = 1;
}
```

## Problem: Performance of Spinning

Uses CPU for indefinite amount of time

## Solution to Spinning - Yield

Solution is that waiting thread should voluntarily give up CPU

- After running all the round robin once, it will give yield for some time

## Problem: Fairness

So far, when multiple threads contending for lock the winner is up to chance

- Which ever one executes TestAndSet first

A more controlled method is a FIFO queue for thread waiting on lock

## Classic Concurrency Problems

Concurrency makes reasoning about code very difficult

There are several classic problems that have been created to illustrate issues in concurrency and common solutions

It is a good idea to study the solutions to these problems and use them as patterns in your code

## The Producer/Consumer (Bounded Buffer)

One or more producer threads generate data items and place them in a buffer

One or more consumers grab items from the buffer and consume them

Common example: a pipe between processes acts as a buffer

Mutex lock and unlock surrounding a put() and get() so only one can do put() or get() at a single time

Producers can wake up other producers with the if statement

To work, need to have two different conditions, and each will signal opposite type

## Sephamore

variable that provides both locking and signaling

restrict how many threads have access to the resource at any time

```c
sem_init(&s, pshared, 5); // init with 5 allowed to use

// decrease value by 1
sem_wait(&s); // try to get resource, if none available, wait until one is

//increment value by 1
sem_post(&s); // give up resource, signal one resource available
```

Use semaphore like lock

- init s to 1

- acquire s with sem_wait()

- acquire s with sem_post()

Because semaphore can be interpreted as being in one of two states, this is a __binary__ semaphore

## Readers-Writers Problem

Readers - can only read doc

Writer - can read or write to doc

#### Simple solution:

- can only have one writer to write at a time

- as many readers can read as you want

Two semaphors:

rw_mutex initalized to 1

- ensure writers can exclusively edit doc

read_count number of readers currently reading

mutex initalized to 1

- ensures readers can all read when they want

This solution has _starvation_ where readers can block out the writers

## Classic Problem: Dinning Philosophers

- 5 philosophers alternate between thinking and eating

## Broken Solution

![](../pic/dinningphil.png)

`getChop()` = left and right in get semaphore

`putChop()` = left and right in post semaphore

#### Problem:

all of the philosophers can pick the left chopstick, and then all are waiting for right chopstick, and none can get it.

## One solution

simple rule: Ph4 must pick up the right chopstick before the left

If cycle cannot form, then it works

## Common non-deadlock bugs

#### Atomicity violation

Try to use `thd->info`, but it can change inbetween the if and using

```c
Thread 1::
if (thd->info) {
  fputs(thd->info, ...);
}

Thread 2::
thd->info = NULL;
```

Need to have lock around the check and use

#### Order violation

One thing needs to happen before another

```c
Thread 1::
void init() {
  mThread = PR_CreateThread(mMain, ...);
}

Thread 2::
void mMain(...) {
  mState - mThread->State;
}
```

## Why does deadlock Happen?

- There needs to be a __circular wait__ for resources (like the dinning philosophers)

- Also needs __mutual exclusion__, when something gets access to a resource, nothing else can modify/use the resource

## I/O Devices

- I/O is much slower than CPU

## Main System Bus

```
< --- [CPU] --- [Memory] --- > memory bus
            |
< ----------- [Graphics] --- > general i/o bus (GPU)
            |
< -- [HDD] -------- [USB] -- > peripheral bus
```

```
< --- [CPU] --- [HDD] --- [Memory] --- [USB] --- >
```

#### Interrupts

- When disk is getting read, can instead switch to another process while waiting for disk to finish

- Without interrupts, has to do a _spinning loop_ and just wait until disk is done

## Direct Memory Access (DMA)

- Kind of like a second CPU just for transferring memory to things around the bus instead of just using the CPU for everything

## Hard Disk Drive

HDD have been the main form of persistent data storage for decades

file systems were developed around their behavior

address space of the drive is divided into 512-byte blocks called sectors

Writing to a block is atomic

- Either write to block fully succeeds or it doesn't change anything

- No partial write to block, even if power goes out in the middle

Multi-sector reads and writes are supported, but no guarantee of atomicity

- If power goes out during multi-sector write, __torn write__ possible

__Platter__ - circular hard surface where data is stored using magnetic persistence

__Surface__ - platter has a top and bottom surface, both can store data

__Track__ - a single circle around center, a surface consists of thousands of tracks

__Spindle__ - the center of the platter which connects to a motor

__Disk Arm__ - moves the head across the platter to select a specific track

__Disk Head__ - transforms the magnetic field into electrical current

## Latencies

__Rotational delay__ - time for sector to rotate under the disk head

__Seek time__ - time for disk arm to change position to the correct track

## Random vs Sequential

__Random__ - software requests addresses in any order it chooses

- can result in very high seek time

__Sequential__ - software requests addresses in increasing

- only need to seek for the first access

## Scheduling

Multiple processes making concurrent threads can result in frequent seeking

Order of requests by an application can also increase seek time

Solution is to use a scheduling process

- Maintain an ordered queue of I/O requests by track

- Shortest Seek Time First (SSTF) - pick requests on the nearest track to complete first

## File System API

__File__ -  an array of bytes given an identifier (inode number)

__Directory__ - A list of (user-readable aname, inode number) pairs that is also given an inode

## Creating File (POSIX API)

```
int fd= open("foo", O_CREAT|O_WRONLY|O_TRUNC|S_IRUSR|S_IWUSR);
```

Open system call takes a file name and options. The file will be opened in the __current working directory__

File descriptor - an identifier the process uses to reference the file when making system calls (read() and write()).

Think of a file descriptor as a pointer to an object that maintains the location of the file.

## Support for Concurrent Access

xv6 uses a lock for each file so only one process can be accessing a file at one time

## File System Metadata

inodes - contains information about a particular file

data bitmap - stored which blocks are free/used in the data region

inode bitmap - stores which blocks are free/used in the metadata region

super block - contains information about the file system

## Very Basic File System (VBFS)

Very small amount of data is for the storing of the file metadata(date created, where it is)

## Contiguous vs Block Allocation

- Contiguous has problem of _external fragmentation_

- Block has problem of _internal fragmentation_

## Multi-level indexing

Have some direct pointers in the initial inode, and it also stores a single and double indirection

- Pros: Faster access to initial part of files, and also can store really big files

## Basic Performance Improvements

Caching - holds the popular blocks to decrease number of reads/writes

First file system was complete trash

## Consequence of Fragmentation

Block based allocation means files can become spread out over the disk

Best performance is when files are written to contiguous memory

## Cylinder Group

Cylinder is a stack of tracks near to each other on the drive

## Block groups

Block groups are consecutive portions of the disk's address space

## Berkeley Fast File System (FFS)

Principle: _keep related stuff together_

Two heuristics to improve performance:

- Try to allocate data blocks for a file in the same block group as the files inode

- Try to locate files that are together in a directory in the same block group

## Path locality

FFS heuristics are based on another form of locality

Path Locality - consecutive file accesses are likely to be two file paths that are near to each other

## Large File Exception

Large file will completely fill block group, preventing files in same directory being in same group

## SSD

made from flash memory

no moving parts

need to erase before a write

Bank = multiple blocks

Block = 128KB usually and consists of multiple pages

Page = 4KB usually

Individual bits stored in cells

## Basic Flash Operations

Read (page) - client provides page number to read, relatively fast, does not depend on location of page or previous page

Erase (block) - before programming the block must be set to all 1, orders of magnitude slower than read

Program (page) - writes the page by setting 1's to 0's where needed, time is somewhere between a read and an erase

In General, SSD much faster than HDD

## Wear out

Wear out is the issue that a flash block has a limited number of times (100,000) it can be erased before it becomes unusable

SSD mitigates this problem with __wear leveling__

- logic page address is independent of physical page on flash

- every time a page is written a new physical page is used to store the logic page

- in this way a logic page can be written to 100,000 times but every write is to a physical location

## Flash Translation Layer (FTL)

Virtualises the flash (mapping logical address to virtual address)

Large time cost of erasing a block before pages can be written

Want to have wear leveling

In __log-structured FTL__ an in-memory table is used to map virtual to physical pages

On every write the page is moved to a different physical location

## Garbage Collection

If the same logical page is written multiple times, the old versions of the page will remain in physical memory as garbage (unusable)

Garbage Collection is reclamation of dead blocks

## Mapping Table Size

Mapping table can be very large

Assume 1TB SSD and 4 byte entry for each 4KB page, then map is 1GB

A hybrid mapping approach can map at either the page or block level, far fewer blocks so less mapping required

## Crash Consistency

Only inode and bitmap are written to disk - inode and bitmap are consistent, but data has garbage

Only inode and data block are written to disk - the bitmap has not been updated to allocate the data block, in future data block could be overwritten

Only bitmap and data block are written to disk - space  is allocated but not used, will never be freed

## Crash recovery with File System Checker

Unix tool __fsck__ (file system check) is used to check and fix file system on boot

Disadvantage - need to check entire file system, slow for big file systems

## Journaling (Write-ahead logging)

Second Strategy, before making any change to the file system, first store a note to the disk about what operations are about to be performed

Write ahead of the operation into a log, thus the name write-ahead logging or journaling

If crash occurs you know from logs exactly what needs to be checked and fixed, no need to scan entire file system for errors

## Physical Logging

In physical logging the complete contents of the update are first written to a log

Have both a Journal write __before__ and __after__ the writing to disk, for confirmation

To speed up file system, blocks can be written out of order

## Journal Steps

1. Journal write - write the contents of the transaction

2. Journal commit - write the transaction commit blocks

3. Checkpoint - write the commit data and post that the transaction is done

## Recovery

## Security

System is secure if resources are used and accessed as intended under all circumstances

## Requirements of Security Mechanisms

Confidentiality: information maintained by a computer system that is accessible only by authorized parties

Integrity: a computer system's resources can be modified only by authorized parties

Availability: a computer system can be accessible at required times by authorized parties

Authenticity: a computer system can verify the identity of a user

## Security Violation Categories

Breach of confidentiality

Breach of integrity

Breach of availability

Theft of service

Denial of service

## Program Threats

Malware

Trojan Horse

Spyware

Ransomware

__Principle of least privilege__ - only give a user the bare minimum that they need to run the tasks they need

Sniffing - interrupt communication

Masquerading - pretend to be sender

Man-in-the-middle - interrupt the communication in the middle

## Denial of Service

(DDoS) send simple message that causes the server to do a lot of work

## Cryptography

needing key to decrypt everything

__Symmetric System__ - $E_k$ = $D_k$, so the key must be kept secret

__Asymmetric System__ - $E_k$ != $D_k$, $E_k$ can be made public; $D_k$ is secret and can't easily be derived from $E_K$

- $E_k$ is a public key

- $D_k$ is a private key

## How to agree on a key?

Can't without an asymmetric system

Everyone can share their public keys, then send an encrypted message from that, and only they can see.

## Symmetric Encryption Algorithms

DES most common before (56-bit key), but insecure now

NIST adopted AES (128 bit key)

- machine that could crack 56-bit DES in 1 second, would take 149 trillion years to crack AES key

## Hash functions

$h(p) = C$

- Should be very hard to reverse hash function

$h'(C) = p$

Public-key encryption based on each user having two keys:

- public key - published key used to encrypt data

- private key - key known only to individual user used to decrypt data

No efficient algorithm for finding the prime factors of a number

## Authentication

how do you know they are who they say they are

### AP 1.0

- Alice to Bob: "I am Alice"

- Problem: intruder can also send such a message

### AP 2.0

- Authenticate IP address

- Problem: IP Spoofing (send IP packets with false address)

### AP 3.0

- Use secret password

- Problem: Trudy can intercept Alice's password by sniffing packets

### AP 3.1

- Use symmetric encrypted password

- Problem: can still get the encrypted message and just send at later date

### AP 4.0

- Solution: pick a "once-in-a-lifetime" number (nonce) for each session symmetric key

### AP 5.0

- Use AP 4.0 but with asymmetric keys

## Access Control

__Access Control__ is regulating what actions subjects can perform on general objects

__Subjects__ are users

Access Control matrix

- Could have matrix to give certain access to everything

- not memory efficient

- fast lookup

Access Control list (looks like sql table)

- Each thing in Directory -> has list of every user and their access rights to everything

- memory efficient

- can't get all things user has access to easy

## OS Security

Fundamental controller of all system resources, so it makes it primary of attack

Access Control - who is allowed to access what?

Integrity - how to prevent corruption of resources?

Availability - how to ensure resources are available?

## Common Security Features

Enforced Sharing

- resources should be shared only as appropriate

Interposes communication and synchronization

- OS mediates communication between processes

Protection of critical OS data

- the OS must protect its own secret data from users

Guaranteed fair service

- a process should not be able to "game the system" to get extra resources

Interface to hardware

- processes need to access to hardware resources, the access should be restricted to appropriate use

User authentication

- need method to identify users and verify they are who they say they are

Memory protection

- processes should be limited in what memory they can access

File and I/O

- need to protect files from unauthorized users

Allocation and access control to general objects

- other features that need to protect include concurrency and synchronization

## Defense in Depth

A basic principle of security design is defense in depth, multiple layers of security controls to protect the system

Protect the system using several independent methods, reduces chance that one vulnerability can compromise entire system

Often conceived of as rings of security, the inner most core of the system is protected by the most layers

## Layered Architecture

Often relies on hardware support to protect inner layers, e.g. kernel mode and machine mode

## Layered Trust

A hierarchically designed system has layers of trust

Layers are isolated to limit effects of problems in one layer

Level 2: Noncritical functions few disasters likely from noncritical software

Level 1: Less critical functions impact limited

Level 0: Most Critical function if compromised, nothing is out of reach.

## Trusted System

one that is relied upon to a specified extent to enforce a specified security policy

## Trusted Computing Base (TCB)

name given to everything in the trusted operating system that is necessary to enforce the security policy

## Operating System tools for security

Virtualization

- providing the appearance of one set of resources by using different resources

Virtual Machine

- present to the users only the resources they need, giving the user the impression their program its running on its own machine

Hypervisor (virtual machine monitor)

- software that implements a virtual machine

Sandbox

- similar to virtualization, a protected environment in which a program can run and not endanger anything else on the system

Honeypot

- a fake environment intended to lure the attacker

## Wasted network

How do I ensure that a packet gets to an end user?

get response back = good, get no response back = some failure

Try to resend if get no response, then exponentially more time between changing responses

e.g. 1 second, 2 seconds, 4 seconds, 8 seconds

Transport layer process-to-process channel

only 4 billion IPv4 addresses, not enough for current Internet usage

FTP data transfer = 20

FTP command control = 21

SSH = 22

telnet = 23

SMTP (mail) = 25

DNS = 53

HTTP = 80

HTTPS = 443

--------------------------------------------------

## Remote Procedure Call

RPC have goal of making the process of executing code on a remote machine as simple and straight forward as calling a local function

## Stub Generator Actions (Client Side)

- Create a message buffer - a message buffer is usually just a contiguous array of bytes of some size

- Path the needed information into the message buffer

    - Putting all the information into a single contiguous buffer

- Send the message to the destination RPC server

- Wait for the reply

- Unpack return code and other arguments

- Return to the caller

## Stub Generator Actions (Server Side)

- Unpack the message

- Call into the actual function

- Package the results

- Send the reply

## Network File System (NFS)

Open standard, and everyone can make whatever they wanted using the standard

Advantages:

- Provide easy sharing of data across clients

- Centralized administration of file system

client 0 -\>

client 1 -\> Network -\> Server <\- Raid

client 2 -\>

client 3 -\>

## Architecture

distinguish between client-side and server-side components

system call is identical to local files system, provides client with transparent access

## Stateful Server

__stateful server__

- Means the server maintains information about the client's state, a server without a client stat is __stateless__

| Client | process | fd | inode | lseek |
| :---: | :---: | :---: | :---: | :---: |
| 1 | 2018 | ... | ... | ... |
| 2 | 403 | ... | ... | ... |
| 3 | 685 | ... | ... | ... |

Cons

- What happens when the server crashes?

- Need to reestablish connections with all clients and request their state to rebuild the complete state on server

- Slow recovery, extra complexity for client

## Fast Server Crash Recovery

- In distributed system we expect servers to crash, design goal is for server to __recover__ quickly

- What if server is stateless? All recovery is local

- Does not remember everything about client

## Client/Server Protocol

A file handle has volume identifier, inode number, and generation number

__Generation number__ identifies the version of the inode

- Unix filesystems often allow reusing inode numbers after a file has been deleted

Common commands sent from client to server

- LOOKUP - obtain file handle

- READ - read from file at specified location at number of bytes

- WRITE - write to file at specified location at number of bytes

- GETATTR - get the attributes for a file

## Retry on Failure

Possible failures:

- network failure

- server crashed and is rebooting

- server is under heavy load and is slow completing the operation

## Case 1: Request lost

- can resend

## Case 2: Server down

- can resend

## Case 3: Reply lost on way back to client

- can't resend

## Idempotency

performing an operation multiple times is equivalent to the effect of performing the operation a single time

Are these Idempotent?

LOOKUP - yes
READ - yes
WRITE - yes
APPEND - no (NFS actually doesn't have this command because it is only Idempotent)
GETATTR - yes

If you want to append, can just use GETATTR to get file size, then WRITE past EOF

## Client-side caching

sending every read and write request over network has big performance penalty, order of magnitude slower than a local file system

__Write Buffering__ - means write goes to cache first and then later the changes are pushed to the server

## Cache Consistency Problem

Different Clients can get different files based on the __update visibility__ (one client made an update, and other clients have not updated yet)

__stale cache__ - a client could have an out-of-date cache

Flush-on-close - means cache is always flushed when the application closes a file

- not a perfect solution, update visibility problem still exists, but is mitigated for common file usage patterns

GETATTR command will indicate time of last modification to file

Results in a flood of GETATTR commands, solution is to add a local attribute cache that updates contents only after a timeout

# AFS version 1

Client side is Venus and server-side is Vice

whole-file caching

Path-traversal cost too high

Too many TestAuth messages

Load not balanced across servers

These problems resulted in server CPU becoming bottleneck (a server could only handle 20 clients)

## Volumes 

- directories are mounted to __volumes__

Administrator can move volumes across servers to balance load

## Callback 

- to solve problem of too many AuthTest messages, use callback to reduce number of interactions with server

Server promises to inform client when a file is modified

## File Identifier (FID)

to solve problem of too many path traversals on server, use file identifier

client no longer requires server to traverse absolute path every time

## Opening a file the second time

Last writer always wins

## Recovery after crash

Heartbeat protocol, client sends periodic message and expects response
