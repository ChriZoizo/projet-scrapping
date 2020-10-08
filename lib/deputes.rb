require 'nokogiri'
require 'open-uri'
require 'rubygems'

@deputes_index = Array.new
@deputes_name = Array.new
@results = Hash.new

def index_url 
    url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
   url_index = Nokogiri::HTML(URI.open(url))
   list = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each {|deputes| @deputes_index << deputes['href'] }
    @deputes_index
return list
end

def find_depute_mails(index_url)
    list_mails = Array.new
   @deputes_index.each do |deputes|
    depute_page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/#{deputes}"))
    depute_mail = depute_page.css('#haut-contenu-page > article > div.contenu-principal.en-direct-commission.clearfix > div > dl > dd:nth-child(8) > ul > li:nth-child(2) > a').text
    list_mails << depute_mail
end
return list_mails
end

def depute_first_name
    first_name = Array.new   
   url_index = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
   name = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |name|
    #hashfirstname = Hash.new
    firstname = name.text.gsub('M.', '').gsub('Mme', '').strip.split.first
   first_name << firstname

   end
   return first_name
end

def depute_last_name
    last_name = Array.new
    url = 
    url_index = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    name = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |name| 
        #hashlastname = Hash.new
        lastname = name.text.gsub('M.', '').gsub('Mme', '').strip.split(' ').drop(1).join(' ') 
        last_name << lastname
    end
    return last_name
end

def depute_scraper
    mail = find_depute_mails(index_url)
    firstname = depute_first_name
    secondname = depute_last_name

    array = []
    
    
    (0..firstname.length-1).each do |x|
      new_hash = {}
      new_hash["first_name"] = firstname[x] 
      new_hash["last_name"] = secondname[x] 
      new_hash["email"] = mail[x] 
      array << new_hash
  
      
      
    end 
  
    puts array
end


depute_scraper