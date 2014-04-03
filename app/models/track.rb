class Track < ActiveRecord::Base

  has_and_belongs_to_many :feeds
  has_many :shared_datas

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  before_validation :generate_identifier

  private
  def generate_identifier
    if self.identifier
      return
    end
    identifier = SecureRandom.urlsafe_base64(20)
    while Track.find_by_identifier(identifier) != nil
      identifier = SecureRandom.urlsafe_base64(20)
    end
    self.identifier = identifier
  end
end
