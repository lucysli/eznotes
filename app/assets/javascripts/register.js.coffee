# coffescript to handle token input for registering for courses

ready = ->
   $('#user_course_tokens').tokenInput("/registrations.json", { 
      crossDomain: false,
      theme: "facebook",
      preventDuplicates: true,
      searchDelay: 500,
      minChars: 3,
      hintText: "Type in a search term(e.g MATH or MATH 123 or Linear algebra)",
      } )

   ###
   $('select[rel="autocomplete"]').each ->
      option = []
      $(this).find('option').each ->
         option.push $(this).text()

      input = $('<input>')
      input.attr('type','text')
      input.attr('name', $(this).attr('name') )
      input.attr('id', $(this).attr('id') )  
      input.attr('class', $(this).attr('class') )
      input.attr('data-provide', 'typeahead' )
      input.attr('autocomplete', 'off' )
      input.val($(this).attr('data_default'))
      $(this).replaceWith(input)
        
      $(input).typeahead({
         source: option
      }); 
   ###

$(document).ready(ready)
$(document).on('page:load', ready)

