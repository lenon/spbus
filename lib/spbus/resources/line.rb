module SpBus
  class Line < Hashie::Trash
    property :id,                    :from => :CodigoLinha
    property :one_way,               :from => :Circular
    property :number,                :from => :Letreiro
    property :direction,             :from => :Sentido
    property :kind,                  :from => :Tipo
    property :sign_for_start_to_end, :from => :DenominacaoTPTS
    property :sign_for_end_to_start, :from => :DenominacaoTSTP
    property :info,                  :from => :Informacoes
  end
end
