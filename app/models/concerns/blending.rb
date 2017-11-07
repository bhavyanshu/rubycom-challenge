module Blending
  extend ActiveSupport::Concern

  included do
    after_save :make_juice, :if => :is_apple?
  end

  # Check if parent caller is Apple
  def is_apple?
    get_parent === 'Apple'
  end

  # Get callback name
  def get_parent
    self.is_a?(Module) ? self.name : self.class.name
  end

  # Method to call on after_save
  def make_juice
    puts "Making some tasty apple juice!"
  end
end
