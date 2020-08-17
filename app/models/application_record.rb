class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def tax
    self * 1.1
    # 税率は１０％とする。
  end
end
