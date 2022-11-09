require 'csv'

class Parser
  def initialize(filename:)
    @filename = filename
  end

  def parse
    all_rows = read_rows
    included_rows = filter_removed_rows(all_rows)
    return format_nested_hash(included_rows)
  end

  def format_nested_hash(included_rows)
    nested_hash = {}
    included_rows.each do |row|
      nested_hash[row[3]] ||= {}
      nested_hash[row[3]] [row[4]] ||= {}
      nested_hash[row[3]] [row[4]] [row[8]] = 
      {
        firmware_version: row[9],
        smets_chts_version: row[10],
        gbcs_version: row[11],
        image_hash: row[12]
      }
    end
    nested_hash
  end

  def filter_removed_rows(all_rows)
    all_rows.reject { |row| row[2] == 'Removed' }
  end

  def read_rows
    CSV.open(@filename) do |f|
      return f.read[1..-1]
    end
  end
end
