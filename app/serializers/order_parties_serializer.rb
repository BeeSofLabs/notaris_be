class OrderPartiesSerializer < ActiveModel::Serializer
    attributes 	:no_request_order,
                :document_type,
                :status,
                :doc_filename,
                :has_debtor_signed,
                :has_creditor_signed,
                :has_pa_signed,
                :debtor,
                :creditor,
                :collateral_owner

    def debtor
        ::UserPartiesSerializer.new(object.debtor)
    end

    def creditor
        ::UserPartiesSerializer.new(object.creditor)
    end

    def collateral_owner
        ::UserPartiesSerializer.new(object.collateral_owner)
    end
end