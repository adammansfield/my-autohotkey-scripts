;; Displays a formatted message detailing info about the given Exception.
;;
;; @param e Exception
HandleException(e)
{
  static kStackTraceToken = "Traceback"

  if (InStr(e.extra, kStackTraceToken))
  {
    message := e.extra
  }
  else
  {
    message := "File """ e.file """, line " e.line " [" e.what "]"
  }

  if (e.message)
  {
    message := message "`n" e.message
  }

  MsgBox(message)
}
