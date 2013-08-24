# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Edit user form 
$ ->
   $('.editUserName').tooltip(title: "Update your name", placement: "right")
   $('.editUserID').tooltip(title: "Update your student ID", placement: "right")
   $('.editUserPassword').tooltip(title: "Update your password", placement: "right")
   $('.editUserConfirm').tooltip(title: "Confirm new password", placement: "right")
