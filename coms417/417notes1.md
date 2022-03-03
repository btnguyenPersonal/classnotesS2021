# Software Testing

Software testing can stop unintended bugs

#### Levels
- 0 &rarr; no difference between _testing_ and _debugging_
- 1 &rarr; purpose of testing is to show _correctness_
- 2 &rarr; show program *does not work*
- 3 &rarr; *reduce the risk* of the software
- 4 &rarr; Testing is a *mental discipline* that helps all IT professionals develop higher level software

#### Key Challenge
Testing can only show the presence of faults. It _cannot_ determine the absence of faults

#### Model-Driven Testing
Use higher levels of abstraction or models to reduce complexity and guide testing

## Triangle Example
```
[~]$ java triangle 4 4 4
equilateral
[~]$ java triangle 4 5 4
scalene
[~]$ java triangle 0 5 4
invalid
```

- what makes a valid triangle (specifications)?
- what do we know about the code structure?
- not always possible to see the code base

    ```
    public static TriangleType triangle (int s1, int s2, int s3)
    {
      if (s1 <= 0 || s2 <= 0 || s3 <= 0) {
        return (Triangle.INVALID);
      }
      if (s1 + s2 <= s3 || s1 + s3 <= s2 || s3 + s2 <= s1) {
        return (Triangle.INVALID);
      }
      if (s1 == s2 && s3 == s2) {
        return (Triangle.EQUILATERAL);
      }
      if ((s1 == s3) || (s2 == s3) || (s3 == s1)) {
        return (Triangle.ISOSCELES);
      }
      return (Triangle.SCALENE);
    }
    ```

- ***Testing*** &rarr; Exercising software and observing its execution
- ***Test Failure*** &rarr; Giving inputs, and program does not give expected outcome

    - not all failures will give visible failures

#### `RIPR` Model
- `R` eachability
    - reach the error
- `I` nfection
    - need to give incorrect state
- `P` ropagation
    - need to propagate out to other parts of the program
- `R` evealability
    - incorrect final state

`r` - test must execute the faulty code

`i` - execution must create an incorrect state of the program (error)

`p` - the error has to propagate to the output or final state of program

`r` - the tester has to observe the incorrect output/final state

#### Test Manager
- Sets test policies and processes
- Interact with other managers on the project
- Otherwise supports the engineers

#### Test Engineer
- Designing test inputs
- Producing test values
- Running test scripts
- Analyzing results
- Reporting results to developers and manager

***Note***: Agile Devs will be doing both of these at once all the time

#### Code Coverage
- Branch Coverage &rarr; based on all control flows (all `if` and `else` statements)
- Line Coverage &rarr; based on how many lines have been run through when coding
- Way too many tests to test _every_ input
- Try to find the _fewest_ inputs that will find the _most_ problems

## Levels of Testing

#### Top down
- Acceptance testing &rarr; satisfies requirements/user needs.
  - Must involve users with domain knowledge
- System testing &rarr; evaluates overall system behavior.
  - Assumes individual parts already tested.
  - Usually tested by team independent from the devs
- Unit testing &rarr; tests individual functions/units with respect to implementation

#### Traditional Testing Levels
- Intra-method testing &rarr; test each method individually
- Inter-method testing &rarr; test methods together in a feature

#### Regression Testing
- Performed throughout program maintenance
- Runs *each time* a program is modified
- Ensures that the previously working code *has not broken*
- Expensive because it happens often

## Early testing Design
**Mistakes in requirements and high-level design are costly**
- Often found months or years after they are created
- May be dispersed throughout multiple versions

#### Test requirements
- Things that must be satisfied or covered during testing
    - Each statement can be a test requirement

#### Test Criterion
- Collection of rules
  - Cover every __statement__
  - Cover every __branch__
  - Cover every __widget__

## Specification vs Structural Testing
- Specification &rarr; tests from specification and external descriptions
- Structural &rarr; tests from the code (testing methods)

#### Test Automation
- automation can be used for generation
- also can make scripts to run all the tests
- reduces time of testing &rarr; run more tests!

#### Jacoco
- Uses JUnit for testing
- Instruments classes to provide code coverage
- works based on a `pom.xml`
- `mvn compiler = 1.8`

#### Excise task vs Revenue task
- Excise task
  - tasks that need to happen
  - automation is key for these tasks
- Revenue task
  - tasks that bring $$$ in
#### Automation
  - Frees up engineer time
  - Helps catch errors
#### Software testability
  - How _easy or hard to test is the software_?

#### Observability and Controllability
- Embedded software &rarr; does not provide human readable output
  - low observability
- Embedded software &rarr; gets input from other hardware, not human inputs
  - low controllability

#### Prefix and Postfix Values
- Prefix
  - turn phone on
  - open messenger
- Postfix
  - type and send message
  - 2 Types:
    1. Verification values
    2. Exit values

#### Test Automation Frameworks
- Ability to share common test data between tests
- Can run through command line or GUI

#### JUnit Methods
```
assertTrue(boolean)
```
  - Simplest form
```
assertTrue(String, boolean)
```
  - `String` provides info to tester if the assertion is `false`
```
fail(String)
```
  - Used specify a failing message when a specific line is reached

#### Test Fixture
  - code can be shared between tests
  - `@Before` and `@After`
  - Mostly used for setup and teardown

#### Standard Imports
```
import static org.junit.Assert.*;
import org.junit.*;
import java.util.*;
```
```
int a[]; // Test Fixture

@Before
public void setUp() {
  for (int i = 0; i < 100; i++) {
     a[i] = i;
  }
}
```
```
@After
public void tearDown() {
  a = null;
}
```
```
@Test
public void test_1 {
  a.add("cat");
  assertTrue("Add cat test", a[0] == cat);
}
```

## Category-Partition
  - Specifying and generating functional tests
  - Tests aimed at most vulnerable parts of the system
  - Cases where input and environment interactions can cause problems

#### Functional Units are aspects of the program behavior that can be tested independently
  - TSL (test specification language) means of implementing the category partition method
