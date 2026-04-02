#if WinActive("GnuCash")
{
  RShift & Enter::GnuCashNewTransaction()
}
#if

GnuCashNewTransaction()
{
  ; Submits current transaction and moves cursor to new transaction, assuming:
  ; 1. Sort By: Reverse Order
  ; 2. There exists a placeholder transaction in the far future
  ; 3. If cursor is on description, then there are no more than 3 splits
  Send("{Enter 4}") ; Increase to 5 if assuming >= 4 splits
  Sleep(10)
  Send("{PgUp}{Tab 2}")
}
