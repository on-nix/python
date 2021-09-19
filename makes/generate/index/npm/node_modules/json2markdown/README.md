json2markdown
=============

Convert an array of JSON data to a [markdown table in the GFM style](https://help.github.com/articles/github-flavored-markdown#tables).

Install
-------

```
$ npm install --save json2markdown
```

Usage
-----

```
var json2markdown = require('json2markdown');

var myJson = [
  {
    name: "Jason Bateman",
    occupation: "Actor",
    age: 45
  },
  {
    name: "Jason Derulo",
    occupation: "Singer-songwriter",
    age: 24
  },
  {
    name: "Jason Mraz",
    occupation: "Singer-songwriter",
    age: 37
  }
];

console.log(json2markdown(myJson));

/*
Outputs:

| name | occupation | age |
| ---- | ---------- | --- |
| Jason Bateman | Actor | 45 |
| Jason Derulo | Singer-songwriter | 24 |
| Jason Mraz | Singer-songwriter | 37 |

*/
```
