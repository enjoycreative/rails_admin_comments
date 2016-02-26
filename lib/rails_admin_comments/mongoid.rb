module RailsAdminComments
  module Mongoid
    extend ActiveSupport::Concern
    included do
      include ::Mongoid::Document
      include ::Mongoid::Timestamps::Short
      include ::Mongoid::Userstamp

      belongs_to :rails_admin_commentable, polymorphic: true

      store_in collection: "rails_admin_comments"

      field :enabled, type: ::Mongoid::VERSION.to_i < 4 ? Boolean : ::Mongoid::Boolean, default: true
      scope :enabled, -> { where(enabled: true) }

      scope :by_date, -> { order([:c_at, :asc]) }

      field :content
      validates_presence_of :content

      scope :for_user, ->(user) {}
    end
  end
end