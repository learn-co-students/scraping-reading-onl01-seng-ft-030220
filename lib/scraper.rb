require_relative './spec_helper'
require_relative '../lib/scraper.rb'
require 'nokogiri'
require 'open-uri'

html = open("https://flatironschool.com/")
doc = Nokogiri::HTML(html)

doc.css(".inlineMobileLeft-2Yo002.imageTextBlockGrid3-2XAK6G")
describe "Scraper" do

  let(:scraper) {Scraper.new}

  describe "#get_page" do
    it "uses Nokogiri to get the HTML from a web page" do
      doc = scraper.get_page
      expect{scraper.get_page}.to_not raise_error
      expect(doc).to be_a(Nokogiri::HTML::Document)
    end
  end
  courses = doc.css("#2a778efd-1685-5ec6-9e5a-0843d6a88b7b .inlineMobileLeft-2Yo002.imageTextBlockGrid3-2XAK6G")

  courses.each do |course|
    puts course.text.strip
  end
  before(:each) do
    Course.reset_all
  end

  describe "#get_courses" do
    it "uses a CSS selector to return an array of Nokogiri XML elements representing the courses described on the web page we are scraping" do
      course_offerings = scraper.get_courses
      course_offerings.each do |course_offering|
        expect(course_offering).to be_a(Nokogiri::XML::Element)
        expect{course_offering.css("h2").text}.to_not raise_error
      end
    end
  end

  describe "#make_courses" do
    it "iterates over the courses array returned by #get_courses and creates a new Course instance out of each array element." do
      Course.reset_all
      courses = scraper.make_courses
      Course.all.each do |course|
        expect(course.title).to be_a String
        expect(course.schedule).to be_a String
        expect(course.description).to be_a String
      end
    end
  end

end
