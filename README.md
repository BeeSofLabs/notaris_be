# README


ChangeLog:

* change latitudes into lat with type "float"
* change longitude into lng with type "float"

ModelLogic changes:
- Use Notaris order to counting chart data item related with order request document to Notaris in CMS-Notaris panel
- Mechanism every time document order "Done" status , the system will backup all data related to plain table called "notaris_order"
- consist of validation data field:
    1. in users table has "valid_count_search_notaris" for handle validation related with how many times seach experience for lookup notaris account allowed
    2. in orders table has "valid_expired_datetime", will set experience date in 24 hour once created, if not valid anymore the order will auto soft delete by flag and can be opened later in backoffice
- Add Field "Active" for toggle service available by Notariss