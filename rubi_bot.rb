require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

catz = File.readlines("catz.emoticons").map{|cat| cat.strip}

$machines = {}

bot = Cinch::Bot.new do
  configure do |c|
    c.nick      = ENV["RUBI_NICK"]
    c.user      = ENV["RUBI_USER"]
    c.real_name = ENV["RUBI_NAME"]
    c.server    = ENV["RUBI_SERVER"]
    c.port = 6697
    c.ssl.use = true
    c.sasl.username = ENV["RUBI_SASLUSER"]
    c.sasl.password = ENV["RUBI_PASSWORD"]
    c.channels     = [ENV["RUBI_CHANNEL"]]
  end

  # m.channel? channel.xxx or private
  # on :catchall do |m|
  #  debug m.inspect
  # end

  # TODO make these as plugins
  on :message, /meow/ do |m|
    m.reply catz.sample
  end

  on :channel, /ruby/ do |m|
    m.reply "#{m.user.nick}: do you rabu #{File.read("love.txt").strip} in #{m.channel.name}"
  end

  # Adventure game section ###############

  on :channel, /(stop|quit)/ do |m|
    $machine = nil
    m.reply "All reality has been destroyed as you know it"
  end

  on :channel do |m|
    if $machine
      machine = $machine
      machine.keyboard << m.message + "\n"
      machine.run
      m.reply machine.output[3..-4].map{|ztext| ztext.to_s.to_s.gsub("\n","")}.select{|line| line != ""}.join(", ")
      machine.output.clear
    end
  end

  on :channel, /play zork/ do |m|
    machine = $machine = Z::Machine.new("zork1.z3")
    machine.run
    m.reply machine.output[3..-4].map{|ztext| ztext.to_s.to_s.gsub("\n","")}.select{|line| line != ""}.join(", ")
    machine.output.clear
  end

  on :channel, /play fluffy/ do |m|
    machine = $machine = Z::Machine.new("fluffy.z5")
    machine.run
    m.reply machine.output[3..-4].map{|ztext| ztext.to_s.to_s.gsub("\n","")}.select{|line| line != ""}.join(", ")
    machine.output.clear
  end

  on :private, /are you a bot/ do |m|
    m.reply "no #{m.user.nick}, im a kitten :3"
  end
end

bot.start
