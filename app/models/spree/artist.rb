class Spree::Artist < ActiveRecord::Base
  has_many :causes
  accepts_nested_attributes_for :causes
  attr_accessible :address, :age, :email, :last_name, :link_facebook, :link_twitter, :name, :place, :telephone, :type_art, :webpage, :photo, :reason, :portfolio

  #validations
  validates :name, :presence=>true
  validates_attachment_presence :photo
  #validates_attachment_content_type :photo,
  #  :content_type => ['image/jpg', 'image/png', 'image/jpeg'],
  #  :message => "must be jpg, png, jpeg"

  #Configurations Paperclip
  has_attached_file :photo,
    :styles => {:small=>"100x100>", :product=>"240x240>"},
    :storage => Rails.env == 'production' ? 's3' : 'filesystem',
    :s3_credentials => {
    :access_key_id => Spree::Config[:s3_access_key],
    :secret_access_key => Spree::Config[:s3_secret]
    },
    :bucket => Spree::Config[:s3_bucket],
    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

end