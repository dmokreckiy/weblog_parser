# frozen_string_literal: true

RSpec.describe PragmaticParser do
  describe '#call' do
    context 'when web log file is valid' do
      subject { described_class.new('spec/fixtures/example.log') }
      let(:valid_message) do
        <<~MESSAGE
          Most page views
          /home 1 page views
          /help_page/1 1 page views
          /contact 1 page views
          /about/2 1 page views
          Most unique views
          /home 1 unique page views
          /help_page/1 1 unique page views
          /contact 1 unique page views
          /about/2 1 unique page views
        MESSAGE
      end

      it 'prints message with parser name' do
        expect { subject.call }.to output(valid_message).to_stdout
      end
    end
  end
end
