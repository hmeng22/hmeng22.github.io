---
title: "JSPrototype"
date: 2017-07-26T17:45:18-04:00
draft: false
---

## Inheritance and the prototype chain

father.js

```
function father() {

  var fatherVar = 0;
  function fatherFunction() {
    console.log("fatherFunction")
  }

  this.fatherThisVar = 3;
  this.fatherThisFunction = function() {
    console.log("fatherThisFunction")
  }

  Object.defineProperty(this, 'fatherDefineVar', {value: 4});
  Object.defineProperty(this, 'fatherDefineFunction', {
    value: function() {
      console.log("fatherDefineFunction")
    }
  });

  Object.assign(this, {
    fatherPrototypeAssignThisVar: 6,

    fatherPrototypeAssignThisFunction: function() {
      console.log("fatherPrototypeAssignThisFunction")
    },

    fatherPrototypeAssignThisFunctionReturnFunction: (function() {
      return function fatherPrototypeAssignThisFunctionReturnFunction() {
        console.log("fatherPrototypeAssignThisFunctionReturnFunction")
      }
    }())
  });
}

Object.defineProperty(father, 'fatherDefineFatherVar', {value: 1});
Object.defineProperty(father, 'fatherDefineFatherFunction', {
  value: function() {
    console.log("fatherDefineFatherFunction")
  }
});

Object.assign(father, {
  fatherAssignFatherVar: 2,
  fatherAssignFatherFunction: function() {
    console.log("fatherAssignFatherFunction")
  }
});

father.prototype.fatherPrototypeVar = 6;
father.prototype.fatherPrototypeFunction = function() {
  console.log("fatherPrototypeFunction")
};

Object.defineProperty(father.prototype, 'fatherPrototypeDefineVar', {value: 7});
Object.defineProperty(father.prototype, 'fatherPrototypeDefineFunction', {
  value: function() {
    console.log("fatherPrototypeDefineFunction")
  }
});

Object.assign(father.prototype, {
  fatherPrototypeAssignFatherPrototypeVar: 8,

  fatherPrototypeAssignFatherPrototypeFunction: function() {
    console.log("fatherPrototypeAssignFatherPrototypeFunction")
  },

  fatherPrototypeAssignFatherPrototypeFunctionReturnFunction: (function() {
    return function fatherPrototypeAssignFatherPrototypeFunctionReturnFunction() {
      console.log("fatherPrototypeAssignFatherPrototypeFunctionReturnFunction")
    }
  }())
});

export {father};
```

son.js

```
import {father} from './father'

function son() {

  // 'inherit' father's properties & methods
  // father.call(this);

  var sonVar = 10;
  function sonFunction() {
    console.log("sonFunction")
  }

  this.sonThisVar = 13;
  this.sonThisFunction = function() {
    console.log("sonThisFunction")
  }

  Object.defineProperty(this, 'sonDefineVar', {value: 14});
  Object.defineProperty(this, 'sonDefineFunction', {
    value: function() {
      console.log("sonDefineFunction")
    }
  });

  Object.assign(this, {
    sonPrototypeAssignThisVar: 15,

    sonPrototypeAssignThisFunction: function() {
      console.log("sonPrototypeAssignThisFunction")
    },

    sonPrototypeAssignThisFunctionReturnFunction: (function() {
      return function sonPrototypeAssignThisFunctionReturnFunction() {
        console.log("sonPrototypeAssignThisFunctionReturnFunction")
      }
    }())
  });
}

Object.defineProperty(son, 'sonDefineSonVar', {value: 11});
Object.defineProperty(son, 'sonDefineSonFunction', {
  value: function() {
    console.log("sonDefineSonFunction")
  }
});

Object.assign(son, {
  sonAssignSonVar: 12,
  sonAssignSonFunction: function() {
    console.log("sonAssignSonFunction")
  }
});

// 'inherit' father's prototype properties & methods
// Object.create will create a new object, the prototype of this new object is the first argument.
son.prototype = Object.assign(Object.create(father.prototype), {});

son.prototype.sonPrototypeVar = 16;
son.prototype.sonPrototypeFunction = function() {
  console.log("sonPrototypeFunction")
}

Object.defineProperty(son.prototype, 'sonPrototypeDefineVar', {value: 17});
Object.defineProperty(son.prototype, 'sonPrototypeDefineFunction', {
  value: function() {
    console.log("sonPrototypeDefineFunction")
  }
});

Object.assign(son.prototype, {
  sonPrototypeAssignSonPrototypeVar: 18,

  sonPrototypeAssignSonPrototypeFunction: function() {
    console.log("sonPrototypeAssignSonPrototypeFunction");
  },

  sonPrototypeAssignSonPrototypeFunctionReturnFunction: (function() {
    return function sonPrototypeAssignSonPrototypeFunctionReturnFunction() {
      console.log("sonPrototypeAssignSonPrototypeFunctionReturnFunction")
    }
  }())
});

export {son}

```
