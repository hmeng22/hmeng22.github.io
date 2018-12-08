---
title: "MongooseNotes"
date: 2017-11-09T19:25:55-05:00
draft: false
---

# Mongoose Notes

Mongoose notes.

## Getting Started

- Combine multiple queries

```
Promise.all([query1.exec(), query2.exec()])

//

var queries = [];

[].forEach(() => {
  var p = new Promise((resolve, reject) => {
    // query : resolve() and reject()
  });

  queries.push(p)
})

Promise.all(queries).then((results) => {}).catch((err) => {});
```

- Find certain elements of an array inside a query
- Populate include/exclude certain fileds with conditions
- Populate nested Object

```
Model.find({
  _id: id,
	age: { $gt: 22, $lt: 28},
  like: {
    $in: ['like1', 'like2']
  }
}, 'field1 field2',
{
  'field3': {
    '$slice': [-skip, amount]
  }
})
.where()
.limit(10)
.sort({field: -1})
.select()
.populate(
  'field3', '-field4', {field5: true},
  {
    path: 'oneArray',
    model: 'Model'
    match: {
      "oneField": {
        "$in": ['value1', 'value2']
      }
    },
    select: '-available',
    options: {
      limit: 10
    },
    populate: {
      path: 'insideOneArray'
    }
  }
).exec()
```

- Set/Push a value

```
doc.update({
  field: value,
  $set: {
    field: value
  },
  $push: {
    fieldArray: value
  }
})

doc.fieldArray.push(obj)
doc.fieldArray.pull(obj)
doc.markModified('fieldArray')
doc.save(() => {})
```

## Schema

```
var s = new Schema({
    data1: {
        type: Date,
        default: Date.now
        min: Date,
        max: Date,
        required: true,
        select: true
    },
    data2: {
        type: String,
        lowercase: true,
        uppercase: true,
        trim: true,
        index: true,
        match: \w*,
        enum: ['enum1', 'enum2'],
        minlength: 18,
        maxlength: 69,
        unique: true,
        required: true,
        select: true
    },
    data3: {
        type: Number,
        min: 18,
        max: 69,
        get: v => Math.round(v),
        set: v => Math.round(v),
        required: true,
        select: true
    },
    data4: {
        type: Schema.Types.Mixed
    },
    data5: [
        {
            type: Schema.Types.ObjectId,
            ref: 'sSchema'
        }
    ]
}, {
    timestamps: true
});

s.statics.fun1 = function(para, cb) {}
s.query.fun1 = function(para) {}

s.virtual(para).set(function(){});
s.virtual(para).get(function(){});

s.method({
    m1: function() {},
    m2: function() {}
});

s.set('toJSON', {getters: true});
s.set('toObject', {getters: true});

s.data4 = {"anything"};
s.markModified('anything');
s.save();

// Serial
s.pre('save', function(next) {
    console.log('here is pre save');
    next();
});

// Parallel
s.pre('save', true, function(next, done) {
    next();
});

s.post('init', function(doc){});
s.post('validate', function(doc){});
s.post('save', function(doc){});
s.post('remove', function(doc){});
s.post('find', function(doc){});
```
