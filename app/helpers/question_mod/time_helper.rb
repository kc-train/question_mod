module QuestionMod
  module TimeHelper
    def human_time_show(time)
      t = Time.now - time
      "1 年前"
    end
  end
end
