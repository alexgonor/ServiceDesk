<% js = escape_javascript(
  render(partial: 'tickets/list', locals: { tickets: @tickets })
) %>
$("#filterrific_results").html("<%= js %>");
