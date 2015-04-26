class Paper < ActiveRecord::Base
	has_attached_file :attachment

	validates_attachment_content_type :attachment, content_type: 'application/pdf'

  validates :title, :authors, :attachment, :user_id, presence: true

  validates_uniqueness_of :title, :scope => [:authors], message: " exists. This paper has already been added to your account."

	belongs_to :user
  
  before_save :perform_attachment_removal

	def perform_attachment_removal
		if :remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
		end
	end

end
