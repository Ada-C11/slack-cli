require_relative "test_helper"

describe "Workspace class" do
  describe "Workspace#initialize" do
    it "initializes a Workspace object" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        expect(response).must_be_instance_of Workspace
      end
    end
  end

  describe "select_user" do
    it "selects a known user by username" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_user("ngocle")
        expect(response.selected.username).must_equal "ngocle"
      end
    end

    it "selects a known user by slack id" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_user("UH553UM7G")
        expect(response.selected.username).must_equal "ngocle"
      end
    end

    it "raises an Argument if user info is invalid" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        expect { response.select_user("tildee") }.must_raise ArgumentError
      end
    end
  end

  describe "select_channel" do
    it "selects a known channel" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_channel("general")
        expect(response.selected.channel_name).must_equal "general"
      end
    end

    it "selects a known channel by slack id" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_channel("CH41W659D")
        expect(response.selected.channel_name).must_equal "general"
      end
    end

    it "raises an Argument if channel info is invalid" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        expect { response.select_channel("starburst") }.must_raise ArgumentError
      end
    end
  end

  describe "show_details" do
    it "shows details of the selected channel" do
      VCR.use_cassette("Workspace") do
        response = Workspace.new
        response.select_channel("general")
        expect(response.show_details).must_be_instance_of TablePrint::Returnable
      end
    end
  end
end
