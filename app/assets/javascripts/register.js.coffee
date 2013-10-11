# coffescript to handle token input for registering for courses

                
ready = ->
   $('#user_course_tokens').tokenInput("/registrations.json", { 
      crossDomain: false,
      theme: "facebook",
      preventDuplicates: true,
      searchDelay: 500,
      minChars: 3,
      hintText: "Type in a search term(e.g MATH or MATH 123 or Linear algebra)",
      propertyToSearch: "name",
      resultsFormatter: (item) ->
         if item.term == "FALL"
            return "<li><i class='icon-leaf text-error'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-error'>" + item.section + "</strong>: " + item.course_title + "</li>"
         if item.term == "WINTER"
            return "<li><i class='icon-asterisk text-info'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-info'>" + item.section + "</strong>: " + item.course_title + "</li>"
         if item.term == "SUMMER"
            return "<li><i class='icon-sun text-warning'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-warning'>" + item.section + "</strong>: " + item.course_title + "</li>"
      ,
      tokenFormatter: (item) ->
         if item.term == "FALL"
            return "<li><p><i class='icon-leaf text-error'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-error'>" + item.section + "</strong>: " + item.course_title + "</p></li>"
         if item.term == "WINTER"
            return "<li><p><i class='icon-asterisk text-info'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-info'>" + item.section + "</strong>: " + item.course_title + "</p></li>"
         if item.term == "SUMMER"
            return "<li><p><i class='icon-sun text-warning'></i> " + item.term + " | " + item.subject_code + "-" + item.course_num + "-" + "<strong class='text-warning'>" + item.section + "</strong>: " + item.course_title + "</p></li>"
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

