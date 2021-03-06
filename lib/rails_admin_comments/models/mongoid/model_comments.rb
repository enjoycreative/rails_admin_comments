module RailsAdminComments
  module ModelComments
    module Mongoid
      extend ActiveSupport::Concern
      included do
        include ::Mongoid::Document
        include ::Mongoid::Timestamps::Short
        include ::Mongoid::Userstamp

        field :model_name, type: String

        store_in collection: "rails_admin_model_comments"

        field :enabled, type: ::Mongoid::VERSION.to_i < 4 ? Boolean : ::Mongoid::Boolean, default: true
        scope :enabled, -> { where(enabled: true) }

        scope :by_date, -> { order([:c_at, :asc]) }

        field :content
        validates_presence_of :content

        has_and_belongs_to_many :visible_for_users, class_name: "User", inverse_of: nil
        scope :for_user, ->(user) {
          any_of({visible_for_user_ids: user}, {visible_for_user_ids: nil}, {visible_for_user_ids: []})
        }
      end
    end
  end
end
