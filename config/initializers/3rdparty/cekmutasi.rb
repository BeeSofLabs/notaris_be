module CekMutasiModule
    # Bank
    # CekMutasiModule::bank_list("08123456789")
    def self.bank_list(source_no)
        url = ENV["CEKMUTASI_API_URL"] + ENV["cekmutasi_api_ovo_bank_list_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => ENV["CEKMUTASI_API_KEY"], 'Accept' => "application/json" },
            body: {
                source_number: source_no
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    def self.bank_inquiry(source_no, bank_code, dest_number)
        url = ENV["CEKMUTASI_API_URL"] + ENV["cekmutasi_api_ovo_bank_inquiry_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => ENV["CEKMUTASI_API_KEY"], 'Accept' => "application/json" },
            body: {
                source_number: source_no,
                bank_code: bank_code,
                destination_number: dest_number
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    def self.bank_transfer(uuid, token, amount, note)
        url = ENV["CEKMUTASI_API_URL"] + ENV["cekmutasi_api_ovo_bank_send_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => ENV["CEKMUTASI_API_KEY"], 'Accept' => "application/json" },
            body: {
                uuid: uuid,
                token: token,
                amount: amount,
                note: note
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    # OVO
    def self.ovo_inquiry(source_no, phone)
        url = ENV["CEKMUTASI_API_URL"] + ENV["cekmutasi_api_ovo_inquiry_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => ENV["CEKMUTASI_API_KEY"], 'Accept' => "application/json" },
            body: {
                source_number: source_no,
                phone: phone
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    def self.ovo_transfer(soucer_no, phone, amount)
        url = ENV["CEKMUTASI_API_URL"] + ENV["cekmutasi_api_ovo_send_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => ENV["CEKMUTASI_API_KEY"], 'Accept' => "application/json" },
            body: {
                source_number: soucer_no,
                phone: phone,
                amount: amount
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end
end