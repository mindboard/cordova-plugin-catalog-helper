/*global cordova, module*/

module.exports = {
    pageCount: function (pdfFilePath, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatalogHelper", "pageCount", [pdfFilePath]);
    },
    process: function (pdfFilePath, pageNumAsString, widthAsString, heightAsString, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatalogHelper", "process", [pdfFilePath,pageNumAsString,widthAsString,heightAsString]);
    }
};
