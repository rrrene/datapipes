require 'spec_helper'

describe Datapipes::Composable do
  context 'with valid object' do
    let(:class_a) do
      Class.new do
        include Datapipes::Composable

        def body
          -> { one }
        end

        def one
          1
        end

        def exec
          bodies.map(&:call)
        end
      end
    end

    let(:class_b) do
      Class.new do
        include Datapipes::Composable

        def body
          -> { five }
        end

        def five
          5
        end
      end
    end

    let(:a) { class_a.new }
    let(:b) { class_b.new }
    subject { a + b }

    its(:bodies) { should have(2).items }

    it 'remember defined body' do
      expect(subject.exec).to eq [1, 5]
    end
  end
end
