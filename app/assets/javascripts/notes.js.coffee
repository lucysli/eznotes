updateCountdown = ->
   # get the value of the comments text area in the note form
   text = $('#note_comments').val()
   # ignore all white space i.e. dont count it as part of the word count
   text = text.replace(/\s/g, '')
   # check to see if the user inputed more than 140 characters then
   # make sure the extra characters do not appear in the view
   if text.length > 140 
      text = text.substring(0,140)
      $('#note_comments').val(text)

   # figure out the remaining number of characters the user has left
   remaining = 140 - text.length
   # set the text of the label to display the remaining number
   $(".countdown").text remaining + ' characters remaining'
   # if there are 140 characters left i.e the user has inputed nothing
   # yet then display Comments label and show the empty comment icon
   # otherwise show the filled comment icon
   if remaining == 140
      $(".countdown").removeClass 'cus-comment'
      $(".countdown").addClass 'cus-comment-empty'
      $('.countdown').text 'Comments'
   else
      $(".countdown").addClass 'cus-comment'
      $(".countdown").removeClass 'cus-comment-empty'

   # depending on the number of remaining characters set the css color 
   # property for the countdown class accordingly
   $(".countdown").css "color", (if (140 >= remaining >= 21) then "gray")
   $(".countdown").css "color", (if (21 > remaining >= 11) then "black")
   $(".countdown").css "color", (if (11 > remaining ) then "red")

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
   $('#note_comments').change updateCountdown
   $('#note_comments').keyup updateCountdown

$(document).ready(ready)
$(document).on('page:load', ready)
