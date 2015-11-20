var app = {
	// Application Constructor
	initialize: function() {
		this.bindEvents();
	},
	// Bind Event Listeners
	//
	// Bind any events that are required on startup. Common events are:
	// 'load', 'deviceready', 'offline', and 'online'.
	bindEvents: function() {
		document.addEventListener('deviceready', this.onDeviceReady, false);
	},
	// deviceready Event Handler
	//
	// The scope of 'this' is the event. In order to call the 'receivedEvent'
	// function, we must explicitly call 'app.receivedEvent(...);'
	onDeviceReady: function() {
		app.receivedEvent('deviceready');

		var failure = function() {};

		var showCatalog = function( pageCountAsString ) {

			var itemLoaded = function(base64png) {
				var imgElement = document.createElement("img");
				imgElement.setAttribute("src", "data:image/png;base64," + base64png);
	
		   		var placeHolderElement = document.getElementById('place-holder');
				placeHolderElement.appendChild(imgElement);
		   	};

			var pageCount = parseInt( pageCountAsString );
			for( var index=0; index<pageCount; index++ ){
				var targetPageNumberAsString = String(index+1);
				cataloghelper.process("www/catalog.pdf",targetPageNumberAsString,"297","210", itemLoaded, failure);
			}
	   	};

		cataloghelper.pageCount("www/catalog.pdf", showCatalog, failure);
	},
	// Update DOM on a Received Event
	receivedEvent: function(id) {
	}
};

app.initialize();
