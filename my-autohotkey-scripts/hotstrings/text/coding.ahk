:*b0cx?:;cb;:: BackspaceThenSend("{{}{}}{Left}", StrLen(";cb;"))
:*b0cx?:;rb;:: BackspaceThenSend("(){Left}", StrLen(";rb;"))
:*b0cx?:;sb;:: BackspaceThenSend("[]{Left}", StrLen(";sb;"))
:*b0cx?:;wip;:: BackspaceThenSend("[WIP]{Space}", StrLen(";wip;"))

:*c?:;copyright;::{#}region --[Copyright]---------------------------------------------------------
:*c?:;constructors;::{#}region --[Constructors]----------------------------------------------
:*c?:;namespaces;::{#}region --[Namespaces]----------------------------------------------------
:*c?:;privateclasses;::{#}region --[Classes: Private]------------------------------------------
:*c?:;privateconstants;::{#}region --[Constants: Private]----------------------------------------
:*c?:;privatefields;::{#}region --[Fields: Private]-------------------------------------------
:*c?:;privatemethods;::{#}region --[Methods: Private]------------------------------------------
:*c?:;privateproperties;::{#}region --[Properties: Private]---------------------------------------
:*c?:;internalmethods;::{#}region --[Methods: Internal]-----------------------------------------
:*c?:;protectedmethods;::{#}region --[Methods: Protected]----------------------------------------
:*c?:;publicclasses;::{#}region --[Classes: Public]-------------------------------------------
:*c?:;publicconstants;::{#}region --[Constants: Public]-----------------------------------------
:*c?:;publicfields;::{#}region --[Fields: Public]--------------------------------------------
:*c?:;publicmethods;::{#}region --[Methods: Public]-------------------------------------------
:*c?:;publicproperties;::{#}region --[Properties: Public]----------------------------------------
:*c?:;tests;::{#}region --[Tests]-----------------------------------------------------

:*c?:;cppheader;::
{
    text := "
    ( LTrim
        #if !defined(DontCommit_Header_Guard)
        #define DontCommit_Header_Guard
        
        #ifdef _MSC_VER
        #pragma once
        #endif
        
        namespace DontCommit_Namespace
        {
        /**
        @brief DontCommit(todo) Fill out.
        */
        class DontCommit_Class
        {
        public:
        private:
        };
        }
        
        #endif
    )"
    SendText(text)
}

:*c?:;csdmlog;::
{
    text := "
    ( LTrim
        System.IO.File.AppendAllText($"[DONTMERGE]-{System.Diagnostics.Process.GetCurrentProcess().StartTime:yyyyMMddTHHmmss}.log", $"{DateTime.Now:yyyyMMddTHHmmss} {System.Reflection.MethodBase.GetCurrentMethod ().DeclaringType}) " +
    )"
    SendText(text)

    text := "
    ( LTrim
        
        $""
        + Environment.NewLine) ;
    )"
    SendText(text)
}

:*c:;methodregex;::(\.|->)\({Left 2}
