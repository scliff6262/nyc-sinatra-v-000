class FigureTitle < ActiveRecord::Base
  has_many :landmarks
  belongs_to :figure
  belongs_to :title
end
