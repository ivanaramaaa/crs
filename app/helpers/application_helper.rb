module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def last_digits(number)    
    number.length <= 4 ? number : number.slice(-4..-1) 
  end

   def mask(number)
     "XXXX-XXXX-XXXX-#{last_digits(number)}"
   end
end
