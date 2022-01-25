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

- On Success

  - Both parent and child continue execution at the point of return from `fork()`
  - `return pid of the child process` to the parent process
  - `return 0` to child process

___

- On Failure:
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
___

- On Failure


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
#### `||||||||||||||||||||||||||PIPES||||||||||||||||||||||||||`
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

___

- On Success
  - New file descriptor points to source of provided file descriptor
  - Returns new file descriptor

___

- On Failure
  - Returns -1

___

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

- `sudo` everything
