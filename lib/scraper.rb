require 'nokogiri'
require 'open-uri'
require 'pry'

html = open("https://flatironschool.com/")
doc = Nokogiri::HTML(html)

courses = doc.css(".gridContainer-EnvccM .inlineMobileLeft-2Yo002")

courses.pop()


courses.each {|course|
  puts course.css(".title-oE5vT4").text.strip
}

