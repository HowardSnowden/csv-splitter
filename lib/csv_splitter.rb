require 'csv'
require 'zaru'
class CsvSplitter
  def initialize(csv, out_path: '/tmp', column_to_split_by:, transform_headers: nil, suppress_logging: false)
    @transform_header = transform_headers
    @file = File.read(csv).encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '')
    @out_path = out_path
    @column_to_split_by = column_to_split_by
  end 

  def split! 
    last_file = ''
    csv_file =  CSV.parse(@file, {row_sep: :auto, header_converters: :symbol, headers: :true})   
    normalized_key = @column_to_split_by.gsub(' ', '_').downcase.to_sym
    sorting_index = csv_file.headers.index(normalized_key)
    csv_file.sort_by{|v| v[sorting_index] }.each do |row|
      current = Zaru.sanitize!(row[normalized_key].to_s.gsub(/_/, ' ').strip)
      new_file = "#{@out_path}/#{current}_new.csv"
      if last_file != new_file  
        write_mode = 'w'
        last_file = new_file
      else 
        write_mode = 'a'
      end
      transform_block = Proc.new{|v| v.to_s } 
      CSV.open(new_file, write_mode, write_headers: write_mode == 'w', headers: row.headers.map(&transform_block)) do |csv|
        csv << row.to_h.values
      end
      puts "wrote to file for column #{current}" unless suppress_logging
    end
  end
end
