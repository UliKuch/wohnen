require "rails_helper"

RSpec.describe ScraperRunner do
  describe "#run" do
    subject { described_class.new(scraper_run) }
    let!(:scraper_run) { FactoryBot.create(:scraper_run) }

    before do
      allow_any_instance_of(InBerlinWohnenScraper)
        .to receive(:scrape).and_return(nil)
      allow_any_instance_of(FlatsNotifier)
        .to receive(:notify_about_new_flats).and_return(nil)
    end

    context "when everything works fine" do
      it "does not raise error" do
        expect { subject.run }.not_to raise_error
      end

      it "updates columns correctly" do
        expect { subject.run }
          .to change { scraper_run.reload.started_at }
          .and change { scraper_run.reload.ended_at }
          .and change { scraper_run.reload.flats_found }
          .and change { scraper_run.reload.notifications_sent }
          .and keep { scraper_run.reload.errored_at }
          .and keep { scraper_run.reload.error_message }
          .and keep { scraper_run.reload.backtrace }
      end
    end

    context "when scraper run was already run" do
      let!(:scraper_run) { FactoryBot.create(:scraper_run, started_at: 1.second.ago) }

      it "does not raise error" do
        expect { subject.run }.not_to raise_error
      end

      it "updates columns correctly" do
        expect { subject.run }
          .to keep { scraper_run.reload.started_at }
          .and keep { scraper_run.reload.ended_at }
          .and keep { scraper_run.reload.flats_found }
          .and keep { scraper_run.reload.notifications_sent }
          .and keep { scraper_run.reload.errored_at }
          .and keep { scraper_run.reload.error_message }
          .and keep { scraper_run.reload.backtrace }
      end
    end

    context "with errors" do
      before do
        allow_any_instance_of(InBerlinWohnenScraper)
          .to receive(:scrape).and_raise(StandardError)
      end

      it "does not raise error" do
        expect { subject.run }.not_to raise_error
      end

      it "updates columns correctly" do
        expect { subject.run }
          .to change { scraper_run.reload.started_at }
          .and keep { scraper_run.reload.ended_at }
          .and keep { scraper_run.reload.flats_found }
          .and keep { scraper_run.reload.notifications_sent }
          .and change { scraper_run.reload.errored_at }
          .and change { scraper_run.reload.error_message }
          .and change { scraper_run.reload.backtrace }
      end
    end
  end
end
