client = Slack::RealTime::Client.new

client.on :hello do
  puts 'Successfully connected.'
end

client.on :message do |data|
  case data['text']
  when 'bot hi'
    client.message channel: data['channel'], text: "Hi <@#{data['user']}>, nice to see you. My commands are: users, tickets, tickets_count, github, good_bye"
  when 'bot users'
    client.message channel: data['channel'], text: "#{User.all.map{ |u| u.username}.join(", ")}"
  when 'bot tickets'
    client.message channel: data['channel'], text: "#{Ticket.all.map{ |t| t.title}.join(", ")}"
  when 'bot tickets_count'
    client.message channel: data['channel'], text: "For now I have #{Ticket.all.count} tickets"
  when 'bot github'
    client.message channel: data['channel'], text: "https://github.com/alexgonor/ServiceDesk"
  when 'bot good_bye'
    client.message channel: data['channel'], text: "I hope to see you soon.. https://img00.deviantart.net/43d5/i/2016/063/8/4/detective_sad_robot_by_spikesthecat-d9tv8se.png"
  end
end

client.start!
