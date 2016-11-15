// Phoenix namespace is:   FEENX

// statement below to establish fnx namespace
var FEENX = FEENX || {};

// Force Focus object
//
// parameters:
//		none
//	options:
//		none

FEENX.Focus = (function () {

	var SetFocus = function ( formField ) {
		var that  = Object.create(null);

		var focusFormField = formField;

		this.focusFormField = function() {  return focusFormField; }

		var onDocumentReady = function () {
			var that = this;
			$(document).on("ready", function() {
				$('#'+that.focusFormField()).focus();

			});
		};

		// register the document ready event handler
		onDocumentReady();

		return that;
	}

	return { SetFocus }
}());
