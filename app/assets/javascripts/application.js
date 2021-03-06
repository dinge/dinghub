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
//
// require turbolinks # disabled
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery.microdata
//= require jquery-observe
//= require jquery.update_with

//= require dinghub
//= require global_search
//= require card

//= require maker
//= require maker.control_bar
//= require maker.creator
//= require maker.editor
//= require maker.classic_editor
//= require maker.mixer


$(document).ready(function() {
  $(document).foundation();
});


$.ajaxSetup({
  beforeSend:function(){
    $('#spinner').addClass('active fa-spin');
  },
  complete:function(){
    $('#spinner').removeClass('active fa-spin');
  }
});