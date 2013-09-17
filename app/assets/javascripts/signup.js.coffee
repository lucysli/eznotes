appendEmailAddress = ->
   # get the value of the email field in the note taker signup form
   text = $('#signup_email').val()
   # defined the pattern we want to match against
   # in this case we want to look for the '@' symbol
   # in the inputed text field
   emailPattern = /// # beginining of line
      .*              # one or more of anything
      @               # followed by an @
      ///i            # endo of line ignore case
   
   # if the pattern is matched search for '@mail.mcgill.ca'
   # if the @mail.mcgill.ca already exists then make sure you
   # perform some cleanup so that that is the only thing appended
   # to the user email
   emailEnd = "@mail.mcgill.ca"
   if emailPattern.test(text)
      index = text.indexOf emailEnd
      if index != -1
         $('#signup_email').val(text.substring(0,index+emailEnd.length))
      else
         $('#signup_email').val(text.substring(0,text.indexOf "@") + emailEnd)
   else
      # if there is no @ symbol then append @mail.mcgill.ca
      $('#signup_email').val(text + emailEnd)

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
   # append @mail.mcgill.ca to end of email once user finishes typing
   # in the email field of the sign up form
   $('#signup_email').focusout appendEmailAddress
   # enable inline validation for the sign up form
   $("input").not("[type=submit]").jqBootstrapValidation()
   
   
$(document).ready(ready)
$(document).on('page:load', ready)
