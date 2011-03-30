class DatetimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)    
    date = DateTime.parse(value.to_s) rescue ArgumentError
    record.errors.add(attribute, I18n.t(:invalid_date_time, :scope => [:activerecord, :errors, :messages])) if date == ArgumentError
  end
end