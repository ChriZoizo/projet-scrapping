require_relative '../lib/mairie_christmas'


describe "Mairie Scrap should scrap data from a website of departement" do
    it "should return a hash with multiples city's" do
      expect(search_email(get_city_list)).not_to be_nil
    end
  end
  
  describe "Mairie Scrap should scrap data from a website of departement" do 
    it "should return a value Ableiges.. it's a city in Val d'oise in France" do
    expect(get_city_list).to include("ableiges")
        end 
    end 