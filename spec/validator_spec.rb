# frozen_string_literal: true

RSpec.describe Validator do
  describe 'validations' do
    subject { Validator.new }

    context 'when web log file is valid' do
      before do
        stub_const('ARGV', ['spec/fixtures/example.log'])
      end

      it 'silently passes' do
        expect { subject.call }.not_to raise_exception(SystemExit)
      end
    end

    context 'when web log file is invalid' do
      context 'when ARGV is empty' do
        before do
          stub_const('ARGV', [])
        end

        it 'fails with exit' do
          expect { subject.call }.to raise_exception(SystemExit)
        end
      end

      context 'when ARGV constains several files' do
        before do
          stub_const('ARGV', ['spec/fixtures/example.log', 'spec/fixtures/example.log'])
        end

        it 'fails with exit' do
          expect { subject.call }.to raise_exception(SystemExit)
        end
      end

      context 'when web log file does not exist' do
        before do
          stub_const('ARGV', ['spec/fixtures/do_not_exist.log'])
        end

        it 'fails with exit' do
          expect { subject.call }.to raise_exception(SystemExit)
        end
      end
    end
  end
end
