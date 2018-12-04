require_relative 'class/web_scraper'

desc 'Get jobs from Indeed.com'
task :get_jobs, [:search_term] do |task, args|
  pages_count = 5
  location = 'london'
  scrapper = WebScraper.new
  search_term = args.search_term
  scrapper.get_data(search_term, location, pages_count)
end
