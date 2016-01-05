:?c:date`;::
{
  Send(A_YYYY "-" A_MM "-" A_DD)
  return
}

:?c:datetime`;::
{
  Send(A_YYYY "-" A_MM "-" A_DD "T" A_Hour ":" A_Min)
  return
}

:?c:time`;::
{
  Send(A_Hour ":" A_Min)
  return
}
