# Principals of AI

___

### First Day Orientation
##### Office Hours: Tuesday and Thursday 11am-12:15am

Textbook and Slides are electronic

All programming projects in Java

___

## What is AI?

- __Perception__: Interpretation of data

- __Action__: Accomplishing the task

- __Reasoning__: Apply logical thinking

- __Learning__: Improvement and Adaptation to create better solutions

- __Communication__: Computer output --> human interpretation

- __Planning__: Planning for next solution

    Turing Test: answers indistinguishable from human

    In AI, there are many uncertainties

    Big Difference of AI in _theory_ and in _practice_

## A Brief History

- Start of AI
- Innovation in games
- Collapse after hard to make real world application
- Neural networks regain popularity
- Resurgence after statistics came in

## The State of the Art

- Big data
  - Pattern and Image recognition
- Deep learning
  - image recognition
  - natural language processing
  - speech recognition
  - machine translation


## Intelligent Agents

- Agents need to have "perception" which can be mimicked with sensors to have senses _ex: touch sensors, reading, and cameras_
- Agents also need to modify the environment through "actions" _ex: move forward, accelerate, and brake_
- Agent function: takes the environment in, and gives out the action that the Agent should take

### What is considered to be _Rational_?

- Performance measure
- Prior Knowledge
- Performable actions
- Perceptual sequence

    Rational Agents are expected to __maximize__ the performance metric

### Omniscience vs Rationality

- Omniscient agent know the actual outcome of its actions
  - Impossible in Reality!
- Omniscient agents only happen in games
  - ex: chess and go
- Rationality maximizes the expected performance
  - Learn as much as it perceives
  - Does not require Omniscience

### The nature of environments

##### PEAS
- `P`erformance measure
    - Save
    - Fast
    - Legal
    - Comfortable trip
    - Maximize Profits
    - Minimize Impact on other Drivers
- `E`nvironment of the agent
    - Roads
    - Traffic
    - Police
    - Pedestrians
    - Weather
- agent's `A`ctuators and `S`ensors
    - Steering
    - Accelerator
    - Brake
    - Camera
    - Back Sensors

### Fully Observable vs Partially Observable

- Chess &rarr; _Fully_ Observable
    - can see everything
- Poker &rarr; _Partially_ Observable
    - cannot see everything

### Dynamic vs Semi-Dynamic vs Static

- Dynamic &rarr; does not change state during turns
- Semi-Dynamic &rarr; can change state during turns
- Static &rarr; other

### Episodic vs Sequential

- Episodic &rarr; not based on last outputs
- Sequential &rarr; is based on last outputs

## Structure of Agents

- Job of AI is to design an agent program that will
    - perceptions &rarr; actions

### Basic Agent Types

- Simple reflex agents
    - select actions based on current perceptions, and ignore perception history
    - usually reduces to `if`, `else if`, `else` statements
    - never improves on past mistakes
- Model-based reflex agents
    - maintains some internal state of the environment
    - usually keeps track with features
    - also reduces to `if`, `else if`, `else` statements, but also will check the environment state
- Goal-based agents
    - will take the future into account
    - will try to predict the future
- Utility-based agents
    - will evaluate current performance, and will try to learn from it
