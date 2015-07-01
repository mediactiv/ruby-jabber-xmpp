# encoding: UTF-8

require 'rubygems'
require 'xmpp4r'
require 'yaml'
require './config'

# debuging 
Jabber::debug = true

username = Config.from[:jid]
password = Config.from[:password]

jid = Jabber::JID.new(username)
client = Jabber::Client.new(jid)
client.connect
client.auth(password)

mainthread = Thread.current

# Initial presence

client.send(Jabber::Presence.new.set_status("XMPP4R at #{Time.now.utc}"))

# stops the current thread lets XMPP4R take over and handle callbacks
Thread.stop
client.close
