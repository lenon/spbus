module SpBus
  class Bus < Hashie::Trash
    property :id,         :from => :p
    property :latitude,   :from => :py
    property :longitude,  :from => :px
    property :accessible, :from => :a
  end
end
