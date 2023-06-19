; https://arxiv.org/pdf/2305.02897.pdf: Zhou: An enhanced version created through automated prompt engineering, "Answer: Let’s work this out in a step by step way to be sure we have the right answer."
:*c?:;cot;::Answer: Let's work this out in a step by step way to be sure we have the right answer.

:*ct?:;tobairisch;::Hier ist eine Übersetzung ins Bairisch:
:*ct?:;tobavarian::Hier ist eine Übersetzung ins Bairisch:
:*ct?:;tobayerisch::Hier ist eine Übersetzung ins Bairisch:
:*ct?:;todeutsch;::Hier ist eine Übersetzung ins Hochdeutsch:
:*ct?:;tohochdeutsch;::Hier ist eine Übersetzung ins Hochdeutsch:

:*c?x:;smartgpt;::SmartGPT()
:*c?x:;smartgpt1;::SmartGPT()
:*c?x:;smartgpt2;::SmartGPT2()
:*c?x:;smartgpt3;::SmartGPT3()

; SmartGPT [AI Explained "GPT 4 is Smarter than You Think: Introducing SmartGPT" https://youtu.be/wVzuvf9D9BU?t=355 https://youtu.be/wVzuvf9D9BU?t=139]
SmartGPT()
{
  Tooltip("1. Write your question before ``Answer.`` and submit prompt`n2. For multiple answers, copy and resubmit the entire prompt`n3. After desired number of answers, then in the next prompt use: ```;smartgpt2`;```n(press left alt to clear tooltip)")
  Send("Question.  Answer. Let's work this out in a step by step way to be sure we have the right answer:")
  Sleep(1)
  Send("{Home}{Right 10}")
  Sleep(1000)
  KeyWait("LAlt", "D")
  Tooltip()
}
SmartGPT2()
{
  Tooltip("1. Submit prompt`n2. In the next prompt use: ```;smartgpt3`;```n(press left alt to clear tooltip)")
  Send("You are a researcher tasked with investigating the answer options provided. List the flaws and faulty logic of each answer option. Let's work this out in a step by step way to be sure we have the right answer:")
  Sleep(1000)
  KeyWait("LAlt", "D")
  Tooltip()
}
SmartGPT3()
{
  Tooltip("1. Submit prompt`n2. The answer is the end of SmartGPT`n(press left alt to clear tooltip)")
  Send("You are a resolver tasked with 1) finding which of the answer options the researcher thought was best, 2) improving that answer, and 3) printing the improved answer in full. Let's work this out in a step by step way to be sure we have the right answer:")
  Sleep(1000)
  KeyWait("LAlt", "D")
  Tooltip()
}
