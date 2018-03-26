// Phoenix namespace is:   FEENX

// statement below to establish fnx namespace
var FEENX = FEENX || {};

// Search object
//    instantiation -    myObject = phxSearch( );
//
// parameters:
//		model is the model of the rails activeRecord we are searching
//	options:
//		context - the context that model is being searched under
//		prefix - prefix to use on fields, hidden fields, data- attributes, etc.
//		fields - a collection of selected item model fields to remember (id always is remembered)
//				a field { fieldName: {element rowId, ... } }
//		refresh - boolean to signify whether the selection triggers a refresh
//		triggerField - form field that triggers the search when the <return> key is hit
//		modalId - the name of the modal ... must exactly match the <div's> id in the form
//		refresh - when true, will refresh the form using the selected item's id
//		refreshTo - exact path (as in the routes.rb) for the refresh
//			TODO: future change, might not need the refresh boolean

FEENX.Search = (function () {

    var NewSearch = function (model, options) {

//**** TODO: loop to set data attribute ruby code
//**** TODO: loop to create data-* tag attributes
//**** TODO: loop to for hidden field capture from data-* tag attributes
//**** TODO: might need to set event callback to capture selected search element data
//**** TODO: might need to set event callback to either: fill data, or REST get data
        var that  = Object.create(null);		// search object
        var model = model;
        var activeOnly = options.activeOnly || false;
        var fields = Object.create(null);  // rails fields, always have id & displayName
        var context = options.context || '';
        var fieldPrefix  = options.fieldPrefix || '';
        if(fieldPrefix !== '') { fieldPrefix += '_'};
        var triggerField = options.triggerField || '';
        var triggerObj = options.triggerObj || null;
        var basePath = options.basePath || '';
        var nextMethod   = options.nextMethod || '';
        var refresh      = options.refresh || false;
        var refreshTo    = options.refreshTo || '';
        var onAbortFocusTo = options.onAbortFocusTo || '';
        var customProcessSearchSelection = options.customProcessSearchSelection || null;
        var triggerFieldCaption = options.triggerFieldCaption || 'start';
        var modalWidth = options.modalWidth || null;

// !!!!! the modalId may need to change depending on the the context !!!!!!
// e.g.   item search for item maintenance is one modalId
// e.g.   ... at this time compounds for a compound drug would be under another modalId
// e.g.   ... future ... all item searches would be through the same modal, and the
// e.g.   ... respective search data models would handle their own structures and data management rev 4.1
        var modalId = options.modalId || (model + 'SearchModal');
        var hiddenDivId = options.hiddenDivId || "hidden_fields";

        that.model   = function() {  return model; }
        that.context = function() {  return context; }
        that.prefix  = function() {  return fieldPrefix; }
        that.refresh = function() {  return refresh; }
        that.eventScope = function() { return model+ ((context == '') ? '' : ('-'+context)); }
        that.done    = function() { return this.eventScope()+'_done'; }
        that.onAbortFocusTo = function() {  return onAbortFocusTo; }

        function upperCaseModel() {
            return model.charAt(0).toUpperCase() + model.slice(1);
        };


        // getPath format example:    /customer/nextcustomers?start='SMITH'
        that.getPath = function(param) {
            if(basePath != ''){
                var path = basePath;
                var key13context = '';
                var triggerFieldVal = '';
                key13context = (context == '') ? model : context;

                if(Array.isArray(triggerField)){
                    path += '?';
                    triggerField.forEach(function(item){
                        triggerFieldVal = $('#' + key13context + '_' + fieldPrefix + item).val();
                        path += item + '='+triggerFieldVal + '&';
                    });
                }else{
                    path += '?';
                    if(triggerObj){
                        triggerFieldVal = triggerObj.val();
                        path+= triggerFieldCaption+'='+triggerFieldVal;

                    }else {
                        triggerFieldVal = $('#' + key13context + '_' + fieldPrefix + triggerField).val();
                        path += triggerField + '=' + triggerFieldVal;
                    }
                }
                return path;
            }else {
                var key13context = '';
                var triggerFieldVal = '';
                if (triggerObj)
                    triggerFieldVal = triggerObj.val();
                else
                    if (triggerField) {
                        key13context = (context == '') ? model : context;
                        triggerFieldVal = $('#' + key13context + '_' + fieldPrefix + triggerField).val();
                    }

                var actualNextMethod = "";
                if (nextMethod == '') {
                    actualNextMethod = "/next" + upperCaseModel().replace(/_\w/g, function (m) {
                            return m[1].toUpperCase();
                        }) + "s";
                } else {
                    actualNextMethod = nextMethod;
                }

                var controllerContext = (context == '') ? model : context;
                return "/" + controllerContext
                    + actualNextMethod
                    + "?start=" + triggerFieldVal
                    + param;
            }
        };


        // TODO: need to remember if the attributes have been added to the form !!
        that.dataFormattedAttributes = function () {
            var dataString = "";
            $.each( fields, function( attr, value ) {
                dataString += ("data-search-" + model + "-" + attr + "=");
            });
            return dataString;
        };


        // TODO: may need a separate fn to add individual hidden fields
        // TODO: may need to remember whether or not the hidden fields have been added !!
        that.addHiddenFields = function () {
            $.each( fields, function( key, value ) {
                if( value.hidden ) {
                    var newHiddenField;
                    if(key=='id' && context) {  // special case when context involved TODO: fix code below
                        newHiddenField= $('<input>').attr({
                            type: 'hidden',
                            name: context + '[' + model + "_"+ key + ']',
                            id:   model + '_' + key,
                        }).appendTo('#'+hiddenDivId);
                    } else {
                        newHiddenField= $('<input>').attr({
                            type: 'hidden',
                            name: model + '[' + key + ']',
                            id:   model + '_' + key,
                        }).appendTo('#'+hiddenDivId);
                    }
                    value.hiddenField = newHiddenField;
                }
            });
        };


        // TODO: need to make this method more robust
        that.onAbortSearch = function() {
            var that = this;
            $("#" + modalId).on("hide.bs.modal", function(evt) {
                $('#'+that.onAbortFocusTo()).focus();
            });
        };


        var onKeys0_9 = function () {
            var that = this;
            $("#" + modalId + "_Keys1_9").off().on("keypress", function(evt) {
                var key = evt.charCode ? evt.charCode : evt.keyCode ? evt.keyCode : 0;
                if( key >= 48 && key <= 57 ) {
                    // gather up all the data values and remember them in our model and respective hidden fields
                    var target = $("#"+ modalId + "-row" + (key-48).toString());
                    // id is always a defined field and only shows in valid search rows
                    if( target.attr("data-phx-search-"+model+"-id") !== undefined) {
                        if (customProcessSearchSelection)
                            customProcessSearchSelection(target);
                        else
                            processSearchSelection(target);
                    }
                    return false;
                }
                // <esc> key - close the search modal
                // signal escaped
                if (key == 27) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // <+> key - open page to create a new model instance
                // TODO: during testing just close below ... future will require model create screen
                if (key == 43) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // enter key -> do nothing
                if (key == 13) {	return false; }
            });
        };

        // ADD AN INGREDIENT WITH TO A FORMULA
        var onIngredientsKeys0_9 = function () {
            var that = this;
            $("#" + modalId + "_Keys1_9").off().on("keypress", function(evt) {
                var key = evt.charCode ? evt.charCode : evt.keyCode ? evt.keyCode : 0;
                if( key >= 48 && key <= 57 ) {
                    // gather up all the data values and remember them in our model and respective hidden fields
                    var target = $("#"+ modalId + "-row" + (key-48).toString());
                    // id is always a defined field and only shows in valid search rows
                    if( target.attr("data-phx-search-"+model+"-id") !== undefined) {
                        processIngredientSearchSelection(target);
                    }
                    return false;
                }
                // <esc> key - close the search modal
                // signal escaped
                if (key == 27) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // <+> key - open page to create a new model instance
                // TODO: during testing just close below ... future will require model create screen
                if (key == 43) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // enter key -> do nothing
                if (key == 13) {	return false; }
            });
        };

        // REPLACING AN EXISTING INGREDIENT WITH ANOTHER ONE IN A FORMULA
        var onExistingIngredientsKeys0_9 = function () {
            var that = this;
            $("#" + modalId + "_Keys1_9").off().on("keypress", function(evt) {
                var key = evt.charCode ? evt.charCode : evt.keyCode ? evt.keyCode : 0;
                if( key >= 48 && key <= 57 ) {
                    // gather up all the data values and remember them in our model and respective hidden fields
                    var target = $("#"+ modalId + "-row" + (key-48).toString());
                    // id is always a defined field and only shows in valid search rows
                    if( target.attr("data-phx-search-"+model+"-id") !== undefined) {
                        processExistingIngredientSearchSelection(target);
                    }
                    return false;
                }
                // <esc> key - close the search modal
                // signal escaped
                if (key == 27) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // <+> key - open page to create a new model instance
                // TODO: during testing just close below ... future will require model create screen
                if (key == 43) { $("#"+modalId+"-close-btn").trigger("click"); return false; }
                // enter key -> do nothing
                if (key == 13) {	return false; }
            });
        };


        that.onKey13 = function() {
            var that = this;
            var event_handler = function(evt) {
                var key = evt.charCode ? evt.charCode : evt.keyCode ? evt.keyCode : 0;
                // ajax to get the search modal populated with next batch of data
                if (key == 13) {
                    $.get(that.getPath(""), function (data) {
                    });
                    return false;
                }
            };
            if(triggerObj){
                triggerObj.off('keypress').on("keypress", event_handler);
            }else{
                var key13context = (context == '') ? model : context;
                if(Array.isArray(triggerField)){
                    triggerField.forEach(function(item){
                        $('#'+key13context+'_'+fieldPrefix+item).off().on("keypress", event_handler);
                    });
                }
                else
                    $('#'+key13context+'_'+fieldPrefix+triggerField).off().on("keypress", event_handler);
            }

        };


        that.doSearch = function(param) {
            start_id = "&startId="+param;
            $.get( that.getPath(start_id), function(data) {

            });
            return false;
        }

        // This handles the processing for selecting a new ingredient to a formula

        function processIngredientSearchSelection( selectedSearchItem ) {
            var target = selectedSearchItem;
            $.each( fields, function( key, value ) {
                var field = getAttribute(key);
                var targetValue = target.attr("data-phx-search-"+model+"-"+key);
                getAttribute(key).value = targetValue;
                if( value.hidden ) {
                    field.hiddenField.val(targetValue);
                }
                if( field.visibilityField != null ) {
                    var visibilityContext = (context != '') ? (context + '_') : '';
                    $('#'+visibilityContext+model+'_'+field.visibilityField).val(targetValue);
                }
            });

            $.get( ('/item/ingredient_details/' + fields['id'].value +"?compound_id="+ $("#formula-parent-item-id").val() ), function(data) {
                console.log((data));
                $("#new-compound-search").html(data);
                $("#" + modalId).modal("hide");
                attachIngredientSearchHandlers();
                setIngredientRowHandlers();
                $("#new-compound-ingredient").focus();
            })
            // determine whether next action is remote vs local
        }

        // This handles the processing for selecting an ingredient to replace an existing ingredient to a formula
        function processExistingIngredientSearchSelection( selectedSearchItem ) {
            var target = selectedSearchItem;
            var currentCompoundId = $("#current-ingredient-id").val()
            $.each( fields, function( key, value ) {
                var field = getAttribute(key);
                var targetValue = target.attr("data-phx-search-"+model+"-"+key);
                getAttribute(key).value = targetValue;
                if( value.hidden ) {
                    field.hiddenField.val(targetValue);
                }
                if( field.visibilityField != null ) {
                    var visibilityContext = (context != '') ? (context + '_') : '';
                    $('#'+visibilityContext+model+'_'+field.visibilityField).val(targetValue);
                }
            });
            $.ajax({
                url: "/formulas/updateIngredient/"+currentCompoundId,
                method: "put",
                data: {
                    base_item_id: fields['id'].value
                }
            }).done(function(data) {
                $("#" + modalId).modal("hide");
                $("#ingredient-list").html(data);
                attachIngredientSearchHandlers();
                setIngredientRowHandlers();
                $("#ingredient-name-"+currentCompoundId).focus();
            }).fail(function(error){
                console.log("Failed to do the job",error)
            })

        }


        function onModalClosed() {
            $("#itemSearchModal").on("hide.bs.modal",function(item){
                $("#new-compound-ingredient").focus()
            })
        }
        // !!!! THIS is where the selected item information is processed !!!
        function processSearchSelection( selectedSearchItem ) {
            var target = selectedSearchItem;
            $.each( fields, function( key, value ) {
                var field = getAttribute(key);
                var targetValue = target.attr("data-phx-search-"+model+"-"+key);
                getAttribute(key).value = targetValue;
                if( value.hidden ) {
                    field.hiddenField.val(targetValue);
                }
                if( field.visibilityField != null ) {
                    var visibilityContext = (context != '') ? (context + '_') : '';
                    $('#'+visibilityContext+model+'_'+field.visibilityField).val(targetValue);
                }
            });
            debugger;

            // determine whether next action is remote vs local
            if( refresh ) {
                if( refreshTo ) {
                    window.location.replace( refreshTo + fields['id'].value );
                }
                else {
                    window.location.replace( '/'+model+'s/' + fields['id'].value );
                }
            } else {
                // any local actions here ...
                $("#" + modalId).modal("hide");
                $(that).trigger(that.done(), [fields['id'].value]);
            }
        }


        // attribute management:
        // add attributes to the search object
        // initial search instantiation will automtically create two attributes for 'id' and 'name'
        // since every form must have an id and name

        // TODO: need to consider how to handle attempting to add a duplicate attribute
        that.addAttribute = function(attr, hidden, attrValue, visibilityField) {
            if( fields[attr]) { return; };
            var newAttribute = {};
            newAttribute.key = attr;
            newAttribute.hidden = hidden;
            newAttribute.hiddenField = null;
            newAttribute.value = attrValue;
            newAttribute.visibilityField = visibilityField;
            Object.defineProperty( fields, attr, {
                value: newAttribute,
                writable: true,
                enumerable: true,
                configurable: true
            });
        };


        var getAttribute      = function(attr) { return fields[attr]; }
//		that.setAttributeValue = function(attr, val) { fields[attr].value = val; }
        that.getAttributeValue = function(attr) { return fields[attr].value; }
        that.allAttributes = function() { return fields; };

        // before we leave ...
        // create the minimum default attributes
        that.addAttribute('id', true, '', null);  // rails fields, always have id
        that.addAttribute('name', false, '', null);  // rails fields, always have display name

        // register the event ... whenever a Kaminari paginate operation is clicked
        // TODO: put code below into common proc
        $("#"+model+"_search_modal_partial").off().bind('contentchanged', function() {
            // bootstrap bug fix below
            $(".modal-backdrop").remove();
            onKeys0_9();
            // light up the modal; focus for 0-9 input
            $("#" + modalId + "> .modal-dialog").css('width', modalWidth + 'px' );
            $("#" + modalId).modal("show");
            $("#" + modalId + "_Keys1_9").focus();
            $(".clickable-"+modalId+"-row").off().click( function() {
                if(customProcessSearchSelection)
                    customProcessSearchSelection($(this));
                else
                    processSearchSelection( $(this) );
            });

            // set up to trap modal close via escape or close without selection
            that.onAbortSearch();
        });

        // This handles the modal for adding an ingredient to a formula
        $("#"+model+"_search_modal_partial").bind('ingredientscontentchanged', function() {
            // bootstrap bug fix below
            $(".modal-backdrop").remove();
            onIngredientsKeys0_9();
            onModalClosed();
            // light up the modal; focus for 0-9 input
            $("#itemSearchModal").modal("show");
            $("#itemSearchModal_Keys1_9").focus();
            $(".clickable-"+modalId+"-row").off().click( function() {
                processIngredientSearchSelection( $(this) );
            });

            // set up to trap modal close via escape or close without selection
            that.onAbortSearch();
        });

        // This handles the modal for replacing an existing ingredient in a a formula
        $("#"+model+"_search_modal_partial").bind('existingingredientscontentchanged', function() {
            // bootstrap bug fix below
            $(".modal-backdrop").remove();
            onExistingIngredientsKeys0_9();
            onModalClosed();
            // light up the modal; focus for 0-9 input
            $("#itemSearchModal").modal("show");
            $("#itemSearchModal_Keys1_9").focus();
            $(".clickable-"+modalId+"-row").off().click( function() {
                processExistingIngredientSearchSelection( $(this) );
            });

            // set up to trap modal close via escape or close without selection
            that.onAbortSearch();
        });


        // and, connect the event handler to the designated target field
        that.onKey13();

        return that;
    }

    return { NewSearch: NewSearch }
}());
