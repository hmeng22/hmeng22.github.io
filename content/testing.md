---
title: "Testing"
date: 2017-07-24T18:09:04-04:00
draft: false
---

## TDD vs BDD

Test-driven development (TDD) which means you write your tests before your code, is one of the main, agile development techniques. The genius of TDD lies in increased quality of code, faster development resulting from greater programmer confidence, and improved bug detection. (with assert)

Behavior-driven development (BDD) encourages collaboration between product owners and programmers. (with expect)



## Tools

#### Test Runner

**Karma** is a browser test runner which creates a fake server to load tests files, run them and report results. It requires a testing framework such as Jasmine to plug into it in order to actually run ***specs*** and determine whether any given condition is valid or not.

#### Testing Framework and Assertion Library

Methods outside the ***it*** block are generally derived from the testing framework. Everything within ***it*** block is code from the assertion library. ***beforeEach***, ***describe***, ***it*** are all methods extending from Testing Framework such as **Mocha**. ***expect***, ***equal*** are all methods from Assertion Library such as **Chai** (or from a testing plugin such as **Sinon**).

#### Suite & Spec & Expectation

A **Suite** begins with a call to the global function ***describe*** with two parameters : a string and a function.

A **Spec** is defined by calling the global function ***it*** with two parameters : a string and a function.

An **Expectation** is built with the function ***expect*** which takes a value, called the actual. It is chained with a Matcher function, which takes the expected value.



## Jasmine 2 vs Mocha + Chai

The APIs of Jasmine and Mocha are very similar where you write your test suite with *describe* blocks and each test, also called a spec, using the *it* function.

```javascript
describe('describe name', function() {
  it('should name', function() {
    // assertions or expectations here
  })
})
```

- Mocha does not have a built in assertion library. Most developers choose **Chai** as their assertion library. Chai has 3 different assertion flavours : the *should* style, the *expect* style, and the *assert* style.
- Chai's *expect* style is similar to what Jasmine provides.

```javascript
Jasmine
expect(calculator.add(1, 1)).toEqual(2);

Chai
expect(calculator.add(1, 1)).to.equal(2);
```

- Both Jasmine and Mocha use *describe()* and *it()* functions.
- Spies or Test Doubles. Mocha does not come with a test double library, you will need to load in **Sinon**.

```javascript
Jasmine
var userSaveSpy = spyOn(User.prototype, 'save');
var spy = jasmine.createSpy();
```

- Asynchronous Testing. The same.
- Running Tests. Mocha comes with a command line utility that you can use to run tests. Jasmine does not have a command line utility to run test, use Karma.

```
mocha testsDirectory --recursive --watch
```

#### Conculusion

Either Jasmine with Karma or Mocha with Chai  (chai-http is used to make requests to test RESTful APIs), Sion.
