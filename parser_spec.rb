require 'rspec'
require_relative 'parser'
require 'csv'

describe Parser do
  describe '#parse' do
    let(:input_data) do
      CSV.open('ProductList.csv') do |f|
        return f.read[3..3]
      end
    end

    it 'passes correctly' do
      expected = {
        'Communications Hub' => {
          '1086' => {
            '54322052' =>
            {
              firmware_version: '000A6900',
              smets_chts_version: 'CHTS V1.0 ',
              gbcs_version: 'GBCS Version 1.0 ',
              image_hash: nil
            }
          }
        }
      }

      parser = Parser.new(filename: 'file')
      included_rows = parser.filter_removed_rows(input_data)
      actual = parser.format_nested_hash(included_rows)
      expect(actual).to eql(expected)
    end
  end
end
