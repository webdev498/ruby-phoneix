module PhxSearchJavascriptHelper


  def phx_search_caller_javascript searchModel, mainModel, triggerField, answerIdField, controller="", refreshScreen = false, additionalAnswerFields=[]

      pSearchModel = searchModel.pluralize
      cSearchModel = searchModel.capitalize
      pcSearchModel = cSearchModel.pluralize   # capitalize + pluralize

      pMainModel = mainModel.pluralize
      cMainModel = mainModel.capitalize
      pcMainModel = cMainModel.pluralize   # capitalize + pluralize

      controller = searchModel unless !controller.empty?

      fieldNamePrefix = (mainModel.empty? ? "" : mainModel + '_') + searchModel + '_'

      triggerFieldName  =  fieldNamePrefix + triggerField
      answerIdFieldName =  fieldNamePrefix + answerIdField

      answerFieldsString = "$('##{answerIdFieldName}').val( selected_#{answerIdField} ); "
      additionalAnswerFields.each do |af|
          prefixedField = fieldNamePrefix + af
          fld = "$('##{prefixedField}').val( selected_#{af} );"
          answerFieldsString << fld
      end

      # for jQuery change event to fire since val on id is set programmatically
      # some searches need to know when the id changes
      # trigger after all the data fields values are set
      # remember ... when this fires, we may still likely be in the search model

      %{
function get#{cSearchModel}() {
        window.location.replace( "/#{controller}/" + $("##{answerIdFieldName}").val() );
}

$('##{triggerFieldName}').on("keypress", function(e) {
    var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;

    if(key == 13) {
        // register the callback to save the information based
        // on the change to search item id
        $.get( "/#{controller}/next#{pcSearchModel}?start="+$('##{triggerFieldName}').val(),
            function( data ) {
            });
        return false;
        }
});

$('##{searchModel}_search_modal_partial').on('shown.bs.modal', function () {

    $( document ).off( "phx-selected-#{searchModel}" );

    $( document ).on( "phx-selected-#{searchModel}",
        function( event, selected_id, selected_display_name ) {

            #{answerFieldsString}

            if( #{refreshScreen} ) {
                window.location.replace( "/#{pSearchModel}/" + $("##{answerIdFieldName}").val() );
            } else {
                $("##{searchModel}SearchModal").modal("toggle");
            }
    });
});
        }.html_safe
    end



    def phx_search_modal_javascript model

        cModel = model.capitalize

      %{
// bootstrap bug fix below
$(".modal-backdrop").remove();

// light up the modal; focus for 0-9 input; trigger search open event
$("##{model}SearchModal").modal("toggle");
$("##{model}SearchModal_Keys1_9").focus();
//$("##{model}SearchModal").on("open", function(e) { $("##{model}SearchModal_Keys1_9").focus(); });
$(document).trigger("#{model}_search_event:open" );

function triggerSearchSelection( selectedSearchItem ) {
	$( document ).trigger( "phx-selected-#{model}",
    						[ selectedSearchItem.data("phxSearch#{cModel}Id"),
                              selectedSearchItem.data("phxSearch#{cModel}DisplayName"),
                              selectedSearchItem.data("phxSearch#{cModel}FirstName"),
                              selectedSearchItem.data("phxSearch#{cModel}LastName") ] );
	$("##{model}_modal_close_btn").trigger("click");
    $(document).trigger("#{model}_search_event:close" );
    }

$(".clickable-#{model}Row").click( function() {
	triggerSearchSelection( $(this) );
	});

$("##{model}SearchModal_Keys1_9").on("keypress", function(e) {
		var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
		if( key >= 48 && key <= 57 ) {
				triggerSearchSelection( $("##{model}Row" + (key-48).toString()) );
				return false; }
		if (key == 27) { $("##{model}SearchModal_close_btn").trigger("click");
            $(document).trigger("#{model}_search_event:close" );
            return false; }
		if (key == 43) { $("#createNew#{cModel}Button").trigger("click");
            $(document).trigger("#{model}_search_event:close" );
            return false; }
	});
        }.html_safe
    end

end
