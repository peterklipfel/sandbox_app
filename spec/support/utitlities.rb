def full_title(page_title)
  base_title = "Sandbox App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def check_h1_title(h1, title)
  	it { should have_selector('h1', :text => h1)}
    it { should have_selector('title', :text => title)}
end