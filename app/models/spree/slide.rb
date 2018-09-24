module Spree
  class Slide < Spree::Base

    has_and_belongs_to_many :slide_locations,
                            class_name: 'Spree::SlideLocation',
                            join_table: 'spree_slide_slide_locations'

    attr_accessor :attachment

    has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::SlideImage'
    validates_associated :image

    scope :published, -> { where(published: true).order('position ASC') }
    scope :location, -> (location) { joins(:slide_locations).where('spree_slide_locations.name = ?', location) }

    belongs_to :product, touch: true

    def initialize(attrs = nil)
      attrs ||= { published: true }
      super
    end

    def slide_name
      name.blank? && product.present? ? product.name : name
    end

    def slide_link
      link_url.blank? && product.present? ? product : link_url
    end

    def slide_image
      !image.present? && product.present? && product.images.any? ? product.images.first.attachment : image
    end
  end
end
