module SpBus
  # @!attribute id
  #   @return [Integer]
  # @!attribute name
  #   @return [String]
  # @!attribute address
  #   @return [String]
  # @!attribute latitude
  #   @return [Float]
  # @!attribute longitude
  #   @return [Float]
  class Stop < Hashie::Trash
    property :id,        :from => :CodigoParada
    property :name,      :from => :Nome
    property :address,   :from => :Endereco
    property :latitude,  :from => :Latitude
    property :longitude, :from => :Longitude
  end
end
