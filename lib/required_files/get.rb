module RequiredFiles::Get

  def self.from_txt( top_dir , filename = "required_files" )
    ::File.open( "#{ top_dir }/#{ filename }.txt" , "r:utf-8" ).read.split( /\n/ ).map { |f| "#{ top_dir }/#{ f }" }
  end
  
end