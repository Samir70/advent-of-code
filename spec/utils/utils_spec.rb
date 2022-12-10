require_relative "../../utils/utils"

RSpec.describe "Utils" do
    context "string_to_grid method" do
        it "groups string in 3s" do
            expect(string_to_grid("123123123123", 3)).to eq ["123", "123", "123", "123"]
            expect(string_to_grid("12312312312", 3)).to eq ["123", "123", "123", "12"]
            expect(string_to_grid("12345123451234512345", 5)).to eq ["12345", "12345", "12345", "12345"]
        end
        it "groups string in 5s" do
            expect(string_to_grid("12345123451234512345", 5)).to eq ["12345", "12345", "12345", "12345"]
        end
    end
end