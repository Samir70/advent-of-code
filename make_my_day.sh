echo "making a file for solution Ruby code"
touch ./lib/2023day_$1.rb
file="./lib/2023day_$1.rb"
echo "class Solution$1" > $file
echo "  def initialize(file_name)" >> $file
echo "    @file_name = file_name" >> $file
echo "    @data = []" >> $file
echo "    process" >> $file
echo "  end" >> $file
echo "" >> $file
echo "  def run" >> $file
echo "  " >> $file
echo "  end" >> $file
echo "" >> $file
echo "  def run_2" >> $file
echo "  " >> $file
echo "  end" >> $file
echo "" >> $file
echo "  def process" >> $file
echo "    file = File.new(@file_name)" >> $file
echo "    @data = file.readlines.map(&:chomp)" >> $file
echo "    file.close" >> $file
echo "  end" >> $file
echo "end" >> $file

echo "Making a file for test_case"
touch ./lib/inputs/test_cases/2023day_$1_1.txt
echo "Making a file for the big test"
touch ./lib/inputs/big_tests/2023day_$1.txt

echo "Setting up a spec file for day $1"
touch ./spec/2023day_$1_spec.rb
file="./spec/2023day_$1_spec.rb"
echo "require '2023day_$1'" > $file
echo "" >> $file
echo "RSpec.describe Solution$1 do" >> $file
echo "  before(:each) do" >> $file
echo "    @test_case = './lib/inputs/test_cases/2023day_$1_1.txt'" >> $file
echo "    @big_test = './lib/inputs/big_tests/2023day_$1.txt'" >> $file
echo "  end" >> $file
echo "" >> $file
echo "  it 'solves example test case (part 1)' do" >> $file
echo "    sol = Solution$1.new(@test_case)" >> $file
echo "    expect(sol.run).to eq nil" >> $file
echo "  end" >> $file
echo "" >> $file
echo "  it 'solves example test case (part 2)' do" >> $file
echo "    sol = Solution$1.new(@test_case)" >> $file
echo "    expect(sol.run_2).to eq nil" >> $file
echo "  end" >> $file
echo "" >> $file
echo "  it 'solves big test (part 1)' do" >> $file
echo "    sol = Solution$1.new(@big_test)" >> $file
echo "    expect(sol.run).to eq nil" >> $file
echo "  end" >> $file
echo "" >> $file
echo "  it 'solves big test (part 2)' do" >> $file
echo "    sol = Solution$1.new(@big_test)" >> $file
echo "    expect(sol.run_2).to eq nil" >> $file
echo "  end" >> $file
echo "end" >> $file
