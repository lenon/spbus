module SpBus
  # @!attribute id
  #   @return [Integer]
  # @!attribute one_way
  #   @return [Boolean]
  # @!attribute number
  #   @return [String]
  # @!attribute direction
  #   @return [Integer]
  # @!attribute kind
  #   @return [Integer]
  # @!attribute destination_sign
  #   @return [String]
  # @!attribute origin_sign
  #   @return [String]
  # @!attribute info
  #   @return [String]
  class Line < Hashie::Trash
    property :id,               :from => :CodigoLinha
    property :one_way,          :from => :Circular
    property :number,           :from => :Letreiro
    property :direction,        :from => :Sentido
    property :kind,             :from => :Tipo
    property :destination_sign, :from => :DenominacaoTPTS
    property :origin_sign,      :from => :DenominacaoTSTP
    property :info,             :from => :Informacoes

    # Returns the "final sign" which indicates what is the direction
    # of the line.
    #
    # @return [String]
    def sign
      direction == 1 ? destination_sign : origin_sign
    end

    # Returns the trip_id in GTFS format.
    #
    # @return [String] like "6450-10-1"
    def trip_id
      "#{number}-#{kind}-#{direction - 1}"
    end
  end
end
