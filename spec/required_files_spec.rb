require 'spec_helper'
require 'deplo'

spec_filename = ::File.expand_path( ::File.dirname( __FILE__ ) )

describe RequiredFiles do
  it "has a version number \'#{ version }\'" do
    expect( ::Deplo.version_check( ::RequiredFiles::VERSION , spec_filename ) ).to eq( true )
  end
end
