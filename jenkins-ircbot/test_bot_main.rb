require 'jenkins_api'
require 'test_bot'

def talk_to_jenkins_result(bot, api, job_names)
  data = {}
  all_ok = true
  job_names.each do |job_name|
    data[job_name] = api.newest_job_result(job_name)
    if data[job_name]['result'] != "SUCCESS"
      bot.talk("#{data[job_name]['result'] == "SUCCESS" ? "OK" : "NG"} [#{data[job_name]['id']} #{job_name}]")
      bot.talk("　　 #{data[job_name]['url']}")
      all_ok = false
    end
  end
  bot.talk("whole daily test OK!") if all_ok
  all_ok
end

bot = TestBot.new("localhost", "6667",
                  :nick => "test_bot",
                  :user => "test_bot",
                  :real => "test_bot")
bot.target_channels << "#hoge"

bot.tasks << TestBot.make_task("09:05") do
  api = JenkinsAPI.new("http://localhost:8080")
  bot.talk("=== jenkins定期実行ジョブ結果のお知らせ ===")
  all_ok = talk_to_jenkins_result(bot, api, api.jobnames_at_view('IRCbotCheckTarget'))
  bot.talk("=== ここまで ===#{all_ok ? "" : " > ALL"}")
end

bot.start

