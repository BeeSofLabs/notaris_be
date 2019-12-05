class OrderPartiesSerializer < ActiveModel::Serializer
    attributes 	:no_request_order,
                :document_type,
                :status,
                :doc_filename,
                :has_debtor_signed,
                :has_creditor_signed,
                :has_pa_signed
end