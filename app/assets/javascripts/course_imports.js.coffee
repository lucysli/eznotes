# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
      $('div dl.course').removeClass('visible').show().addClass('visible')
   else
      filterSearch('div dl.course', $(this).val())
 


# Taken from rails cast episode 390 about turbolinks

# because of turbolinks callback is only triggered on the initial page load. 
# This means that if we start on another page then move to the page for a task 
# the DOM’s ready event isn’t fired as we’re still technically on the same HTML page. 
# There are several events that Turbolinks will trigger, one of which is called page:load. 
# We can use this to simulate the DOM ready behaviour in our CoffeeScript file.

# Now we set the function that updates the character count to a variable called ready 
# and pass it to both the document.ready and the page:load events. 
# This way the events for the comment field text area will be attached whether 
# we’ve loaded the page via Turbolinks or not.
ready = ->
   # default each row to visible
   $('div dl.course').addClass('visible')
   $('#course_filter').show()
   $('#course_filter').keyup filtering


$(document).ready(ready)
$(document).on('page:load', ready)