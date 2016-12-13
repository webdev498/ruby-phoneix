// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// = require jquery_ujs
// = require turbolinks
// = require bootstrap-sprockets
// = require bootstrap-datepicker.js
// = require_tree .

/**
 * Created by webdev on 10/10/16.
 */
var FEENX = FEENX || {};

$(document).ready(function() {

    $('.float-dollar > input').each(function(index){
        var break_type = $('#price_schedule_break_type').val();
        var precision = 2;
        if (break_type == 0)
            precision = 2;
         var val = parseFloat($(this).val());
         val = val.toFixed(precision);
         $(this).val(val);
    });

    $('#prescription_payment_type').focus(function() {
        var customer_id = $('#customer_id_field').val();
        $.get( "../customers/search_active?customer_id="+customer_id , function( data ) {

        });
    });

    var sel = $('#claim_seg_sel').val();
    $('.ctrl-segment').hide();
    $('.ctrl-'+sel).show();

    $('#claim_seg_sel').change(function(e) {
        $('.ctrl-segment').hide();
        $('.ctrl-'+this.value).show();
    });

    $('#customer-plan-tbl tr').click(function() {

        var plan_type = $(this).children('td:nth(5)').text().trim();
        var val=3;
        if(plan_type == "insurance") val= 3;
        else if(plan_type == "workers_comp") val=4;
        else val = 5
        location.href = '?sub_index=' + $(this).find(':last-child').text().trim()+"&tab_index="+val;
    });
    // $("#tabs > li:nth-child(5)").addClass('disabled');

    $("#tabs > li").click(function(){
        if($(this).hasClass("disabled"))
            return false;
    });
});





