;; Hotkeys for this Autohotkey script such as reloading and protoyping.


<!r::AlertedReload()
<!'::PrototypeFunction()


;; Reload script with alert.
AlertedReload()
{
  Tooltip("reloading my-autohotkey-scripts.ahk")
  Speak("re loading")
  Reload()
}

;; Function used for prototyping.
PrototypeFunction()
{
}
