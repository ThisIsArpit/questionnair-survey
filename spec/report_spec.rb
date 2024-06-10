require 'rspec'
require 'pstore'
require 'active_support/all'
require_relative '../report'

RSpec.describe Report do
  let(:store) { PStore.new("test_store.pstore") }
  let(:questions) { { q1: "Is this a test question?" } }
  let(:report) { Report.new(store, questions) }

  before do
    # Delete all store data before each test
    store.transaction { store.roots.each { |key| store.delete(key) } }
  end

  describe '#do_prompt' do
    before do
      allow(report).to receive(:gets).and_return(*inputs)
      allow(report).to receive(:puts)
      allow(report).to receive(:print)
    end

    context 'when the user provides valid yes and no answers' do
      let(:inputs) { ['yes'] }
      it 'records the answers correctly in the store' do
        report.do_prompt

        store.transaction do
          expect(store[:yes_count]).to eq(1)
          expect(store[:no_count]).to eq(0)
          expect(store[:number_of_questions]).to eq(1)
          expect(store[:answers][:q1][:answer]).to eq('yes')
        end
      end
    end

    context 'when the user provides invalid answers' do
      let(:inputs) { ['maybe', 'yes'] }
      it 'prompts the user again until a valid answer is given' do
        report.do_prompt

        store.transaction do
          expect(store[:yes_count]).to eq(1)
          expect(store[:no_count]).to eq(0)
          expect(store[:number_of_questions]).to eq(1)
          expect(store[:answers][:q1][:answer]).to eq('yes')
        end
      end
    end
  end
end
