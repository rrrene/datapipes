require 'spec_helper'

$: << File.expand_path('../../examples', __FILE__)
require 'list'
require 'triple'
require 'print'

describe 'basic function' do
  before { $stdout = StringIO.new }
  after { $stdout = STDOUT }

  let(:datapipe) do
    Datapipes.new(
      List.new,
      Print.new,
      tube: Triple.new
    )
  end

  let(:out) do
    (4..6).map {|i| [i, i, i] }.join("\n") + "\n"
  end

  it 'runs without errors' do
    datapipe.run_resource
    expect($stdout.string).to eq out
  end
end
