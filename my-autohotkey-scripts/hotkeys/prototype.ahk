<!r::AlertedReload()
<!'::PrototypeFunction()

;; Reload script with alert.
AlertedReload()
{
  Tooltip("reloading my-autohotkey-scripts.ahk")
  Speak("re loading")
  Reload()
}

;; Output to file the NumPut commands required to recreate a byte stream.
;; e.g. data := ClipboardAll
;;      DumpBytesToFile(data, strlen(data))
DumpBytesToFile(data, len, filename)
{
  FileAppend("VarSetCapacity(" len ")`n", filename)
  Loop, %len% {
    offset := A_Index - 1
    value := NumGet(data, offset, "UChar")
    FileAppend("NumPut(" value ", data, " offset ", ""UChar"")`n", filename)
  }
}

;; Function used for prototyping.
PrototypeFunction()
{
}
