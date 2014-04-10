require 'cinch'

catz = File.readlines("catz.emoticons").map{|cat| cat.strip}

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

  on :private, /are you a bot/ do |m|
    m.reply "no #{m.user.nick}, im a kitten :3"
  end
end

bot.start
