require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'rest_client'

@deputes_index = Array.new
@deputes_name = Array.new
@results = Hash.new

#Ici on recupere les "ID" des deputés. ou plutot la prtie de l'URL qui permet d'acceder a chacun d'entree eux, et on les enregistre dans un array. Le tout, grace a un Xpath
def index
    url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
    html = RestClient.get(url)    
    url_index = Nokogiri::HTML(html)
    list = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each {|deputes| @deputes_index << deputes['href'] }
end

#ici on parcours les pages des deputés en inserant leurs "ID" dans l'url de base, et on recupere leur email grace au selecteur CSS
def find_depute_mails(index)
    list_mails = Array.new
   @deputes_index.each do |deputes|
    depute_page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/#{deputes}"))
    depute_mail = depute_page.css('#haut-contenu-page > article > div.contenu-principal.en-direct-commission.clearfix > div > dl > dd:nth-child(8) > ul > li:nth-child(2) > a').text
    list_mails << depute_mail
end
return list_mails
end

#ici, on recupere leurs noms et prenoms, mais nous enlevons les "M." et "Mme", et recuperons que le prenoms
def depute_first_name
    first_name = Array.new
    url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
    html = RestClient.get(url)    
    url_index = Nokogiri::HTML(html)
    name = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |name|
    #hashfirstname = Hash.new
    firstname = name.text.gsub('M.', '').gsub('Mme', '').strip.split.first
    first_name << firstname

   end
   return first_name
end
#on refait la manip au dessus, mais on recupere que le nom de famille
def depute_last_name
    last_name = Array.new
    url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
    html = RestClient.get(url)    
    url_index = Nokogiri::HTML(html)
    name = url_index.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |name| 
        #hashlastname = Hash.new
        lastname = name.text.gsub('M.', '').gsub('Mme', '').strip.split(' ').drop(1).join(' ') 
        last_name << lastname
    end
    return last_name
end
#ici on met en place le tout dans des hash que l'on incorpore dans une array principale
def depute_scraper
    mail = find_depute_mails(index)
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
