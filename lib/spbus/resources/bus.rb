module SpBus
  # @!attribute id
  #   @return [Integer]
  # @!attribute latitude
  #   @return [Float]
  # @!attribute longitude
  #   @return [Float]
  # @!attribute accessible
  #   @return [Boolean]
  class Bus < Hashie::Trash
    property :id,         :from => :p
    property :latitude,   :from => :py
    property :longitude,  :from => :px
    property :accessible, :from => :a
  end
end
