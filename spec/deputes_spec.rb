require_relative '../lib/deputes'


describe "Depute Scrapping should scrap data from a website of the Assemblée Nationale" do
    it "should return a array with the names of deputés" do
      expect(depute_first_name).not_to be_nil
    end
  end

  describe "Depute Scrapping should scrap data from a website of the Assemblée Nationale" do 
    it "should return a part of url" do
    expect(index_url).to include("/deputes/fiche/OMC_PA719866")
        end 
    end 