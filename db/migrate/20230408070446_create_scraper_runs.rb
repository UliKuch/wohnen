class CreateScraperRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :scraper_runs do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :errored_at
      t.integer :flats_found
      t.integer :notifications_sent
      t.text :backtrace
      t.text :error_message
      t.timestamps
    end
  end
end
