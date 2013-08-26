# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Edit user form 
$ ->
   $('.editUserName').tooltip(title: "Update your name", placement: "right")
   $('.editUserID').tooltip(title: "Update your student ID", placement: "right")
   $('.editUserPassword').tooltip(title: "Update your password", placement: "right")
   $('.editUserConfirm').tooltip(title: "Confirm new password", placement: "right")

# Sign up form
$ ->
   $('.newUserName').tooltip(title: "Enter your full name", placement: "right")
   $('.newMcGillEmail').tooltip(title: "Enter your email", placement: "right")
   $('.newUserID').tooltip(title: "Enter your 9 digit student ID", placement: "right")
   $('.newUserPassword').tooltip(title: "Enter your password minimum 8 characters", placement: "right")
   $('.newUserConfirm').tooltip(title: "Confirm your new password", placement: "right")
   $('.newNotetaker').tooltip(title: "Check box if you are applying to be a notetaker", placement: "right")
