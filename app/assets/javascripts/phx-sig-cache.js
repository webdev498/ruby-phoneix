// Phoenix namespace is:   FEENX

// statement below to establish fnx namespace
var FEENX = FEENX || {};

// SIG CODE object
//    instantiation -    myObject = phxRefreshSigCache( );
//
// parameters:
//		none
//	options:
//		none

FEENX.Sig = (function () {

	var SigCache = function () {

		var that  = Object.create(null);
		var sigCache = Object.create(null);

		// cache path
		getCachePath = function(param) {
			return "/sigCodes/refreshCache";
		};

		// get the cache
		getCache = function() {
			$.get( "/prescriptions/refreshSigCache", function(data) {
				$.each( data, function( idx, sig ) {
					sigCache[sig.code.toUpperCase()] = sig.expanded;
				});
			});
		};


		// TODO: add a model that factors out the $("#prescription_directions")
		//       so that any screen field can provide sig caching
		var onDirectionsKeypress = function () {
			var that = this;
			$("#prescription_directions").on("keypress keydown", function(evt) {
				if( evt.which == 32 || evt.which == 9) {  // blank space
					var directions = $("#prescription_directions").val();
					// search for a sig and replace if found
					var lastWordPlace = directions.lastIndexOf(" ")+1;
					var lastWord = directions.substring(lastWordPlace, directions.length);
					var sigText = sigCache[lastWord.toUpperCase()];
					if( sigText) {
						var newDirections = directions.substring(0, lastWordPlace) + sigText + " ";
						$("#prescription_directions").val( newDirections );
					}
				}
			});
		};

		// register the keypress event handler for the directions
		onDirectionsKeypress();

		// load up the cache
		getCache();

		return that;
	}

	return { SigCache }
}());
