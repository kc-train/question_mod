module QuestionMod
  class Engine < ::Rails::Engine
    isolate_namespace QuestionMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end