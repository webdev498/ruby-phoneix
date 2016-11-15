(function($){

	if(typeof($.fn.lc_switch) != 'undefined') {return false;} // prevent multiple scripts inits

	$.fn.lc_switch = function( on_text, off_text ) {

		// set to ON

		$.fn.lcs_on = function() {
			
			$(this).each(function() {
				var wrap_target = $(this).parents('.lcs_wrap');
				var input = wrap_target.find('input');
				
				input.trigger('lcs-on');
				input.trigger('lcs-statuschange');
				wrap_target.find('.lcs_switch').removeClass('lcs_off').addClass('lcs_on');
				
			});
			
			return true;
		};	

		// set to OFF

		$.fn.lcs_off = function() {

			$(this).each(function() {
				var wrap_target = $(this).parents('.lcs_wrap');
				var input = wrap_target.find('input');

				input.trigger('lcs-off');
				input.trigger('lcs-statuschange');
				wrap_target.find('.lcs_switch').removeClass('lcs_on').addClass('lcs_off');
				});

			return true;
		};


		// construct
		return this.each(function(){

			// check against double init
			if( !$(this).parent().hasClass('lcs_wrap') ) {

				// labels structure
				var on_label	= '<div class="lcs_label lcs_label_on">'+ on_text +'</div>';
				var off_label	= '<div class="lcs_label lcs_label_off">'+ off_text +'</div>';

				// default states
				var disabled 	= ($(this).is(':disabled')) ? true: false;
				var active 		= ($(this).is(':checked')) ? true : false;

				var status_classes = '';
				status_classes += (active) ? ' lcs_on' : ' lcs_off'; 
				if(disabled) {status_classes += ' lcs_disabled';} 

				// wrap and append
				var structure = 
					'<div class="lcs_switch '+status_classes+'">' +
					'<div class="lcs_cursor"></div>' +
					on_label + off_label +
					'</div>';

				if( $(this).is(':input') && $(this).attr('type') == 'checkbox' ) {
					$(this).wrap('<div class="lcs_wrap"></div>');
					$(this).parent().append(structure);

					$(this).parent().find('.lcs_switch').addClass('lcs_'+ $(this).attr('type') +'_switch');
				}
			}
		});
	};


	// handlers
	$(document).ready(function() {

		// on click
		$(document).delegate('.lcs_switch:not(.lcs_disabled)', 'click tap', function(e) {

			if( $(this).hasClass('lcs_on') ) {
					$(this).lcs_off();
			} else {
					$(this).lcs_on();	
			}
		});


		// on checkbox status change
		$(document).delegate('.lcs_wrap input', 'change', function() {

			if( $(this).is(':checked') ) {
				$(this).lcs_on();
			} else {
				$(this).lcs_off();
			}	
		});

	});

})(jQuery);
