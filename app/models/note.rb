# == Schema Information
#
# Table name: notes
#
#  id                :integer          not null, primary key
#  lecture_title     :string(255)
#  lecture_date      :date
#  comments          :text
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  course_id         :integer
#

class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :comments, length: { maximum: 140 }
  validates :lecture_title, presence: true
  validates :lecture_date, presence: true


  has_attached_file :file,  default_url: "/images/:style/missing.png",
                            path:   ':rails_root/assets/:class/:id/:filename',
                            url:    '/notes/:id/:filename/'

  validates_attachment :file, presence: true,
  :content_type => { content_type: [ 'application/pdf', 
                                     'application/msword', 
                                     'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                     'image/png' ] },
  message: "Only PDFs and Word documents allowed"

end
