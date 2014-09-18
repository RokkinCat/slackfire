require './em-eventsource'
require 'json'
require 'httparty'

EM.run do

  source = EventMachine::EventSource.new(ENV['FIREBASE_DATA_URL'], headers = {"Accept" => "text/event-stream"})

  source.message do |message|
    puts message
  end

  source.on "put" do |msg|
    msg = JSON.parse(msg)
    unless msg["data"].nil? || msg["data"]["body"].nil?
      content = msg["data"]["body"]
      HTTParty.post(ENV['SLACK_WEBHOOK_URL'],
      {
        body: {
          payload: {
            username: "leadsbot : #{msg["data"]["user"]["thirdPartyUserData"]["login"]}",
            icon_url: "https://avatars1.githubusercontent.com/u/1031174?v=2&s=200",
            text: content
          }.to_json
        },
      })
    end
  end

  source.open do
    puts "SlackFire ready to accept messages!"
  end

  source.start

end
