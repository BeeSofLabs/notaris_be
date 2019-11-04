module CekMutasiModule
    # Bank
    def self.bank_list(source_no)
        url = ENV["cekmutasi_api_baseurl"]+ ENV["cekmutasi_api_ovo_bank_list_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => '71dfde726d0c5f7fa7b0c5a74c60fa41', 'Accept' => "application/json" },
            body: {
                source_number: source_no
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    def self.bank_inquiry(source_no, bank_code, dest_number)
        url = ENV["cekmutasi_api_baseurl"]+ ENV["cekmutasi_api_ovo_bank_inquiry_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => '71dfde726d0c5f7fa7b0c5a74c60fa41', 'Accept' => "application/json" },
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
        url = ENV["cekmutasi_api_baseurl"]+ ENV["cekmutasi_api_ovo_bank_send_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => '71dfde726d0c5f7fa7b0c5a74c60fa41', 'Accept' => "application/json" },
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
        url = ENV["cekmutasi_api_baseurl"]+ ENV["cekmutasi_api_ovo_inquiry_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => '71dfde726d0c5f7fa7b0c5a74c60fa41', 'Accept' => "application/json" },
            body: {
                source_number: source_no,
                phone: phone
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    def self.ovo_transfer(soucer_no, phone, amount)
        url = ENV["cekmutasi_api_baseurl"] + ENV["cekmutasi_api_ovo_send_url"]
        request = Typhoeus::Request.new(
            url,
            method: :post,
            headers: { 'Api-Key' => '71dfde726d0c5f7fa7b0c5a74c60fa41', 'Accept' => "application/json" },
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