module PrivyModule
    # PrivyModule::registration("tester@mail.com", "0217262066", "1234567898", "Udin Jawa", File.new("public/dummy_ktp.jpeg"), File.new("public/dummy_selfie.jpeg"))
    # response -> {:code=>201, :data=>{:email=>"tester@mail.com", :phone=>"+62217262066", :userToken=>"1c4523310e4580359f69a7fae363ef95b8ff3f1aa5fcc6681442e5db5950c56b", :status=>"waiting"}, :message=>"Waiting for Verification"}
    def self.registration(email_user, phone_user, nik, name, file_ktp_image, file_selfie_image)
        url = "#{ENV["PRIVY_API_URL"]}/#{ENV["privy_api_registration_path"]}"
        request = Typhoeus::Request.new(
            url,
            method: :post,
            userpwd: ENV["PRIVY_PASSWORD"],
            headers: { 'Merchant-Key' => ENV["PRIVY_MERCHANT_KEY"], 'ContentType' => "application/json" },
            body: {
                email: email_user,
                phone: phone_user,
                ktp: file_ktp_image,
                selfie: file_selfie_image,
                identity: {
                    nik: nik,
                    nama: name
                }.to_json
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    # {:code=>201, :data=>{:email=>"tester@mail.com", :phone=>"+62217262066", :userToken=>"1c4523310e4580359f69a7fae363ef95b8ff3f1aa5fcc6681442e5db5950c56b", :status=>"waiting"}, :message=>"Waiting for Verification"}
    def self.status_of_registration(token)
        url = "#{ENV["PRIVY_API_URL"]}/#{ENV["privy_api_registration_status_path"]}"
        request = Typhoeus::Request.new(
            url,
            method: :post,
            userpwd: ENV["PRIVY_PASSWORD"],
            headers: { 'Merchant-Key' => ENV["PRIVY_MERCHANT_KEY"], 'ContentType' => "application/json" },
            body: {
                token: token
            }
        )

        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    # PrivyModule::upload_document("testing document 4", "LU8699", "TE4455", File.new("public/dummy.pdf"))
    def self.upload_document(doc_title, signerPrivyID, ownerPrivyID, file)
        url = "#{ENV["PRIVY_API_URL"]}/#{ENV["privy_api_upload_doc_path"]}"
        request = Typhoeus::Request.new(
            url,
            method: :post,
            userpwd: ENV["PRIVY_PASSWORD"],
            headers: { 'Merchant-Key' => ENV["PRIVY_MERCHANT_KEY"], 'ContentType' => "application/json" },
            body: {
                    multipart: true,
                    documentTitle: doc_title,
                    docType: 'Parallel',
                    document: file,
                    recipients: [
                                    {
                                        privyId: signerPrivyID,
                                        type: "Signer",
                                        enterpriseToken: ENV["PRIVY_ENTERPRISE_TOKEN"]
                                    }

                                ].to_json,
                    owner: {
                                privyId: ownerPrivyID,
                                enterpriseToken: ENV["PRIVY_ENTERPRISE_TOKEN"]
                            }.to_json
                }
        )
        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end

    # PrivyModule::check_document_status("6c251be8f8f3fffa8f9fc59f56a52e91d0ebade4c4c9e386472d456d6c067651")
    def self.check_document_status(doc_token)
        url = "#{ENV["PRIVY_API_URL"]}/#{ENV["privy_api_check_doc_status_path"].gsub('{doc_token}', doc_token)}"
        request = Typhoeus::Request.new(
            url,
            method: :get,
            userpwd: ENV["PRIVY_PASSWORD"],
            headers: { 'Merchant-Key' => ENV["PRIVY_MERCHANT_KEY"], 'ContentType' => "application/json" }
        )
        response = request.run
        return JSON.parse(response.response_body, {:symbolize_names => true})
    end
end