class Widget < ActiveRecord::Base

	belongs_to :order

	# used to pass quantity in from form
	attr_accessor :quantity

	# validations
	VALID_TYPES = ["Widget", "Widget Pro", "Widget Xtreme"]
	VALID_COLORS = ["red", "yellow", "blue"]

	validates_inclusion_of :wigtype, :in => VALID_TYPES, :message => "widget type not available"
	validates_inclusion_of :color, :in => VALID_COLORS, :message => "color selected is available"
	validates :quantity, numericality: { only_integer: true }

	# sorts
	scope :sorted, lambda { order("wigtype ASC, color ASC") }

end
