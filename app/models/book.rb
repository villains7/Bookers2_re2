class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
    acts_as_taggable 

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content,method)
   if method == 'perfect'         #完全一致の場合の処理
     Book.where(title: content)
   elsif method == 'forward'      #前方一致の場合の処理
      Book.where('title LIKE ?', content+'%')
   elsif method == 'backward'    #後方一致の場合の処理
      Book.where('title LIKE ?', '%'+content)
   else
      Book.where('title LIKE ?', '%'+content+'%')#部分一致の処理
   end
  end
end
