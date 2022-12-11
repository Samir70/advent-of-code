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
  context "#split_by_elements" do
    it "splits a list of numbers" do
      expect(split_by_element([1, 2, 0, 4, 6, 8, 0, 9], 0)).to eq [[1, 2], [4, 6, 8], [9]]
    end
    it "splits a list of strings" do
      expect(split_by_element(["", "1", "2", "", "1", "2", "3", "", "1", "2"], "")).to eq [["1", "2"], ["1", "2", "3"], ["1", "2"]]
    end
    it "splits a list of lists" do
      expect(split_by_element([[1, 2, 0], [101], [4, 6, 8], [0, 9]], [101])).to eq [[[1, 2, 0]], [[4, 6, 8], [0, 9]]]
    end
  end
end
