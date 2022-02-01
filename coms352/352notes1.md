# Intro to Operating Systems

By Matt Tancreti

Operating Systems are mostly written in C

Each process can get virtual CPUs

Memory Virtualisation - programs can write anywhere in the memory

## Program vs Process
- _program_ is instructions stored on the disk &rarr; an executable file
- _process_ is a running program

|Memory|CPU|
|:---:|:---:|
|Stack|Registers|
|Heap|Program Counter|
|Code|Stack Pointer|
|Static Data||
|process id||
|state = RUNNING||

- __Registers__ &rarr; data stored directly on CPU
- __Program Counter__ &rarr; which instructions are executed next
- __Address Space__ &rarr; where data is stored in memory
- __Stack and Frame Pointer__ &rarr; what are the parameters of functions?

## Scheduler
- The scheduler is part of the OS
- Job is to make sure that only one program is running at once
- Context Switch
  - Save CPU context of descheduled process
  - Load CPU context of descheduled process
- Every process must have a _parent_
  - When a process is deleted it goes into zombie state, because it may need the exit id

## POSIX (Portable Operating System Interface)
Standard programming interface provided by UNIX like system

## `fork() //Process Creation`
```
pid_t fork()
```

```
printf("A");
fork();
printf("B");

[~]$ A
B
B
```
- Creates a new process by duplicating the calling process
- Child process has a copy of parent's address space
- On Success
  - Both parent and child continue execution at the point of return from `fork()`
  - `return pid of the child process` to the parent process
  - `return 0` to child process
- On Failure:
  - Does not create child and `returns -1`
Scheduler picks which parent or child process goes first
___Note___: Calling `fork()` twice will create 4 processes

## `wait() // Wait for Child`
```
pid_t wait(int *wstatus)
```
- Suspend execution for he parent until one of its children terminates
- On Success
  - Returns pid of the child process that terminated
## `exec() // Change the Program`
```
int exec(const char *pathname, char *const argv[]);
```
- Replaces the current program with a new one, command line args are passed in argv
- example usage:
  ```
  char *argv[] = {"wc", "README",0};
  exec('wc", argc);
  ```
# Interprocess Communication

#### `|||||||||||||||||||||||||PIPES|||||||||||||||||||||||||`
```
status () {
  echo -n " $(amixer | grep 'Front Left:' | awk '{print $5}') \
  $(date '+%m/%d/%Y ')$(date '+%r' | awk '{print $1}' | \
  sed s/:[0-9][0-9]$//) $(date '+%r' | awk '{print $2}') "
}

```

## `pipe() // Connect two processes`
```
int pipe(int p[2]);
```
- On Success
  - New file descriptor points to source of provided file descriptor
  - Returns new file descriptor

- On Failure
  - Returns -1

## Limited Direct Execution
__Time-sharing__ &rarr; each process can share the CPU so each can make progress

#### How do processes share time?
  - multiprogramming - when a process waits for I/O, the OS can have another take of the CPU
  - multitasking - each process gets a time-slice, a time limit before the next process gets to execute on the CPU

#### How does the OS keep control?
  - Hardware provides interrupts, kernel mode, and user mode to keep the user in control

## Direct Execution
- Lets the code do everything on the computer
- CPU has bit that indicates if in _user mode_ or _kernel mode_
  - Cannot read/write outside of address space bounds
  - Cannot read/write I/O devices
- When in kernel mode, all instructions allowed
- Normal processes only execute in user mode, the OS executes in kernel mode

## Process mode
- Protects the computer from altering sensitive data

## System Call
- Problem: how can users perform privileged operations?

## Jobs
- Real processes alternate between needing CPU time and waiting for I/O
- Jobs with Time-Sharing, can switch between them when needed
- __Preemption__ will kick off processes in the middle of a job before it's done to make sure that other jobs can be done
- Metrics
  - Time of arrival &rarr; job first enters ready state
  - Time of completion &rarr; time when job finishes
  - Time of first run &rarr; time when job starts its first run on the CPU
  - __Turnaround Time__ = __Time of completion__ - __Time of arrival__
- Why different metrics?
  - __Turnaround time__ &rarr; tells time to complete jobs, good for CPU bound processes, where getting enough CPU runtime is the main concern
  - __Response time__ &rarr; tells how long to respond to I/O, good for I/O bound(interactive) processes, which have short CPU bursts and frequent I/O
  - There are other metrics, later we will look at _fairness_
- FIFO
  - Always pick out job that comes first
  - Preemption: None
  - Advantage: Easy to implement
  - Disadvantage: Large upfront CPU processes can hurt turnaround and response time
- Shortest Job First (SJF)
  - Always pick out the shortest by job length
  - Preemption: None
  - Advantage: Optimal average turnaround and response time when all jobs arrive _at the same time_
  - Disadvantage: If short jobs arrive after starting a long job?
- Shortest Time-to-Completion first (STCF)
  - like SJF, but when a new job comes in, it will kick that job off first
  - Preemption: if a new job arrive with a shorter time to completion, it preempts
  - Advantage: short jobs don't need to wait for a long job to complete
  - Disadvantage: sometimes response time can be bad (Bad for I/O bound processes)
- Round Robin (RR)
  - Implementation: FIFO queue
  - Preemption: Job on CPU gets __time-slice__, preempt when time expired
  - Advantage: Low response time, Guaranteed response time
  - Disadvantage: high turnaround time, and frequent context switches reduce CPU efficiency
- Problem with SJF and STCF: Oracle
  - Scheduler doesn't know how long it will take for a job to complete
  - SJF and STCF needs the ability to see into the future
- Multi-Level Feedback Queue
  - SJF and STCF have good features, but they require oracle vision and they have serious flaws for some workloads
  - RR has low response time, but it treats all jobs equally which can result in poor turnaround time and frequent context switches
  - __Rule 1__ &rarr; `if Priority(A) > Priority(B), A runs and B doesn't`
  - __Rule 2__ &rarr; `if Priority(A) = Priority(B), A and B run in RR`

#### Examples of Common Processes
- Process 1: waits for user to press key, performs short task such as adding char to display buffer and then waits for next key press.
- Process 2: Perform a long math computation

#### CPU bound vs I/O bound processes
  - Jobs that need fast response but little CPU time should be highest priority
  - Jobs that need long CPU time and little I/O should be lowest priority
  
#### Adding Feedback to Multi-Level Queue
![](../pic/multilevelqueue.png)
  - __Rule 3__ &rarr; When a job enters the system, it is placed at the highest priority (the topmost queue)
  - __Rule 4a__ &rarr; If a job uses up an entire time slice while running, its priority is reduced
  - __Rule 4b__ &rarr; If a job gives up the CPU before the time slice is up, it stays at the same priority level.

#### Problem: Starvation
  ![](../pic/starve.png)
  - What happens if we turn up the rate of I/O bound jobs?
  - One job can freeze if there are too many I/O jobs

#### Priority boosts
  ![](../pic/priorityboost.png)
  - __Rule 5__ &rarr; After some time period S, move all the jobs in the system to the topmost queue

## Problem: Gaming the System
  ![](../pic/gamingsystem.png)
  - Smart programmers will catch on: ___"I can make my application run faster if I never let a complete quanta expire"___
  - Could add some randomness to the quanta

#### Optimization: Lower Priority, Longer Quanta
  ![](../pic/optimizequanta.png)
  - Longer quanta in the lower queues can reduce frequency of context switches

# The Complete MLFQ
  - __Rule 1__ &rarr; `if Priority(A) > Priority(B), A runs and B doesn't`
  - __Rule 2__ &rarr; `if Priority(A) = Priority(B), A and B run in RR`
  - __Rule 3__ &rarr; When a job enters the system, it is placed at the highest priority (the topmost queue)
  - __Rule 4__ &rarr; Once a job uses up its time allotment at a given level (regardless of how many times it has given up the CPU), its priority is reduced (i.e., it moves down one queue).
  - __Rule 5__ &rarr; After some time period S, move all the jobs in the system to the topmost queue

#### Fair Scheduling
  - Each job is assigned numbered _tickets_
  - Every time slice, scheduler randomly picks a winning tickets and the job runs for that time slice
  - Over time, jobs runtime is proportional to percent of tickets held

##### Lottery scheduler doesn't assign priorities how to assign tickets
  - In effect, the lottery scheduler is a kind of priority scheduler
    - More tickets means higher priority
    - But, fairer than priority, low ticket jobs can't be completely starved
  - For example, how can we create the effect of SJF?
    - Assign number of tickets inversely proportional to each job's runtime
  - __Pros__: No job can be starved, everyone gets their fair share of runtime
  - __Cons__: A short job can be unlucky and have higher response time

#### Stride Scheduling
  - Lottery has good fairness over the long run, but randomness can result in suboptimal choices over a short time
  - __Stride Scheduling__ is deterministic (not random) but has same fairness
  - For each job set its __stride__ is $(10000/ numTickets)$
  - Every time a job executes, increment it's _pass_ counter by its _stride_
  - Scheduler always picks the job with the lowest pass counter to run next

## Linux Completely Fair Scheduler (CFS)
  - CFS gives a proportion of CPU time to each process, there are two questions
  - When to preempt the currently running process?
    - Every process assigned a time slice within one `sched_latency`
      - If equal priority, each process gets a $1/N$ slice of `sched_latency`
      - Therefore, every process should run atleast once in `sched_latency`
      - ___Note___: `sched_latency` is scheduler latency
  - Which process to run next?
    - The process with the smallest __virtual runtime (vruntime)__

#### Nice Values
  - Nice value set by user to indicate "priority", weights the $1/N$ time slice a process gets before preemption
```
current_time_slice = current_weight / processes_weights_total * sched_latency
```
  - Lower nice value will receive larger time slice
  - Higher nice value will receive smaller time slice
  - `time_slice` of all processes still add up to `sched_latency`

#### Virtual Runtime
  - weighted version of the real runtime of each process
  ```
  vruntime = vruntime + (weight ratio based on nice value) * runtime
  ```
