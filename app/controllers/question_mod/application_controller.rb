module QuestionMod
  class ApplicationController < ActionController::Base
    layout "question_mod/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
      include PlayAuth::SessionsHelper
    end
  end
end
