filterSearch = (selector, query) ->
   query = $.trim query
   query = query.replace /\ /gi, '|'

   if query == "red"
      $('tr.error').show().addClass('visible')
      $('tr.success').hide().removeClass('visible')
      $('tr.warning').hide().removeClass('visible')
   else if query == "green"
      $('tr.error').hide().removeClass('visible')
      $('tr.success').show().addClass('visible')
      $('tr.warning').hide().removeClass('visible')
   else if query == "yellow"
      $('tr.error').hide().removeClass('visible')
      $('tr.success').hide().removeClass('visible')
      $('tr.warning').show().addClass('visible')
   else
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
      $('tbody tr').removeClass('visible').show().addClass('visible')
   else
      filterSearch('tbody tr', $(this).val())
 

search = ->
   $.get $('#courses_search').attr('action'), $('#courses_search').serialize(), null, 'script'
   false

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

   $('#courses_search input').keyup search
   # default each row to visible
   $('tbody tr').addClass('visible')
   $('#filter').show()
   $('#filter').keyup filtering

   # perform sorting
   # grab all header rows
   $('thead th.sortable').each (column) ->
      $(this).click -> 
         findSortKey = ($cell) ->
            $cell.find('.sort-key').text().toUpperCase() + ' ' + $cell.text().toUpperCase()

         if $(this).is('.sorted-asc') 
            sortDirection = -1
         else
            sortDirection = 1

         # step back up the tree and get the rows with data
         # for sorting
         $rows = $(this).parent().parent().parent().find('tbody tr').get()


         # loop through all the rows and find
         $.each $rows, (index, row) ->
            row.sortkey = findSortKey($(row).children("td").eq(column))

         # compare and sort the rows alphabetically
         $rows.sort (a, b) ->
            return -sortDirection if a.sortkey < b.sortkey
            return sortDirection if a.sortkey > b.sortkey
            0

         # add the rows in the correct order to the bottom of the table
         $.each $rows, (index, row) ->
            $("tbody").append row
            row.sortkey = null

         # identify the column sort order
         $("th").removeClass "sorted-asc sorted-desc icon-sort-by-alphabet icon-sort-by-alphabet-alt"
         $sortHead = $("th").filter(":nth-child(" + (column + 1) + ")")
         if sortDirection == 1     
            $sortHead.addClass("sorted-asc icon-sort-by-alphabet")
         else
            $sortHead.addClass("sorted-desc icon-sort-by-alphabet-alt")

         # identify the column to be sorted by
         $("td").removeClass("sorted").filter(":nth-child(" + (column + 1) + ")").addClass("sorted")


approve = ->
   $('.approve').mouseover ->
      $(this).removeClass('icon-star')
      $(this).addClass('icon-star-empty')
      $(this).text("Click to Unapprove")


   $('.approve').mouseleave ->
      $(this).removeClass('icon-star-empty')
      $(this).addClass('icon-star')
      $(this).text("Approved")

   $('.unapprove').mouseover ->
      $(this).removeClass('icon-star-empty')
      $(this).addClass('icon-star')
      $(this).text("Click to Approve")

   $('.unapprove').mouseleave ->
      $(this).removeClass('icon-star')
      $(this).addClass('icon-star-empty')
      $(this).text("UnApproved")

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('mouseover', approve)