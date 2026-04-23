import { execFileSync } from "node:child_process";

const args = process.argv.slice(2);

type TaskState = "todo" | "attention" | "scheduled" | "inProgress" | "done";

type ParsedTaskLine = {
  indent: number;
  indentText: string;
  state: TaskState;
  text: string;
};

function convertMarkdownTasksToSlack(markdown: string): string {
  const newline = markdown.includes("\r\n") ? "\r\n" : "\n";
  const hasTrailingNewline = markdown.endsWith("\r\n") || markdown.endsWith("\n");
  const lines = markdown.split(/\r?\n/);
  const convertedLines: string[] = [];

  for (let i = 0; i < lines.length; i += 1) {
    const line = lines[i]!;
    const parentTask = parseTaskLine(line);
    if (!parentTask) {
      convertedLines.push(line);
      continue;
    }

    const childTasks: ParsedTaskLine[] = [];
    let childIndex = i + 1;
    while (childIndex < lines.length) {
      const childTask = parseTaskLine(lines[childIndex]!);
      if (!childTask || childTask.indent <= parentTask.indent) {
        break;
      }

      childTasks.push(childTask);
      childIndex += 1;
    }

    convertedLines.push(
      `${parentTask.indentText}${taskStateToSlack(parentTask.state)} ${parentTask.text}`,
    );

    childTasks.forEach((childTask, index) => {
      const connector = index === childTasks.length - 1 ? "└─>" : "├─>";
      convertedLines.push(
        `${parentTask.indentText}${connector}${taskStateToSlack(childTask.state)} ${childTask.text}`,
      );
    });

    i = childIndex - 1;
  }

  return convertedLines.join(newline) + (hasTrailingNewline ? newline : "");
}

function parseTaskLine(line: string): ParsedTaskLine | null {
  const match = /^(\s*)-\s+\[( |o|!|<|x|X|\/)\]\s+(.*)$/.exec(line);
  if (!match) {
    return null;
  }

  const indentText = match[1]!;
  const stateMarker = match[2]!;
  const text = match[3]!;
  return {
    indent: indentText.length,
    indentText,
    state: parseTaskState(stateMarker),
    text,
  };
}

function parseTaskState(stateMarker: string): TaskState {
  if (stateMarker === " " || stateMarker === "o") {
    return "todo";
  }

  if (stateMarker === "/") {
    return "inProgress";
  }

  if (stateMarker === "!") {
    return "attention";
  }

  if (stateMarker === "<") {
    return "scheduled";
  }

  return "done";
}

function taskStateToSlack(state: TaskState): string {
  switch (state) {
    case "todo":
      return "⬜";
    case "attention":
      return "🟨";
    case "scheduled":
      return "📅";
    case "inProgress":
      return "🟦";
    case "done":
      return "✅";
  }
}

function readClipboard(): string {
  return execFileSync("powershell.exe", ["-NoProfile", "-Command", "Get-Clipboard -Raw"], {
    encoding: "utf8",
  });
}

function writeClipboard(text: string): void {
  execFileSync(
    "powershell.exe",
    ["-NoProfile", "-Command", "Set-Clipboard -Value ([Console]::In.ReadToEnd())"],
    {
      encoding: "utf8",
      input: text,
    },
  );
}

if (args.length > 1) {
  const outputPath = args[0]!;
  const markdownParts = args.slice(1);
  await Bun.write(outputPath, convertMarkdownTasksToSlack(markdownParts.join(" ")));
} else if (args.length === 1) {
  process.stdout.write(convertMarkdownTasksToSlack(args[0]!));
} else {
  writeClipboard(convertMarkdownTasksToSlack(readClipboard()));
}
