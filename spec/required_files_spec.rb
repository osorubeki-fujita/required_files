require 'spec_helper'
require 'deployer'

spec_filename = ::File.expand_path( ::File.dirname( __FILE__ ) )
version = "0.2.3"

describe RequiredFiles do
  it "has a version number \'#{ version }\'" do
    expect( RequiredFiles::VERSION ).to eq( version )
    expect( ::Deployer.version_check( RequiredFiles::VERSION , spec_filename ) ).to eq( true )
  end
end
