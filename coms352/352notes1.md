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
pid_t fort()
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

___

- On success

  - Both parent and child continue execution at the point of return from `fork()`
  - `return pid of the child process` to the parent process
  - `return 0` to child process

___

- On failure:
  - Does not create child and `returns -1`

___

Scheduler picks which parent or child process goes first

___Note___: Calling `fork()` twice will create 4 processes

## `wait() // Wait for Child`

```
pid_t wait(int *wstatus)
```

- Suspend execution for he parent until one of its children terminates

___

- On Success
  - Returns pid of the child process that terminated
