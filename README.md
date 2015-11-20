
# Cordova Catalog Helper Plugin (iOS)

Simple plugin for handling PDF file.

It has just two features.

1. get page count from pdf file
2. get PNG(base64string) data from pdf file


## Introduction

Get page count

```javascript
var success = function( pageCount ) {
	alert( 'pdf-page-count : '+pageCount );
};

var failure = function(){
};

cataloghelper.pageCount("www/catalog.pdf", success, failure);
```

Get PDF(base64string) data

```javascript
var success = function( base64png ) {
	alert( 'png base64 string : '+base64png );
};

var failure = function(){
};

var targetPageNumber = '1'; // 1-index method
cataloghelper.process("www/catalog.pdf", targetPageNumber,"297","210", success, failure);
```

For more details, see examples/index.html and index.js.


## Usage

Clone the plugin

```
$ git clone https://github.com/mindboard/cordova-plugin-catalog-helper.git
```

Create a new Cordova Project

```
$ cordova create catalog com.example.catalogapp Catalog
```

Install the plugin

```
$ cd catalog
$ cordova plugin add ../cordova-plugin-catalog-helper
```

Replace under two files

- replace www/index.html with examples/index.html
- replace www/js/index.js with examples/index.js

and copy examples/catalog.pdf to www/catalog.pdf.

Install iOS platform

```
$ cordova platform add ios
```

Run the code

```
cordova run ios --target="iPad-2"
```

## More Info


