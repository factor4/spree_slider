module Spree
  module Admin
    class SlidesController < ResourceController
      respond_to :html

      def index
        @slides = Spree::Slide.order(:position)
      end

      create.before :build_image
      def build_image
        @object.build_image(attachment: slide_params[:attachment]) if slide_params[:attachment]
      end

      update.before :create_image
      def create_image
        if slide_params[:attachment]
          if @object.image.present?
            @object.image.attachment = slide_params[:attachment]
            @object.image.save
          else
            @object.create_image(attachment: slide_params[:attachment])
          end
        end
      end

      private

      def location_after_save
        if @slide.created_at == @slide.updated_at
          edit_admin_slide_url(@slide)
        else
          admin_slides_url
        end
      end

      def slide_params
        params.require(:slide).permit(:name, :body, :link_url, :published, :position, :product_id, :attachment)
      end
    end
  end
end
