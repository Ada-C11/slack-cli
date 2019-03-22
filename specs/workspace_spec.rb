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
  
  describe "see details method" do
    it "can find a given user" do
      VCR.use_cassette("select-user") do
        test = Workspace.new
          expect(test.show_user_details("UH2SDTK2N")).must_equal "username: ksguadron | real name: Karla Guadron | Slack id: UH2SDTK2N"
       end
    end
      it "is case insensitive" do
          VCR.use_cassette("errors") do
            test = Workspace.new
          expect(test.show_user_details("KsGUadrOn")).must_match test.show_user_details("ksguadron")
        end
      end
      it "tells the Program's user when the input does not match a user" do
        VCR.use_cassette("errors") do
          test = Workspace.new
        expect(test.show_user_details("fbjkdf")).must_equal "user not found"    
      end
    end
  end  
end