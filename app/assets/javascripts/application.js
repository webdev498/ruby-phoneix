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

function openSelectionModal(caption,tblHtml,dtUrl, rowSelHandler) {

    $.get( dtUrl, function( data ) {
        var res ='';
        // $('#myModal').keydown(function(event){
        //     var keycode = event.which;
        //     if (keycode >= 49 && keycode < 58 )
        //     {
        //         var id = data[keycode-49]['id'];
        //         $('#myModal').modal('hide');
        //         location.href= id + '/edit';
        //         $('#myModal').unbind("keydown");
        //     }
        // });
        var rNo = 1;
        data.forEach(function(item) {
            res+='<tr>';
            res+='<td>'+rNo+'</td>'
            for (prop in item) {
                if (prop == 'id')
                    continue;
                if(item[prop] == null)
                    item[prop]='';
                res += '<td>' + item[prop] + '</td>';
            }
            rNo++;
            res+='</tr>';
        });

        $('#modal_table').html(tblHtml);
        $('#myModalLabel').html(caption);
        $('#modal_table').append(res);
        $('#modal_table tr').click(function() {
            var id = data[$(this).index()]['id'];
            rowSelHandler( id );
            $('#modal_table_tr').unbind("click")
        });
        $('#myModal').modal('show');
    });
}


$(document).ready(function() {

    $('.float-dollar > input').each(function(index){
        var break_type = $('#price_schedule_break_type').val();
        var precision = 3;
        if (break_type == 0)
            precision = 2;
         var val = parseFloat($(this).val());
         val = val.toFixed(precision);
         $(this).val(val);
    });

    $('#prescription_payment_type').focus(function() {
        var customer_id = $('#customer_id_field').val();
        $('#payment_type').val($('#prescription_payment_type').val());
        $.get( "../customers/search_active?customer_id="+customer_id , function( data ) {
            var res ='';
            var no = 0;
            data.forEach(function(item) {
                res+='<tr>';
                for (prop in item) {
                    if(item[prop]== null)
                        item[prop]='';
                }
                no++;
                res += '<td>' + no + '</td>';
                res += '<td>' + item['plan_id_code'] + '</td>';
                res += '<td>' + item['abbreviated_name'] + '</td>';
                res += '<td>' + item['bin_number'] + '</td>';
                res += '<td>' + item['plan_type'] + '</td>';

                res+='</tr>';
            });

            $('#myModal').keydown(function(event){
                var keycode = event.which;
                if (keycode => 49 && keycode < 58 )
                {
                    var plan_id_code = data[keycode-49]['plan_id_code'];
                    $('#myModal').modal('hide');
                    location.href = '../customers/1?sub_index=-1&plan_id_code=' + plan_id_code;
                    $('#myModal').unbind("keydown");
                }
            });

            var tbl_html = "<thead>\
                    <tr>\
                    <th> </th>\
                    <th> Plan Id Code </th>\
                    <th> Plan Name </th>\
                    <th> Bin Number </th>\
                    <th> Plan Type </th>\
                    </tr>\
                    </thead>\
                    <tbody>\
                    </tbody>";
            $("#prescription_add_btn").click(function(){
                var payment_type = $('#payment_type').val();
                location.href = '../customers/' + customer_id +'?tab_index=2';
            });


            $('#modal_table').html(tbl_html);

            $('#modal_table').append(res);
            $('#modal_table tr').click(function() {
                var plan_id_code = data[$(this).index()]['plan_id_code'];
                $('#myModal').modal('hide');
                location.href = '../customers/1?sub_index=-1&plan_id_code=' + plan_id_code;
                //$('#modal_table_tr').unbind("click");
            });
            $('#myModal').modal('show');
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
        location.href = '?sub_index=' + $(this).index()+"&tab_index="+val;
    });
    // $("#tabs > li:nth-child(5)").addClass('disabled');

    $("#tabs > li").click(function(){
        if($(this).hasClass("disabled"))
            return false;
    });
});






function modal_click() {
    var bin_number = $('#plan_bin_number').val();
    var plan_name =  $('#plan_insurance_plan_name').val();
    $.get( "search?bin_number="+bin_number+"&plan_name="+plan_name, function( data ) {
        var res ='';
        $('#myModal').keydown(function(event){
            var keycode = event.which;
            if (keycode >= 49 && keycode < 58 )
            {
                var id = data[keycode-49]['id'];
                $('#myModal').modal('hide');
                location.href= id + '/edit';
                $('#myModal').unbind("keydown");
            }
        });
        var no = 0;
        data.forEach(function(item) {
            res+='<tr>';
            for (prop in item) {
                if(item[prop]== null)
                    item[prop]='';
            }
            no++;
            res += '<td>' + no + '</td>';
            res += '<td>' + item['plan_id_code'] + '</td>';
            res += '<td>' + item['insurance_plan_name'] + '</td>';
            res += '<td>' + item['bin_number'] + '</td>';
            res += '<td>' + item['processor_control_number'] + '</td>';
            res += '<td>' + item['plan_type'] + '</td>';
            res += '<td>' + item['active'] + '</td>';

            res+='</tr>';
        });
        var tbl_html = "<thead>\
        <tr>\
        <th> </th>\
        <th> Plan Id Code </th>\
        <th> Insurance Plan Name </th>\
        <th> Bin Number </th>\
        <th> Processor Control Number </th>\
        <th> Plan Type </th>\
        <th> Active </th>\
        </tr>\
        </thead>\
        <tbody>\
        </tbody>";
        $('#modal_table').html(tbl_html);

        $('#modal_table').append(res);
        $('#modal_table tr').click(function() {
            var id = data[$(this).index()]['id'];
            $('#myModal').modal('hide');
            location.href= id + '/edit';
            $('#modal_table_tr').unbind("click");
        });
        $('#myModal').modal('show');
    });
}



