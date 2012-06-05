class Comment < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :comment_id, :content, :like, :msg_id, :time, :user_id
=======
  attr_accessible :comment_id, :content, :like, :msg_id, :time, :user_id, :user_name
>>>>>>> be36e74b3bef665d0c329161b7e82cde4d9f327b
  validates_uniqueness_of :comment_id
  serialize :like, Array
  belongs_to :msg
end
