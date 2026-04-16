CtrlBackspaceThenSend(keys, ctrlBackspaces) {
    ; OneNote and Slack can leave partial trigger text unless deletion is paced.
    Loop ctrlBackspaces {
        Sleep(2)
        Send("^{Backspace}")
        Sleep(2)
    }

    Sleep(4)
    Send(keys)
}

CtrlBackspaceThenSendText(text, ctrlBackspaces) {
    ; Keep text-mode sending paired with the same paced deletion behavior.
    Loop ctrlBackspaces {
        Sleep(2)
        Send("^{Backspace}")
        Sleep(2)
    }

    Sleep(4)
    SendText(text)
}

BackspaceThenSend(keys, backspaces) {
    ; Plain backspaces need the same pacing for reliable replacement in some apps.
    Loop backspaces {
        Sleep(1)
        Send("{Backspace}")
        Sleep(1)
    }

    Send(keys)
}

BackspaceThenSendText(text, backspaces) {
    ; Plain backspaces need the same pacing for reliable replacement in some apps.
    Loop backspaces {
        Sleep(1)
        Send("{Backspace}")
        Sleep(1)
    }

    SendText(text)
}
