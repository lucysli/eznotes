filterSearch = (selector, query) ->
   query = $.trim query
   #query = query.replace /\ /gi, '|'

   $(selector).each ->
      if $(this).text().search(new RegExp(query, "i")) < 0
         $(this).hide().removeClass('visible')
      else
         $(this).show().addClass('visible')


filtering = ->
   # if esc is pressed or nothing is entered
   if event.keyCode == 27 or $(this).val() == ''
      # if esc is pressed we want to clear the value of search box
      $(this).val('')

      # we want each row to be visible because if nothing
      # is entered then all rows are matched.
      $('ul.users li').removeClass('visible').show().addClass('visible')
   else
      filterSearch('ul.users li', $(this).val())

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Taken from rails cast episode 390 about turbolinks

# because of turbolinks callback is only triggered on the initial page load. 
# This means that if we start on another page then move to the page for a task 
# the DOM’s ready event isn’t fired as we’re still technically on the same HTML page. 
# There are several events that Turbolinks will trigger, one of which is called page:load. 
# We can use this to simulate the DOM ready behaviour in our CoffeeScript file.

# Now we set the function that appends the email address to a variable called ready 
# and pass it to both the document.ready and the page:load events. 
# This way the events for the email text field will be attached whether 
# we’ve loaded the page via Turbolinks or not.
ready = ->
   # Sign up form 
   $('.newUserName').tooltip(title: "Enter your full name", placement: "right")
   $('.newMcGillEmail').tooltip(title: "Enter your email", placement: "right")
   $('.newUserID').tooltip(title: "Enter your 9 digit student ID", placement: "right")
   $('.newUserPassword').tooltip(title: "Enter your password minimum 8 characters", placement: "right")
   $('.newUserConfirm').tooltip(title: "Confirm your new password", placement: "right")
   $('.newNotetaker').tooltip(title: "Check box if you are applying to be a notetaker", placement: "right")

   # Edit user form
   $('.editUserName').tooltip(title: "Update your name", placement: "right")
   $('.editUserID').tooltip(title: "Update your student ID", placement: "right")
   $('.editUserPassword').tooltip(title: "Input your password to authenticate changes", placement: "right")
   $('.editUserConfirm').tooltip(title: "Confirm your password", placement: "right")

   # Admin filter search field
   $('#filter').tooltip(title: "input search text to filter data in table. Press esc key to reset", placement: "right")
   $('#course_filter').tooltip(title: "input search text to filter course data. Press esc key to reset", placement: "right")
   $('#user_filter').tooltip(title: "input search text to filter user data. Press esc key to reset", placement: "right")

   $('ul.users li').addClass('visible')
   $('#user_filter').show()
   $('#user_filter').keyup filtering
   
$(document).ready(ready)
$(document).on('page:load', ready)