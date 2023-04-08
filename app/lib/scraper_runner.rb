class ScraperRunner
  attr_accessor :scraper_run

  def self.run
    new(ScraperRun.create).run
  end

  def initialize(scraper_run)
    @scraper_run = scraper_run
  end

  def run
    return if scraper_run.started_at.present?

    scraper_run.update_column(:started_at, Time.zone.now)

    scraper.scrape
    persister.create_or_update_flats
    notifier.notify

    scraper_run.update_column(:ended_at, Time.zone.now)
  rescue => error
    scraper_run.update_columns(
      errored_at: Time.zone.now,
      error_message: error.message,
      backtrace: error.backtrace.join("\n")
    )
  end

  private

  def scraper
    @scraper ||= InBerlinWohnenScraper.new
  end

  def persister
    @persister ||= PersistFlat.new(flats_data: scraper.flats_data)
  end

  def notifier
    @notifier ||= NotifyAboutNewFlats.new(flats: persister.flats)
  end
end
