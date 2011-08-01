class Array
  
  alias_method :to_csv_original, :to_csv if self.respond_to?(:to_csv)
  
  def extract_column_names_for_csv(serialized_hash, prefix = "")
    names = []
    self.first.serializable_hash.each do |key, value|
       if value.is_a?(Hash)
         names << extract_column_names_for_csv(value)
       elsif value.is_a?(Array)
         names << extract_column_names_for_csv(value.first)
       else
         name = key
         name = "#{prefix} #{key}" unless prefix.empty?
         names << humanize(key)
       end
     end
  end
  def extract_column_values_for_csv(serialized_hash)
    values = []
    self.first.serializable_hash.each do |key, value|
       if value.is_a?(Hash)
         names << extract_column_values_for_csv(value)
       elsif value.is_a?(Array)
         names << extract_column_values_for_csv(value.first)
       else
         names << humanize(value)
       end
     end
  end
  def to_csv(options = {})
    
    return '' if self.empty?
    
    return self.to_csv_original unless self.first.respond_to?(:serializable_hash)
    
    #if it's a hash, it's a sub-object. if it's an array, it's a repleating element
    #headers:
    output = FasterCSV.generate do |csv|
      csv << extract_column_names_for_csv(self.first.serializable_hash(options)) unless options[:headers] == false
      
      self.each do |item|
        extract_column_values_for_csv(item)
      end
      
    end
    
    output
  end
end