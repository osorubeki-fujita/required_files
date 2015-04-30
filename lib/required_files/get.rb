module RequiredFiles::Get

  def self.from_txt( top_dir , filename = "required_files" )
    ::File.open( "#{ top_dir }/#{ filename }.txt" , "r:utf-8" ).read.split( /\n/ ).map { |f| "#{ top_dir }/#{ f }" }
  end

=begin
  def self.from_yaml( top_dir , filename = "required_files" )
    ::YAML.load_file( "#{ top_dir }/#{ filename }.yaml" ).map { | key , value |
      from_hash( key , value )
    }
  end
  
  class << self
  
    private
  
    def from_hash( key , value )
      ary = ::Array.new
      if value.instance_of?( ::Array ) or value.instance_of?( ::String )
        [ value ].flatten.each do | element |
          ary << "#{ key }/#{ element }"
        end
      elsif value.instance_of?( ::Hash )
        value.each do |k,v|
          ary << "#{ key }/#{ from_hash(k,v) }"
        end
      end
      ary
    end

  end 
=end

end