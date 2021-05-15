# frozen_string_literal: true

require_relative '../main'

RSpec.describe Example do
  it 'Greeting a person' do
    expect { Example.new.greet('Ricardo') }.to output("Hello Ricardo\n").to_stdout
  end
end
