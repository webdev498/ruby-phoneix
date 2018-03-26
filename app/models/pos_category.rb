class PosCategory < ActiveRecord::Base

  def self.getSelectEnum
    enum = []
    PosCategory.all.each do |category|
      enum << [category.category_description,category.id]
    end
    enum
  end
end
