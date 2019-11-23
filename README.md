# README


ChangeLog:

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