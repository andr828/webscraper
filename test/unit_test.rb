require "minitest/autorun"
require_relative "../class/web_scraper"

class UnitTest < Minitest::Test
  def setup
    @web_scraper= WebScraper.new
  end

  def test_first
    assert_equal(50, @web_scraper.get_data('web', 'remote', 5).length)
  end

  def test_second
    assert_equal(0, @web_scraper.get_data('web', 'brazil', 5).length)
  end
end
