# README

ChangeLog [12Dec]:
* Add api payment for bank transfer via ovo
* Add api payment between ovo transfer accounts

ChangeLog [6Dec]:
* Add api for update order
* Add api for detail order
* Fix api for document parties
  
ChangeLog [29Nov]:
* Add api for create chat
* Add api for destroy chat
* Add api for get chat room
* Add api for get list orders

ModelLogic changes:
* create ChatRoom
* create Chat
* order has one chat room
* chat room has many chats
* user has many chats

ChangeLog [29Nov]:
* Add api for get html template document (skmht, apht, covernote, fidusia)
* Add api upload content html for order document
* Add api generate pdf from document content and return response fullpath pdf file
* Get link iframe privy for go sign agreement in privyID


ChangeLog [27Nov]:
* add new field "no_request_order" for identify multiple order in same request
    - for case order document type selected, document will create and set "no_request_order"
    - document first will check if has "no_request_order" or null, if null will generate no_request_order but if not null will set same "no_request_order" for second document, this case for handle user create document in "skmht & apht" type
* add api for collateral (create, list, remove)
* in collateral (immovable_collateral, movable_collateral) table, in "signed" field change type into string to store "atas nama" for collateral infomation
* remove collateral table from relation "notary_service"
* add relation between collateral (immovable_collateral, movable_collateral) table and users table
* add validation show collateral list by collateral_owner in api
* add "no_order" field in order table for identity order in document with specific format
* add "no_collateral" field in collateral table for identity collateral in document with specific format

ChangeLog [20Nov]:
* change latitudes into lat with type "float"
* change longitude into lng with type "float"

ModelLogic changes:
[17Nov]:
- change table from fidusia_order, skmht_order, apht_order into fidusia_collateral, skmht_collateral, apht_collateral
- add field column in orders table (no_perjanjian, plafond, tgl_akad, tgl_jatuh_tempo, tarif_bunga, jangka_waktu, agunan_pokok, angsuran_bunga)
- Create new table "menu_home_preview" for handle list of menu that will show sequence item in dashboard


- Use Notaris order to counting chart data item related with order request document to Notaris in CMS-Notaris panel
- Mechanism every time document order "Done" status , the system will backup all data related to plain table called "notaris_order"
- consist of validation data field:
    1. in users table has "valid_count_search_notaris" for handle validation related with how many times seach experience for lookup notaris account allowed
    2. in orders table has "valid_expired_datetime", will set experience date in 24 hour once created, if not valid anymore the order will auto soft delete by flag and can be opened later in backoffice
- Add Field "Active" for toggle service available by Notariss

[21-nov]
- change "delete" field on order to "is_deleted
- add debtor_id and collateral_owner_id to order

[24-nov]:
- create collateral orders to for connecting order and movable_collaterals - immovable collaterals
- drop collateral
- revert create order migration change
- add data type to remove redundant expoired in order migration
- swap movable_collateral and immovable_collateral fields
