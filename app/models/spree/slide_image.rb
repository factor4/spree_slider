module Spree
  class SlideImage < Asset
    include Rails.application.config.use_paperclip ? Configuration::Paperclip : Configuration::ActiveStorage
    include Rails.application.routes.url_helpers
  end
end
