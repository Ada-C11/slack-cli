require_relative 'test_helper.rb'

describe "self.list" do
  it "list all channels" do
    VCR.use_cassette("list_channels") do
      response = list

      expect(response).wont_be_nil
      expect(response[0]).must_equal "general"
      expect(response.length).must_equal 3
    end
  end 
end  
   
