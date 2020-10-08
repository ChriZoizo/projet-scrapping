require_relative '../lib/dark_trader'


describe "Crypto Scrap should scrap data from a website" do
    it "should return a hash with the name of crypto and the value" do
      expect(crypto_scrapper).not_to be_nil
    end
  end

#   describe "Crypto Scrap should scrap data from a website" do 
#     it "should return a value BTC.. else the program don't work. Long life for BTC" do
#     expect(crypto_scrapper).to include("BTC")
#         end 
#     end 