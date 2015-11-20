
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
var thumbnailWidth   = '297'
var thumbnailHeight  = '210'
cataloghelper.process("www/catalog.pdf", targetPageNumber, thumbnailWidth, thumbnailHeight, success, failure);
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

Replace two files and copy catalog.pdf

```
$ cp ../cordova-plugin-catalog-helper/examples/index.html www/index.html 
$ cp ../cordova-plugin-catalog-helper/examples/index.js www/js/index.js 
$ cp ../cordova-plugin-catalog-helper/examples/catalog.pdf www/
```

Install iOS platform

```
$ cordova platform add ios
```

Run the code

```
cordova run ios --target="iPad-2"
```

## More Info

[Introduction Cordova Catalog Helper Plugin](http://qiita.com/mindboard/items/6f74c360a2d99435652f)


