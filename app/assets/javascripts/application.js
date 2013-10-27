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
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
    simple_crumbs();
});

function simple_crumbs(){
    var pathname_arr = window.location.pathname.split("/"),
        crumbs = "<a href='/'>Home</a> &raquo; ";

    for(var i=1; i < pathname_arr.length; i++){
        if(i === 1){
            if(controller_name === pathname_arr[1]){
                pathname_arr[1] = "<a href='"+controller_index+"'>"+
                                  capitaliseFirstLetter(controller_name)+"</a>";
            }
        }else{
            pathname_arr[i] = capitaliseFirstLetter(pathname_arr[i]);
        }
        console.log(pathname_arr[i]);
        crumbs += "  "+pathname_arr[i] + " &raquo;"
    }
    crumbs = crumbs.replace(/&raquo;$/, '');

    $("#simple-crumbs").html(crumbs);

}

function capitaliseFirstLetter(string)
{
    return string.charAt(0).toUpperCase() + string.slice(1);
}
