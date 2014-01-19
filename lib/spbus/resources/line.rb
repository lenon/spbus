module SpBus
  class Line < Hashie::Trash
    property :id,               :from => :CodigoLinha
    property :one_way,          :from => :Circular
    property :number,           :from => :Letreiro
    property :direction,        :from => :Sentido
    property :kind,             :from => :Tipo
    property :destination_sign, :from => :DenominacaoTPTS
    property :origin_sign,      :from => :DenominacaoTSTP
    property :info,             :from => :Informacoes

    def sign
      direction == 1 ? destination_sign : origin_sign
    end

    def trip_id
      "#{number}-#{kind}-#{direction - 1}"
    end
  end
end
