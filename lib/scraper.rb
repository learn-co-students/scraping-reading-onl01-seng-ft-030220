require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("https://flatironschool.com/our-courses/"))
p course = doc.css("#cd016a4c-d090-5b88-9be3-63e6d9187edf .text-4GLMvr")[0].attributes

# course.each do |courses|
#
#   puts courses.text.strip
# end
# ruby scraper.rb
