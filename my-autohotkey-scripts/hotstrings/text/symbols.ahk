; NB: Prefer CtrlBackspaceThenSend over BackspaceThenSend when applicable.
; If the hotstring is likely to be its own word, use CtrlBackspaceThenSend for
; efficiency (for example `;checkmark;`).
; If the hotstring is likely to be part of a word, use BackspaceThenSend so
; Ctrl+Backspace does not delete more than intended.

; Bullet point
:*?b0cx:;bp;:: CtrlBackspaceThenSend("{U+2022}", 3)

; Check marks
:*?b0cx:;cm;:: BackspaceThenSend("{U+2705}", StrLen(";cm;")) ; ✅
:*?b0cx:;bcm;:: BackspaceThenSend("{U+2611}", StrLen(";bcm;")) ; ☑
:*?b0cx:;hcm;:: BackspaceThenSend("{U+1F7E8}", StrLen(";hcm;")) ; 🟨
:*?b0cx:;icm;:: BackspaceThenSend("{U+1F7E6}", StrLen(";icm;")) ; 🟦
:*?b0cx:;pcm;:: BackspaceThenSend("{U+23F8}", StrLen(";pcm;")) ; ⏸
:*?b0cx:;ucm;:: BackspaceThenSend("{U+2B1C}", StrLen(";ucm;")) ; ⬜
:*?b0cx:;check;:: BackspaceThenSend("{U+2714}", StrLen(";check;")) ; ✔️
:*?b0cx:;checkmark;:: BackspaceThenSend("{U+2714}", StrLen(";checkmark;")) ; ✔️
:*?b0cx:;cross;:: BackspaceThenSend("{U+274C}", StrLen(";cross;")) ; ❌
:*?b0cx:;crossmark;:: BackspaceThenSend("{U+274C}", StrLen(";crossmark;")) ; ❌
:*?b0cx:;x;:: BackspaceThenSend("{U+274C}", StrLen(";x;")) ; ❌

; Em dashes
:*?b0cx:;em;:: BackspaceThenSend("{U+2014}", StrLen(";em;")) ; —
:*?b0cx:;mdash;:: BackspaceThenSend("{U+2014}", StrLen(";mdash;")) ; —

; En dashes
:*?b0cx:;en;:: BackspaceThenSend("{U+2013}", StrLen(";en;")) ; –
:*?b0cx:;ndash;:: BackspaceThenSend("{U+2013}", StrLen(";ndash;")) ; –

; Degree
:*?b0cx:;degree;:: CtrlBackspaceThenSend("{U+00B0}", 3) ; °

; Emoji
:*?b0cx:;gear;:: CtrlBackspaceThenSend("{U+2699} ", 3) ; ⚙
:*?b0cx:;k;:: CtrlBackspaceThenSend("{U+1F49E} ", 3) ; 💞
:*?b0cx:;kellnermann;:: CtrlBackspaceThenSend("{U+1F49E} ", 3) ; 💞
:*?b0cx:;star;:: CtrlBackspaceThenSend("{U+2B50} ", 3) ; ⭐
:*?b0cx:;social;:: CtrlBackspaceThenSend("{U+1F4AC} ", 3) ; 💬
:*?b0cx:;sozial;:: CtrlBackspaceThenSend("{U+1F4AC} ", 3) ; 💬
:*?b0cx:;z;:: CtrlBackspaceThenSend("{U+1F4AC} ", 3) ; 💬

; Etc.
:*?b0cx:;blocker;:: CtrlBackspaceThenSend("{U+1F6A7}", 3) ; 🚧 Construction sign
:*?b0cx:;cycle;:: CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;again;:: CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;weider;:: CtrlBackspaceThenSend("{U+1F501}", 3) ; 🔁
:*?b0cx:;neu;:: CtrlBackspaceThenSend("{U+1F195}", 3) ; 🆕
:*?b0cx:;new;:: CtrlBackspaceThenSend("{U+1F195}", 3) ; 🆕
:*?b0cx:;v;:: CtrlBackspaceThenSend("{U+1F474}{U+1F3FB}", 3) ; 👴

:*?b0cx:;halfspace;:: BackspaceThenSend("{U+2009}", StrLen(";halfspace;")) ; Thin space
:*?b0cx:;thinspace;:: BackspaceThenSend("{U+2009}", StrLen(";thinspace;")) ; Thin space

; Fractions
:*?b0cx:;fiveeighths;:: CtrlBackspaceThenSend("{U+215D}", 3)
:*?b0cx:;oneeighth;:: CtrlBackspaceThenSend("{U+215B}", 3)
:*?b0cx:;onehalf;:: CtrlBackspaceThenSend("{U+00BD}", 3)
:*?b0cx:;onequarter;:: CtrlBackspaceThenSend("{U+00BC}", 3)
:*?b0cx:;onethird;:: CtrlBackspaceThenSend("{U+2153}", 3)
:*?b0cx:;seveneighths;:: CtrlBackspaceThenSend("{U+215E}", 3)
:*?b0cx:;threefourths;:: CtrlBackspaceThenSend("{U+00BE}", 3)
:*?b0cx:;threequarters;:: CtrlBackspaceThenSend("{U+00BE}", 3)
:*?b0cx:;threeeighths;:: CtrlBackspaceThenSend("{U+215C}", 3)
:*?b0cx:;twothirds;:: CtrlBackspaceThenSend("{U+2154}", 3)

; Greek characters
; First character determines case, for example phi=lowercase and Phi=UPPERCASE.
:*c?:;alpha;:: Send("{U+03B1}")
:*c?:;beta;:: Send("{U+03B2}")
:*?b0cx:;delta;:: BackspaceThenSend("{U+03B4}", StrLen(";delta;"))
:*?b0cx:;Delta;:: BackspaceThenSend("{U+0394}", StrLen(";Delta;"))
:*c?:;epsilon;:: Send("{U+03B5}")
:*c?:;gamma;:: Send("{U+03B3}")
:*c?:;omega;:: Send("{U+03C9}")
:*c?:;phi;:: Send("{U+03C6}")
:*c?:;Phi;:: Send("{U+03A6}")
:*c?:;pi;:: Send("{U+03C0}")
:*c?:;sigma;:: Send("{U+03C3}")
:*c?:;Sigma;:: Send("{U+03A3}")
:*c?:;tau;:: Send("{U+03C4}")
:*c?:;theta;:: Send("{U+03B8}")

; Infinity
:*?b0cx:;inf;:: CtrlBackspaceThenSend("{U+221E}", 3)
:*?b0cx:;infinity;:: CtrlBackspaceThenSend("{U+221E}", 3)

; Non-breaking space
:*cx?:;nbsp;:: SendNoBreakSpaces(1)
:*cx?:;2nbsp;:: SendNoBreakSpaces(2)
:*cx?:;4nbsp;:: SendNoBreakSpaces(4)
:*cx?:;8nbsp;:: SendNoBreakSpaces(8)
:*cx?:;16nbsp;:: SendNoBreakSpaces(16)

; Tree branches
:*?b0cx:;br;:: BackspaceThenSend("{U+251C}{U+2500}{U+003E}", StrLen(";br;"))  ; ├─> tree (br)anch
:*?b0cx:;bre;:: BackspaceThenSend("{U+2514}{U+2500}{U+003E}", StrLen(";bre;")) ; └─> tree (br)anch (e)nd

SendNoBreakSpaces(count) {
    Loop count {
        Send("{U+00A0}")
        Sleep(1)
    }
}
