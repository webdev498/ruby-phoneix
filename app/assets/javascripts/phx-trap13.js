// Phoenix namespace is:   FEENX

// statement below to establish fnx namespace
var FEENX = FEENX || {};

// Trap13 object
//    instantiation -
//
// parameters:
//		none
//	options:
//		none

FEENX.Trap13 = (function () {

	var Catch13 = function () {

		var that = Object.create(null);
		var onDocument13 = function () {

		$(document).on("keypress", null, "DOCUMENT", function(evt) {
		// $(document).on("keypress keyup", function(evt) {
			if( evt.which == 13 && evt.data == "DOCUMENT") {
				    // evt.stopPropagation(); // returning false will prevent the event from bubbling up.
						evt.preventDefault();
						evt.stopPropagation();

						// special case ... fire the trigger event, if <enter> is pressed on the fill/refill button in rx
						evtTarget = evt.target;
						if( evtTarget.type=="submit" && evtTarget.name=="fill" ) {
								evtTarget.click();
								return true;
						}
						return false;
				} else {
				    return true;
				}
		});
};

		// register the keypress event handler to catch all carriage returns
		onDocument13();

		return that;
	}

	return { Catch13 }
}());
