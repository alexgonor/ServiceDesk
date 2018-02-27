module TicketsHelper

  def type_of_ticket_options
     [
       ['Repaire', 0],
       ['Service  request', 1],
       ['Permission request', 2 ]
     ]
  end

  def responsible_unit_options
     [
      ['Repaire', 0],
      ['Service', 1],
      ['Security', 2 ]
     ]
  end
end
