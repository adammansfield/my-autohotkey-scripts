; Deutsch
:*?b0cx:;ae;::BackspaceThenSend("{U+00E4}", strlen(";ae;"))
:*?b0cx:;Ae;::BackspaceThenSend("{U+00C4}", strlen(";Ae;"))
:*?b0cx:;oe;::BackspaceThenSend("{U+00F6}", strlen(";oe;"))
:*?b0cx:;Oe;::BackspaceThenSend("{U+00D6}", strlen(";Oe;"))
:*?b0cx:;ss;::BackspaceThenSend("{U+00DF}", strlen(";ss;"))
:*?b0cx:;SS;::BackspaceThenSend("{U+1E9E}", strlen(";SS;"))
:*?b0cx:;ue;::BackspaceThenSend("{U+00FC}", strlen(";ue;"))
:*?b0cx:;Ue;::BackspaceThenSend("{U+00DC}", strlen(";Ue;"))

;; Send hostring with custom backspacing.
BackspaceThenSend(keys, backspaces)
{
  ;; NOTE: Using hotstrings in OneNote often leaves part of the hotstring
  ;;   Backspacing is more reliable when backspacing with minor sleeps before and after.
  ;; [2020-03-14]
  loop %backspaces% {
    Sleep(2)
    Send("{Backspace}")
    Sleep(2)
  }

  Send(keys)
}
