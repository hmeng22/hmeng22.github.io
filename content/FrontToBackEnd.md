---
title: "FrontToBackEnd"
date: 2017-12-06T21:18:20-05:00
draft: true
---

# FullStack : FrontEnd to BackEnd

In the Web Development, FrontEnd is what you see; BackEnd is how it works.

At the beginning, FrontEnd is a part of BackEnd under Model View Controller. Everything is changed after Ajax is applied to Gmail (2004) and Google Maps (2005). Web 2.0 is coming.

FrontEnd needs to store and process data acquired using Ajax, then generate views. FrontEnd only has Model and View to handle UI part. URL is acting like a Controller or a Router to switch Views.

Later MVVM is born. Controller is replaced by View-Model which is to provide the processed data. From then on, FrontEnd has the ability to read/write data, switch view, interact with the user. It turns out that FrontEnd turns into a Single Page Application (SPA). Web developers start to develop mobile Apps inside the web browser.

```
       ----------              ----------              ----------
      |          |   ------   |          |   ------   |          |
      | Database |--| DATA |->| Back-End |--| HTML |->|   DOM    |
      |          |   ------   |          |   ------   |          |
       ----------              ----------              ----------
      |--------------Server--------------|            |---client---|
```

```
SPA
       ----------              ----------    ------    ----------              ----------
      |          |   ------   |          |  | DATA |  |          |   ------   |          |
      | Database |--| Data |->| Back-End |--|------|->|JavaScript|--| HTML |->|   DOM    |
      |          |   ------   |          |  | CODE |  |          |   ------   |          |
       ----------              ----------    ------    ----------              ----------
      |--------------Server--------------|            |--------------client--------------|
```

2009, NodeJS an open-source, cross-platform JavaScript run-time environment for executing JavaScript code server-side. FrontEnd is never the View part of BackEnd. FrontEnd is invading BackEnd. FrontEnd can program server-side codes using NodeJS.

By taking advantages of NodeJS, massive tools are utilized by FrontEnd.

## FrontEnd

FrontEnd includes :

- Browser : Browser Object Model
- HTML : Document Object Model, tags, attributes
- CSS : describes the style of HTML
- JavaScript : implement complex things on web pages
- Libraries & Frameworks

### HTML

#### HTML -> HTML5

```
* Semantic elements : <header>, <footer>, <article>, and <section>
* Attributes of form elements : number, date, time, calendar, and range
* Graphic elements : <svg> and <canvas>
* Multimedia elements : <audio> and <video>

* Geolocation
* Drag and Drop
* Local Storage
* Application Cache
* Web Workers : a JavaScript running in the background, without affecting the performance of the page.
* Server-Sent Events : allow a web page to get updates from a server.
```

### CSS

#### CSS -> CSS3

```
* Selectors
* Box Model
* Backgrounds and Borders
* Image Values and Replaced Content
* Text Effects
* 2D/3D Transformations
* Animations
* Multiple Column Layout
* User Interface
```

#### CSS Pre-processor

Make CSS programmable. Sass(Scss), Less, Stylus.

### JavaScript

#### JavaScript -> ES6

```
* Support for constants
* Block Scope
* Arrow Functions
* Extended Parameter Handling
* Template Literals
* Extended Literals
* Enhanced Object Properties
* De-structuring Assignment
* Modules
* Classes
* Iterators
* Generators
* Collections
* New built in methods for various classes
* Promises
```

### Libraries & Frameworks

#### Timeline

```
2006-08 : JQuery
2006-10 : Sass
2009-05 : NodeJS
2010-01 : npm
2010-04 : Less
2010-10 : AngularJS
2011-08 : Bootstrap
2013-03 : ReactJS
2013-07 : GulpJS
2013-12 : webpack
2016-09 : VueJS
```

#### JavaScript Module Loader

CommonJS & Asynchronous Module Definition (RequireJS)

#### Package manager

NodeJS package manager (NPM), manage all the dependencies.

#### Automation tool

gulp, JavaScript streaming build system.

#### JavaScript Module Bundler

- Code Splitting
- Loaders
- Plugin system

webpack takes modules with dependencies and generates static assets representing those modules.

puts all of your assets, including Javascript, images, fonts, and CSS, in a dependency graph.

#### jQuery

- DOM traversal
- DOM manipulation
- event handling
- animation
- Asynchronous JavaScript and XML (Ajax)
- cross browsers

Make it easier to select, manipulate elements and handle events.

#### Bootstrap

- responsive
- layout
- components

HTML, CSS, Javascript templates.

#### AngularJS

- 2-ways binding
- Directives : interactivity
- Dependency Injection

It extends HTML with new attributes.

#### ReactJS

- MVVM
- reusable UI components
- one-way data flow
- virtual DOM

#### VueJS

- MVVM
- components
- state management
- 2-ways binding
- transitions
- routing

### WebApp, Hybrid Apps and Native Apps

#### Cordova

a bridge for connection between web app and mobile device to make hybrid mobile apps that can use camera, geolocation, file system and other native mobile functions.

#### Ionic

HTML5 UI Framework built on AngularJS and Cordova for Mobile.

#### React-Native

Build native mobile apps using JavaScript and React

## BackEnd

BackEnd includes :

- Web Server : Apache, Nginx
- Database : MySQL, PostgreSQL, MongoDB
- PHP, Java, NodeJS, Go, Ruby, Python

### NodeJS

- event-driven
- non-blocking I/O
- concurrent

Express.js
