---
title: "JavaScriptNotes"
date: 2017-11-09T19:26:28-05:00
draft: true
---

# JavaScript Notes

JavaScript notes. JavaScript = ECMAScript + DOM + BOM

## Getting Started

### Inheritance and the prototype chain

Every JavaScript object has a prototype. The prototype is also an object.

```
ObjectName.prototype.newProperty = val;
ObjectName.prototype.newMethod = function() {};
```

### Object

```
Object.assign(target, ...sources) : Copy the values of all enumerable own properties from one or more source objects to a target object. It will return the target object.
```

```
Object.create(proto, propertiesObject) : Calling this method creates a new object. The prototype of this object is the first argument of the function.
```

```
Object.defineProperty(obj, prop, descriptor) : defines a new property directly on an object, or modifies an existing property on an object, and returns the object.

var o = {};
Object.defineProperty(0, "key", {
  value: 28,
  writable: true,
  enumerable: true,
  configurable: true
  get: function() { return keyValue; },
  set: function(newValue) { keyValue = newValue; }
})
```

```
Object.entries() : returns an array of a given object's own enumerable property [key, value] pairs.
Object.keys() : returns an array of a given object's own enumerable properties.
Object.values() : returns an array of a given object's own enumerable property values.
```

### Function

```
Function.prototype.apply(thisArg, [argsArray]) : calls a function with a given this value, and arguments provided as an array.

Function.prototype.bind(thisArg[, arg1[, arg2[, ...]]]) : creates a new function with given this value and arguments.

Function.prototype.call() : calls a function with a given this value and arguments provided individually.

// Inside a function, the value of this depends on how the function is called.
this 永远指向函数调用者. 通过apply, bind, call方法会改变方法实际执行实体.

apply    与call相似,将参数作为数组传递.
bind    将参数传递给函数而不调用,返回一个新函数.
call    与调用函数上下文相同.
```

#### arguments

```
1\. arguments 是一个真实的数组对象. 但是在严格模式下,它是参数的一个拷贝,实际指向不同内存空间.
2\. arguments : is available within the function.
3\. arguments.callee : contains the currently executing function. 当前执行的函数,可用于递归调用.
```

#### Immediately-Invoked function

```
(function() {
  console.log('Run itself.');
})();
```

#### setTimeout() & setInterval()

```
1\. The returned timeoutID is a numeric, non-zero value which identifies the timer createrd by the call to setTimtout().
2\. This value can be passed to clearTimtout() to cancel the timeout.
3\. setTimtout() and setInterval() share the same pool of IDs.
```

#### setTimeout() & Promise

```
setTimeout(function() {
  console.log('3');
}, 0);

Promise.resolve().then(function() {
  console.log('2');
});

console.log("1");

// 1
// 2
// 3

setTimeout() will excute in the 'Next Round Event Loop',
Promise will excute in the 'Current Round Event Loop',
```

### Module

```
//写法1
exports.hello = function() {
    console.log(‘world’);
}

//写法2
var f = function() {
    this.firstname = 'hello',
    this.lastname = 'world',

    this.name = function() {
        return this.firstname + this.lastname;
    }
}

module.exports = f;


exports 和 module.exports 的区别：
1\. module.exports 初始值为一个空对象 {}
2\. exports 是指向的 module.exports 的引用
3\. require() 返回的是 module.exports 而不是 exports

exports本身就只是module.exports的引用，而使用require加载模块的时候返回的是module.exports，exports=bar改变了exports的引用，所以最终返回的module.exports只是一个空对象，所以会报TypeError的错误。


ES6 Module
export {}
import ""
```

## Development

### Event Proxy

More effective when ul has thousands li inside.

```
<ul id="todo-app">
  <li class="item">Walk the dog</li>
  <li class="item">Pay bills</li>
  <li class="item">Make dinner</li>
  <li class="item">Code for one hour</li>
</ul>

document.addEventListener('DOMContentLoaded', function() {
  let app = document.getElementById('todo-app');

  // attach event listener to whole container
  app.addEventListener('click', function(e) {
    if (e.target && e.target.nodeName === 'li') {
      let item = e.target;
      alert('you clicked on item: ' + item.innerHTML);
    }
  });
});
```

### Closure

```
const arr = [10, 12, 15, 21];
for (var i = 0; i < arr.length; i++) {
  // pass in the variable i so that each function has access to the correct index
  setTimeout(function(i_local) {
    return function() {
      console.log('The index of this number is: ' + i_local);
    }
  }(i), 3000);
}
```

```
for (let i = 0; i < arr.length; i++) {
  // using the ES6 let syntax, it creates a new binding
  // every single time the function is called
  // read more here: http://exploringjs.com/es6/ch_variables.html#sec_let-const-loop-heads
  setTimeout(function() {
    console.log('The index of this number is: ' + i);
  }, 3000);
}
```

### Misc

#### Hoisting

```
在代码执行前，JavaScript将变量和函数声明移动到其范围顶部。
未声明的变量在赋值前不存在，这将导致所有未声明的变量成为全局变量。
```

```
Infinity, NaN, undefined, Null
decodeURI(), decodeURIComponent(), encodeURI(), encodeURIComponent()
escape(), unescape(), isNaN(), Number(), parseFloat(), parseInt(), String()

var fileinfo = {
    name: file.name,
    type: file.type
};
var fileinfoURI = encodeURIComponent(JSON.stringify(fileinfo));
var fileinfoReceived = JSON.parse(decodeURI(fileinfoURI));
```
