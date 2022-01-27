# HW 1

## 1. For each state transition below, state whether there is a context switch involved. If there is a
context switch, describe the processes involved. How are they chosen?
  - ready -> running
    - There is a context switch, scheduler replaces the current running process and replaces it with the next
  - running -> blocked
    - There is a context switch, the currently running process is replaced with the next process from the ready queue
  - blocked -> ready
    - No context switch, because current running process still stays running

## 2. Three programs are serviced in a multiprogramming system.
  - Program A contains 50ms of computation followed by 100ms of I/O on hardware device
  - Program B contains 20ms of computation followed by 50ms of I/O on hardware device
  - Program C contains 50ms of computation followed by 100ms I/O on hardware device
  - Each device can service only one I/O request at a time.
  - What is the minimum time it will take to complete all three programs?

## 3. Describe the purpose of each of the following terms individually:
  - system call &rarr; call a system library and transfer control to the OS in kernel mode
  - interrupt &rarr; signal from a _hardware_ source that gives CPU control to the interrupt handler
  - trap &rarr; signal from a _software_ source that gives CPU control to the interrupt handler
  - Now, describe how the three are related to each other.
    - System calls need to execute in kernel mode, kernel mode can be entered by an interrupt or trap. Software initates a system call by causing a trap. Hardware changes control to the OS by an interrupt

## 4. The RISC-V architecture that we will use in examples throughout this class allow processors
to be implemented with three privilege levels defined as follows <http://docs.keystone-enclave.org/en/latest/Getting-Started/How-Keystone-Works/RISC-V-Background.html>

  - Privilege level defines what the running software can do during its execution. Common usage of each privilege level is as follows:
    - U-mode: user processes
    - S-mode: kernel (including kernel modules and device drivers), hyper visor
    - M-mode: bootloader, firmware

- However, the specification allows simple embedded processors to implement just M-mode (i.e., all code on these simple processor implementations must run at the same privilege level).

- What is the purpose of multiple privilege levels? Compare and contrast multiple privilege levels vs a single privilege level, name at least one advantage for each.
  - We don't want the user processes to be able to access each other's memory or the memory of the OS, or other private stuff
  - When a process executes in user mode it is restricted in what instructions it can execute. Only OS code executes in kernel mode where there are generally no restrictions.
  - The RISC-V architecture has an additional mode that can execute instructions that are only required during boot loading

## 5. The following application code demonstrates what is called a “fork bomb”.
- What negative consequence might this application have on the system?
- What might an OS do to prevent it?

```
/* WARNING: DO NOT EXECUTE THIS CODE!        */
/* SSG MAY GIVE YOU A STERN WARNING OR WORSE */
int main(int args, char *argv[]) {
    int rc = 0;
    while(rc == 0) {
        rc = fork();
    }
    wait(NULL);
    return 0;
}
```

- This loop creates children _recursively_

## 6. A shell is an application that enables users to run and control other applications through a command line interface.
- Using the POSIX API for processes (e.g., fork, exec, wait, dup and pipe) list the steps a shell might take to execute the following user commands:
- Start another application. For example, the user invokes the grep application with two command line arguments like this:
  ```
  $ grep COMS352 *
  ```
  - The shell calls `fork()` to create a child process
  - Child process calls `exec()` to run `grep COMS352`
- Pipe the standard out of one application into the standard in of another application. For example, the user pipes the output of the grep application into the input of the wc application like this:
  ```
  $ grep COMS352 * | wc -l
  ```
  - The shell calls `fork()` twice to create a child process for each end of the pipe
  - Child process calls `exec()` to run `grep COMS352`
  - Then shell calls `pipe()` to send output of `grep COMS352 *` to `wc -l`
  - Then the Child process calls `exec()` to run `wc -l`
