module RequiredFiles::Get

  def self.txt( required_files , top_dir , filename = "required_files" )
    _required_files = required_files.map { | str | str.gsub( "#{ top_dir }/" , "" ) + ".rb" }
    ::File.open( "#{ top_dir }/#{ filename }.#{ __method__ }" , "w:utf-8" ) do |f|
      f.print _required_files.join( "\n" )
    end
  end
  
end