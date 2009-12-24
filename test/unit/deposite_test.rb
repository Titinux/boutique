require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  test "duplicated deposits shouldn't be saved" do
    Deposit.delete_all
    
    d1 = Deposit.new(:user_id => users(:Toto).id, :asset_id => assets(:Iron).id, :validated => false, :quantity_modifier => 25)
    assert d1.save
                    
    d2 = Deposit.new(:user_id => users(:Toto).id, :asset_id => assets(:Iron).id, :validated => false, :quantity_modifier => 25)   
    assert !d2.save
  end
end
