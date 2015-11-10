module QuestionMod
  class NotificationsController < QuestionMod::ApplicationController
    def index
      user = current_user
      @notifications = user.notifications.with_kind("question")
    end
  end
end
