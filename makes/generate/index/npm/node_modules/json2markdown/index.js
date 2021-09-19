// markdown table characters
var COL_SEP = " | ";
var COL_START = "| ";
var COL_END = " |\n";
var HEAD_SEP = "-";


// transform json to a gfm table
function jsonToMarkdownTable(json) {
  var cols = uniq(flatten(json.map(function (obj) {
    return Object.keys(obj);
  })));

  var markdown = "";

  // add columns
  markdown += COL_START + cols.join(COL_SEP) + COL_END;

  // add header separator
  markdown += COL_START + cols.map(function (col) {
    // return a fill with the the header separator character
    return stringFill(col.length, HEAD_SEP);
  }).join(COL_SEP) + COL_END;

  // add rows
  json.forEach(function (row) {
    markdown += COL_START;

    markdown += cols.map(function (col) {
      return row.hasOwnProperty(col) ? row[col] : "";
    }).join(COL_SEP);

    markdown += COL_END;
  });

  return markdown;
}


// helper functions
function flatten(arr) {
  return arr.reduce(function (a, b) {
    return a.concat(b);
  });
}

function uniq(arr) {
  var found = [];

  arr.forEach(function (item) {
    if(!~found.indexOf(item)) {
      found.push(item);
    }
  });

  return found;
}

function stringFill(n, c) {
  return new Array(n + 1).join(c);
}

// export 
module.exports = jsonToMarkdownTable;
