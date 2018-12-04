require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

class WebScraper
  HOST_URL = 'https://www.indeed.co.uk'
  def initialize()
    @json_data = []
  end

  #extract job tags from web page
  def extract_jobs(page_content)
    page_content.css('.jobsearch-SerpJobCard').each do |job|
      job_title = job.css('.jobtitle').text   #get job title
      company = job.css('.company').text      #get company name
      snip = job.css('.snip')         
      wage = snip.css('.no-wrap').text        #get wage
      summary = job.css('.summary').text      #get summary
      detail_link = job['data-jk']            #get detail link

      @json_data.push(
        title: job_title,
        company: company,
        wage: wage,
        summary: summary,
        detail_link: detail_link
      )
    end
  end

  #save json object as .json file
  def save_json
    json = JSON.pretty_generate @json_data                          #parse
    File.open('data/jobs.json', 'w') { |file| file.write(json) }    #save as json file
  end

  #get data for all jobs from search term, location and pages count
  def get_data(search_term, location, pages_count)
    url = "#{HOST_URL}/jobs?q=#{search_term}&l=#{location}&start="
    pages_count.times.each do |i|
      start_num = i * 10
      url_temp = URI::encode(url + start_num.to_s)

      page_content = Nokogiri::HTML open url_temp
      extract_jobs page_content
      puts "#{i+1} page ----------------------------"
    end
    puts 'Done.'

    save_json # save the result to json file.
    @json_data
  end
end
