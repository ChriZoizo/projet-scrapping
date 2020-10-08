require 'nokogiri'
require 'open-uri'
require 'rubygems'



def crypto_scrapper

cryptoarray = Array.new
valuearray = Array.new
cryptocurrencies = []


#Page internet source
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
#Xpath : Chemin HTML
cryptosource = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
valuesource = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td/a')

# ajouts des noms des cryptos en tant que valeurs dans le array cryptoarray
cryptosource.each do |cryptosource|
    cryptoarray << cryptosource.text
end

# ajouts des valeurs des cryptos en tant que valeurs dans le array cryptovalue
valuesource.each do |valuesource|
    valuearray << valuesource.text.delete("$"",").to_f
end

#Fusion de deux array precedentes et ajouts dans une nouvelle array "crypto"
crypto = Hash[*cryptoarray.zip(valuearray).flatten]  

print crypto.each_slice(1).map(&:to_h)
end

#initialisation
crypto_scrapper