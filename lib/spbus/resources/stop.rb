module SpBus
  class Stop < Hashie::Trash
    property :id,        :from => :CodigoParada
    property :name,      :from => :Nome
    property :address,   :from => :Endereco
    property :latitude,  :from => :Latitude
    property :longitude, :from => :Longitude
  end
end
