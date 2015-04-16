class Paper < ActiveRecord::Base
	has_attached_file :attachment
	validates_attachment_content_type :attachment, content_type: 'application/pdf'
	belongs_to :user
	validates :title, :authors, :attachment, presence: true
  
  before_save :perform_attachment_removal

	def perform_attachment_removal
		if :remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
		end
	end

end
