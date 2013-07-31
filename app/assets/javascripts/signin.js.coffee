
appendEmailAddress = ->
   # get the value of the email field in the note taker signup form
   text = $('#session_email').val()
   # defined the pattern we want to match against
   # in this case we want to look for @mail.mcgill.ca
   # in the inputed text field
   emailPattern = /// # beginining of line
      .*              # one or more of anything
      @mail.mcgill.ca # followed by an @mail.mcgill.ca sign
      ///i            # endo of line ignore case
   
   # if the pattern is matched then simply do some clean up
   # and make sure nothing comes after it
   # otherwise append it to value of the field and update
   if emailPattern.test(text)
      index = text.indexOf "@mail.mcgill.ca"
      $('#session_email').val(text.substring(0,index+15))
   else
      $('#session_email').val(text + "@mail.mcgill.ca")

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
   $('#session_email').focusout appendEmailAddress
   
$(document).ready(ready)
$(document).on('page:load', ready)
