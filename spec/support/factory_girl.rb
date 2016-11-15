#  RSpec test suite configuration for factory_girl
#
#  Using FactoryGirl::Syntax::Methods in the test suite,
#  avoids all factory_girl methods from prefaced with FactoryGirl

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
