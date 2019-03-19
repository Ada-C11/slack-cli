require_relative 'test_helper'

describe "recipient class" do 
    describe "initialize" do 
        it "creates an instance of Recipient" do 
            expect(Recipient.new(slack_id, name)).must_be_kind_of Recipient
        end 
    end 
end