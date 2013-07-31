class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable
  field :name
  field :role

  ROLES = %w[client provider admin]
  
  def admin?
    role == 'admin'
  end
  
  def client?
    role == 'client'
  end
  
  def provider?
    role == 'provider'
  end
end
