# encoding: UTF-8

require 'rubygems'
require 'xmpp4r'
require 'yaml'


# debuging 
Jabber::debug = true

begin
  config = YAML.load_file('config.yml')
rescue Exception => e
  puts 'Error reading config.yml,please sure to create that file'
  puts 'According to the example in config.example.yml'
  p e
end


username = config['from']['jid']
password = config['from']['password']

jid = Jabber::JID.new(username)
client = Jabber::Client.new(jid)
client.connect
client.auth(password)

mainthread = Thread.current

# Initial presence

client.send(Jabber::Presence.new.set_status("XMPP4R at #{Time.now.utc}"))

msg = Jabber::Message.new(config['to']['jid'],'Hello world!')
msg.type = :chat
client.send(msg)
# stops the current thread lets XMPP4R take over and handle callbacks
Thread.stop
client.close
