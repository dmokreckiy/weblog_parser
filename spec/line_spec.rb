# frozen_string_literal: true

RSpec.describe Line do
  describe '#valid?' do
    context 'when log line is valid' do
      let(:valid_line) { Line.new('/about 127.0.0.1') }

      it 'passes' do
        expect(valid_line).to be_valid
      end
    end

    # would have used shared_examples but skipping for now
    context 'when log line is invalid' do
      context 'when / is missing at line\'s start' do
        let(:invalid_line) { Line.new('about .') }

        it 'fails' do
          expect(invalid_line).not_to be_valid
        end

        it 'prints a bad log line message' do
          expect { invalid_line.valid? }.
            to output("Invalid log entrie - \"about .\"\n").to_stdout
        end
      end

      context 'when line is empty' do
        let(:invalid_line) { Line.new('') }

        it 'fails' do
          expect(invalid_line).not_to be_valid
        end

        it 'prints a bad log line message' do
          expect { invalid_line.valid? }.
            to output("Invalid log entrie - \"\"\n").to_stdout
        end
      end

      context 'when line is a whitespace' do
        let(:invalid_line) { Line.new('   ') }

        it 'fails' do
          expect(invalid_line).not_to be_valid
        end

        it 'prints a bad log line message' do
          expect { invalid_line.valid? }.
            to output("Invalid log entrie - \"   \"\n").to_stdout
        end
      end

      context 'when visitor IP is missing' do
        let(:invalid_line) { Line.new('/about ') }

        it 'fails' do
          expect(invalid_line).not_to be_valid
        end

        it 'prints a bad log line message' do
          expect { invalid_line.valid? }.
            to output("Invalid log entrie - \"/about \"\n").to_stdout
        end
      end
    end
  end
end
