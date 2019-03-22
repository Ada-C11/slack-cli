describe "Workspace class" do
  
  describe "select method" do
    it "can return specified channel" do
      VCR.use_cassette("select-method") do
        test = Workspace.new
          expect(test.select_channel("api-project")).must_be_instance_of Channel
          expect(test.selected.name).must_equal "api-project"
      end
    end 
  end
  
  describe "select user method" do
    it "can return a given user" do
      VCR.use_cassette("select-user") do
        test1 = Workspace.new
          expect(test1.select_user("UH2SDTK2N")).must_be_instance_of User
          expect(test1.selected.name).must_equal "ksguadron"
       end
    end
  end
end