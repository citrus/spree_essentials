require 'test_helper'

class DatetimeValidatorTest < ActiveSupport::TestCase

  class ModelWithDate
    include ActiveModel::Validations
    attr_accessor :timestamp
    validates :timestamp, :datetime => true
  end

  setup do
    @record = ModelWithDate.new
  end

  [ "1/1/2012", "1/1/12", "1-1-12", "12-1-1", "Jan 1, 2012", "January 1 2012" ].each do |date|
    should "validate #{date} as valid" do
      @record.timestamp = date
      assert @record.valid?
    end
  end
  
  [ "1", "dec 1" "11 111 11", "2012-1",  "99/99",  "tomorrow", "NOW" ].each do |date|
    should "validate #{date} as invalid" do
      @record.timestamp = date
      assert_equal false, @record.valid?
    end
  end
    
end
