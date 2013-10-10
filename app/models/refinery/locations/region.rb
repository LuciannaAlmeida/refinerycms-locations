require 'spreadsheet'
module Refinery
  module Locations
    class Region < Refinery::Core::BaseModel
		  self.table_name = 'refinery_regions'

      has_many :locations, :class_name => '::Refinery::Locations::Location'
      
      attr_accessible :name

      acts_as_indexed :fields => [:name]

      validates :name, :presence => true
      alias_attribute :title, :name

    end
  end
end