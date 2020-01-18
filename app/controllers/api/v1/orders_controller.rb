class Api::V1::OrdersController < ApplicationController
  # before_action :find_notary, only: [:create]

  DOCTYPE_SKMHT = "skmht"
  DOCTYPE_APHT = "apht"
  DOCTYPE_FIDUSIA = "fidusia"

  def index
    orders = current_user.get_orders({ search_type: 'list' })

    if params[:request_type].eql?('csv')
      send_data Order.to_csv(orders), filename: "orders-#{Date.today}.csv"
    else
      json_response_with_serializer(orders, { adapter: :json, root: "order" })
    end
    # json_response({ orders: {
    #   notary_orders: current_user.notary_orders,
    #   debtor_orders: current_user.debtor_orders,
    #   collateral_owner_orders: current_user.collateral_owner_orders,
    #   creditor_orders: current_user.creditor_orders
    # }}, :unprocessable_entity)
  end

  def show
    order = Order.find params[:order_id]
    if order
      json_response({message: "order found!", order: OrderSerializer.new(order)}, :ok)
    else
      json_response({message: "Invalid order", order: {}}, :not_found)
    end
  end

  def create
    if [DOCTYPE_SKMHT, DOCTYPE_APHT, DOCTYPE_FIDUSIA].include?(order_params[:document_type])
        op = order_params[:status].present? ? order_params : order_params.merge({status: :draft})

        if order_params[:document_type] != DOCTYPE_FIDUSIA
          order = Order.create_order_with_immovable_collateral(current_user, op, params[:order_id], params[:immovable_collateral_ids])
        else
          order = Order.create_order_with_movable_collateral(current_user, op, params[:order_id], params[:movable_collateral_ids])
        end

        #  checking order valid or not
        if order.present?
          order.delay(run_at: 24.hours.from_now).check_status('submission')
          json_response({message: "order created!", order: order}, :created)
        else
          json_response({message: "Invalid service", order: {}}, :unprocessable_entity)
        end
    else
        json_response({message: "invalid document type", order: {}}, :not_found)
    end
  end

  # def update
  #   if update_order_params
  #     order = Order.find params[:order_id]
  #     if order.present?

  #       order.update(update_order_params)
  #       json_response({message: "order updated!", order: order}, :ok)

  #     else
  #       json_response({message: "Invalid order", order: {}}, :not_found)
  #     end
  #   else
  #     json_response({message: "Invalid order", order: {}}, :invalid)
  #   end
  # end

  def done
    order = Order.find params[:order_id]
    if order.present?

      order.update(status: :done)
      Notification.build("notif_done", order.debtor_id, "Dokument anda telah selesai")
      Notification.build("notif_done", order.creditor_id, "Dokument anda telah selesai")
      Notification.build("notif_done", order.notary_id, "Dokument anda telah selesai")
      json_response({message: "Document order done!", order: order}, :ok)

    else
      json_response({message: "Invalid order", order: {}}, :not_found)
    end
  end

  def complete
    order = Order.find params[:order_id]
    if order.present?

      order.update(status: :completed)
      Notification.build("notif_completed", order.notary_id, "Pembayaran jasa dokumen telah dibayarkan")
      json_response({message: "order complete!", order: order}, :ok)

    else
      json_response({message: "Invalid order", order: {}}, :not_found)
    end
  end

  def destroy
    order = Order.find params[:order_id]
    if order.present?

      order.update(is_deleted: true, status: :deleted)
      json_response({message: "order deleted!", order: order}, :ok)

    else
      json_response({message: "Invalid order", order: {}}, :not_found)
    end
  end

  private

  def update_order_params
    params.permit(
      :status,
      :no_perjanjian,
      :plafond,
      :tgl_akad,
      :tgl_jatuh_tempo,
      :tarif_bunga,
      :jangka_waktu,
      :agunan_pokok,
      :angsuran_bunga,
      :html_content,
      :has_debtor_signed,
      :has_creditor_signed,
      :has_pa_signed
    )
  end

	def order_params
		params.permit(
      :agunan_pokok,
      :angsuran_bunga,
      :total_price,
      :jangka_waktu,
      :no_perjanjian,
      :plafond,
      :tgl_akad,
      :tgl_jatuh_tempo,
      :tarif_bunga,
      :valid_expired_datetime,
      :document_type,
      :no_request_order,
      :notary_id,
      :user_id,
      :collateral_owner_id,
      :debtor_id,
      :creditor_id,
      :status
		)
	end

end
