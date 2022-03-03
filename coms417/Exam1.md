# Exam 1

#### By Benjamin Nguyen (btnguyen)

#### Section: 3:40 - 4:55

## Problem 1

![](../pic/triangleExam.png)

a.

All of the test cases pass when run with JUnit. Explain why this happens using the RIPR model. Be explicit.

The reason that all of the tests pass is because none of the test cases even get to the ___R___ in RIPR, which is Reachability (meaning that the faulty code never gets run). And since the faulty code never gets run, it never gets to the other steps in the RIPR process.

None of the tests cases ever reaches the broken code on line 9, because for all the tests, a $\ge$ b.

Since all of them have a $\ge$ b, there is no way for any of them to pass the if statement on line 8, meaning that the piece of faulty code never gets run.

```java
if (a > b) { // <= this is always false for the test cases
    //error in code
}
```

b.


```java
(1,0,0,INVALID)
```

This test case does give us 100% coverage, because it goes through both the if statements where `(a > b)` and `(a > c)` that start at line 8 and line 14 respectively.

However, this does not reveal the fault because even though the test reaches the error, and it causes an incorrect state, it does not propagate to give an incorrect final state.

`(1,0,0,INVALID)` would have returned `INVALID` anyway, even without the fault

c.


```java
(1,2,2,ISOSCELES)
```

This test would reveal the fault because it would return `EQUILATERAL` instead of `ISOSCELES`.

The test would enter the `if` statement on line 8, and go through the fault on line 9, which would create a state where a=2, b=2, and c=2, whereas if the code was right, it would have been where a=2, b=1, and c=2.

Since we can see that the intended behavior differs from the behavior that the code produces, this test reveals that the program has a fault in it.

d.

```java
(7,8,7,ISOSCELES)
```

This case failed because it will return `EQUILATERAL` instead of `ISOSCELES`.

e.

100 percent branch coverage is no longer possible because line 30 is unreachable.

Line 28's if statement will return true if a is equal to b, which means that that case can no longer occur in line 30, because when a == b is true, then it never gets to line 30 because it returns earlier at line 29

Also, Line 30 cannot get full coverage because there is no case where `(a == b)` is true, but `(b == a)` is not, so there cannot be the case that a == b and b != a, so since that case cannot be covered it cannot get 100% coverage

## Problem 2


