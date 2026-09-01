#HotIf WinActive("GnuCash")
RShift & Enter:: GnuCashNewTransaction()
#HotIf

GnuCashNewTransaction() {
    ; Submits the current transaction and moves the cursor to a new transaction, assuming:
    ; 1. Sort By: Reverse Order
    ; 2. There is a placeholder transaction in the far future
    ; 3. If the cursor is on the description, there are no more than 3 splits
    Send("{Enter 4}") ; Increase to 5 if assuming >= 4 splits
    Sleep(10)
    Send("{PgUp}{Tab 2}")
}
