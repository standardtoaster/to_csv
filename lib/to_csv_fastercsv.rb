class Array
  
  alias_method :to_csv_original, :to_csv if self.respond_to?(:to_csv)
  
  def extract_column_names_for_csv(serialized_hash, prefix = "")
    names = []
    serialized_hash.each do |key, value|
      if value.is_a?(Hash)
        names += extract_column_names_for_csv(value, key.to_s)
      elsif value.is_a?(Array)
        names += extract_column_names_for_csv(value.first, key.to_s)
      else
        name = key
        name = "#{ActiveSupport::Inflector::singularize(prefix)} #{key}" unless prefix.empty?      
        names << ActiveSupport::Inflector::titleize(name)
      end
    end
    names
  end
  def extract_column_values_for_csv(serialized_hash)
    serialized_hash ||= {}
    values = []
    serialized_hash.each do |key, value|
      if value.is_a?(Hash)
        values << extract_column_values_for_csv(value)
      elsif value.is_a?(Array)
        values << extract_column_values_for_csv(value.first)
      else
        values << value
      end
    end
    values
  end
  
  def to_csv(options = {})
    
    return '' if self.empty?
    
    return self.to_csv_original unless self.first.respond_to?(:serializable_hash)
    
    #headers:
    output = FasterCSV.generate do |csv|
    
      csv << extract_column_names_for_csv(self.first.serializable_hash(options)) unless options[:headers] == false
    
      self.each do |item|
        csv << extract_column_values_for_csv(item.serializable_hash(options))
      end
    
    end
    
    output
  end
end