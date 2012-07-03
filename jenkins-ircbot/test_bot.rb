require 'time'
require "rubygems"
require "net/irc"

class TestBot < Net::IRC::Client
  attr_accessor :tasks
  attr_accessor :target_channels

  def initialize(*args)
    @tasks = []
    @target_channels = []
    super(*args)
  end

  def self.make_task(time, &block)
    lambda do
      loop do
        span = Time.parse(time) - Time.now
        if span <= 0 || span > 3700
          sleep 3600
        else
          sleep span
          block.call
        end
      end
    end
  end

  def start
    @tasks.each do |task|
      Thread.start do
        task.call
      end
    end
    super
  end

  def on_rpl_welcome(m)
    @target_channels.each do |channel|
      post(JOIN, channel)
    end
  end

  def on_privmsg(m)
#    talk("へー", [m[0]])
  end

  def talk(msg, channels = @target_channels)
    channels.each do |channel|
      post(PRIVMSG, channel, msg)
    end
  end
end

