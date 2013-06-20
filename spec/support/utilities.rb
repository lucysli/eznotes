include ApplicationHelper

RSpec::Matchers.define :have_header do |header|
	match do |page|
		page.should have_selector('h1', text: header)
	end
end

RSpec::Matchers.define :have_title do |title|
	match do |page|
		page.should have_selector('title', text: title)
	end
end