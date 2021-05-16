# frozen_string_literal: true

require_relative '../lib/file_handler'

RSpec.describe 'File validations' do
  let(:file2) { FileValidations.new('resources/scores.txt', '.txt') }
  let(:wrong_extension) { FileValidations.new('spec/wrong_file.doc', '.txt') }
  let(:wrong_structure) { FileValidations.new('spec/structure.txt', '.txt') }

  it "Show error message when the file doesn't exist" do
    expect(file2.error).to eq('Check if file exists')
  end
  it 'Shows an error when extension is not txt' do
    expect(wrong_extension.error).to eq('Wrong file extension')
  end
  it 'Validates the correct file structure' do
    expect(wrong_structure.check_file).to be(false)
  end
end
