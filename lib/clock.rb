require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.minute, "Checking for texts to send #{Time.now} test") { TwilioMessage.send_all_texts_for_now}