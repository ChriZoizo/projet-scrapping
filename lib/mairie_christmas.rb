require 'open-uri'
require 'nokogiri'


@citys_list = Array.new
@citys_mail = Array.new

#Ici on recupere la liste des villes a partir de la page de la region et on incorpore dans une array
def get_city_list
    url = 
    page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
    citys = page.css('a.lientxt[href]').each {|city| @citys_list << city.text.downcase.gsub(' ', '-')}
end

# ici on recupere leurs emails et ont incorpore dans une array
def get_townhall_email
    @citys_list.each do |city|
    city_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/#{city}.html"))
    email = city_page.css('td')[7].text
    @citys_mail << email
    end
end
# ici on fuisione les deux array
def array_fusion
    results = Hash[*@citys_list.zip(@citys_mail).flatten]
    print results.each_slice(1).map(&:to_h)
    
end

def perform
    get_city_list
    get_townhall_email
    array_fusion
end

perform
