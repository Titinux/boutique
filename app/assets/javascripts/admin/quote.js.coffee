computeTotalQuote = ()->
  total = 0

  $('table#order_lines tbody tr.order_line').each ->
    quantity = parseFloat($(@).find('.order_lines_quantity input').val())
    quantity = 0 if isNaN(quantity)

    uprice   = parseFloat($(@).find('.order_lines_unitaryPrice input').val())
    uprice = 0 if isNaN(uprice)

    total += quantity * uprice

  total

formatted_number = (x)->
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")

jQuery ->
  $('body.orders.quote .order_lines_unitaryPrice input').on 'keyup', ->
    $('span.total').html(formatted_number(computeTotalQuote()))
