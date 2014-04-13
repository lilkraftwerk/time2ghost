class TextWorker
  include Sidekiq::Worker

  def perform
    puts "hi there"
  end
end