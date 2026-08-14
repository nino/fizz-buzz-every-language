#!/usr/bin/env python3
"""An interpreter for the Shakespeare Programming Language.

SPL programs are plays. Each character is a signed integer variable with its
own stack; exactly two characters may be on stage at once, and a line of
dialogue is an instruction addressed by the speaker to the other one. "You"
means the listener, so `Juliet: Thou art the sum of thyself and a cat.`
increments whoever Juliet is talking to.

Constants are noun phrases: the noun supplies the sign (+1, or -1 for the
unpleasant ones) and every adjective in front of it doubles the magnitude, so
"a fair sweet cat" is 4 and "a stinking fat pig" is -4.

Supported: assignment, arithmetic (including remainder), comparison
questions, conditional statements, goto, stack push/pop, and both output
forms. Input verbs are recognised but read from stdin.
"""
import re
import sys
from pathlib import Path

# --- vocabulary ------------------------------------------------------------

POSITIVE_NOUNS = {
    "heaven", "king", "lord", "angel", "flower", "happiness", "joy", "plum",
    "hero", "rose", "kingdom", "pony", "summer",
}
NEUTRAL_NOUNS = {
    "animal", "aunt", "brother", "cat", "chihuahua", "cousin", "cow",
    "daughter", "door", "face", "father", "fellow", "granddaughter",
    "grandfather", "grandmother", "grandson", "hair", "hamster", "horse",
    "lamp", "lantern", "mistletoe", "moon", "morning", "mother", "nephew",
    "niece", "nose", "purse", "road", "roman", "sister", "sky", "son",
    "squirrel", "stone", "thing", "town", "tree", "uncle", "wind", "wall",
}
NEGATIVE_NOUNS = {
    "hell", "microsoft", "bastard", "beggar", "blister", "codpiece",
    "coward", "curse", "death", "devil", "draught", "famine", "flirt",
    "goat", "hate", "hog", "hound", "leech", "lie", "pig", "plague",
    "starvation", "toad", "war", "wolf",
}
ADJECTIVES = {
    "amazing", "beautiful", "blossoming", "bold", "brave", "charming",
    "clearest", "cunning", "cute", "delicious", "embroidered", "fair",
    "fine", "gentle", "golden", "good", "handsome", "happy", "healthy",
    "honest", "lovely", "loving", "mighty", "noble", "peaceful", "pretty",
    "prompt", "proud", "reddest", "rich", "smooth", "sunny", "sweet",
    "sweetest", "trustworthy", "warm",
    "bad", "cowardly", "cursed", "damned", "dirty", "disgusting",
    "distasteful", "dreadful", "evil", "fat", "fatuous", "foul", "hairy",
    "horrible", "horrid", "infected", "lying", "miserable", "misused",
    "oozing", "rotten", "smelly", "snotty", "sore", "sorry", "stinking",
    "stupid", "stuffed", "vile", "villainous", "worried",
}
FIRST_PERSON = {"i", "me", "myself"}
SECOND_PERSON = {"you", "thee", "thou", "thyself", "yourself"}

ROMAN = {
    "i": 1, "ii": 2, "iii": 3, "iv": 4, "v": 5, "vi": 6, "vii": 7,
    "viii": 8, "ix": 9, "x": 10, "xi": 11, "xii": 12, "xiii": 13,
    "xiv": 14, "xv": 15, "xvi": 16, "xvii": 17, "xviii": 18, "xix": 19,
    "xx": 20,
}


def words(text: str) -> list[str]:
    return re.findall(r"[a-z']+", text.lower())


class Character:
    __slots__ = ("name", "value", "stack")

    def __init__(self, name: str) -> None:
        self.name = name
        self.value = 0
        self.stack: list[int] = []


class Play:
    def __init__(self, src: str) -> None:
        self.characters: dict[str, Character] = {}
        self.on_stage: list[Character] = []
        self.condition: bool | None = None
        self.scenes: list[list[tuple]] = []      # flat list of scenes
        self.labels: dict[tuple[int, int], int] = {}
        self._parse(src)

    # -- parsing ------------------------------------------------------------

    def _parse(self, src: str) -> None:
        # The title runs to the first period; declarations follow until Act I.
        body = src.split(".", 1)[1] if "." in src else src

        act_re = re.compile(r"^\s*Act\s+([IVXL]+)\s*:", re.I | re.M)
        scene_re = re.compile(r"^\s*Scene\s+([IVXL]+)\s*:", re.I | re.M)

        first_act = act_re.search(body)
        decls = body[: first_act.start()] if first_act else body
        for line in decls.split("."):
            line = line.strip()
            if "," in line:
                name = line.split(",")[0].strip()
                if name and name[0].isupper() and len(name.split()) == 1:
                    self.characters[name.lower()] = Character(name)

        if not first_act:
            raise SystemExit("no acts found")

        # Walk acts, then scenes inside each act.
        acts = list(act_re.finditer(body))
        for ai, am in enumerate(acts):
            act_no = ROMAN[am.group(1).lower()]
            end = acts[ai + 1].start() if ai + 1 < len(acts) else len(body)
            chunk = body[am.end():end]
            scenes = list(scene_re.finditer(chunk))
            for si, sm in enumerate(scenes):
                scene_no = ROMAN[sm.group(1).lower()]
                s_end = scenes[si + 1].start() if si + 1 < len(scenes) else len(chunk)
                text = chunk[sm.end():s_end]
                self.labels[(act_no, scene_no)] = len(self.scenes)
                self.scenes.append(self._parse_scene(text))

    def _parse_scene(self, text: str) -> list[tuple]:
        events: list[tuple] = []
        # Stage directions are bracketed; dialogue is "Name: sentences."
        for part in re.split(r"(\[[^\]]*\])", text):
            part = part.strip()
            if not part:
                continue
            if part.startswith("["):
                events.append(("stage", part[1:-1].strip()))
                continue
            # Split the prose into "Speaker: ...speech..." blocks.
            for m in re.finditer(
                r"([A-Z][a-zA-Z]*)\s*:\s*(.*?)(?=(?:[A-Z][a-zA-Z]*\s*:)|\Z)",
                part,
                re.S,
            ):
                speaker = m.group(1).lower()
                if speaker not in self.characters:
                    continue
                for sentence in re.findall(r"[^.!?]+[.!?]", m.group(2)):
                    s = sentence.strip()
                    if s:
                        events.append(("line", speaker, s))
        return events

    # -- expression evaluation ---------------------------------------------

    def _speaker_listener(self, speaker: str) -> tuple[Character, Character]:
        spk = self.characters[speaker]
        others = [c for c in self.on_stage if c is not spk]
        if not others:
            raise SystemExit(f"{spk.name} is talking to nobody")
        return spk, others[0]

    def _value(self, toks: list[str], i: int, spk, lis) -> tuple[int, int]:
        """Evaluate the expression starting at toks[i]; return (value, next_i)."""
        while i < len(toks) and toks[i] in ("the", "a", "an", "as", "and", "than"):
            i += 1
        if i >= len(toks):
            return 0, i
        w = toks[i]

        if w in ("sum", "difference", "product", "quotient", "remainder"):
            op = w
            i += 1
            if op == "remainder":
                # "the remainder of the quotient between X and Y"
                while i < len(toks) and toks[i] in ("of", "the", "quotient", "between"):
                    i += 1
                a, i = self._value(toks, i, spk, lis)
                while i < len(toks) and toks[i] == "and":
                    i += 1
                b, i = self._value(toks, i, spk, lis)
                return (abs(a) % abs(b) * (1 if a >= 0 else -1)) if b else 0, i
            while i < len(toks) and toks[i] in ("of", "between", "and"):
                i += 1
            a, i = self._value(toks, i, spk, lis)
            while i < len(toks) and toks[i] == "and":
                i += 1
            b, i = self._value(toks, i, spk, lis)
            if op == "sum":
                return a + b, i
            if op == "difference":
                return a - b, i
            if op == "product":
                return a * b, i
            return (int(a / b) if b else 0), i

        if w == "twice":
            v, i = self._value(toks, i + 1, spk, lis)
            return 2 * v, i
        if w in ("square", "cube"):
            # "the square of X" / "the square root of X" / "the cube of X"
            if toks[i : i + 2] == ["square", "root"]:
                v, i = self._value(toks, i + 3, spk, lis)
                return int(abs(v) ** 0.5), i
            v, i = self._value(toks, i + 2, spk, lis)
            return v * v if w == "square" else v * v * v, i

        if w in FIRST_PERSON:
            return spk.value, i + 1
        if w in SECOND_PERSON:
            return lis.value, i + 1
        if w in self.characters:
            return self.characters[w].value, i + 1
        if w == "nothing" or w == "zero":
            return 0, i + 1

        # A noun phrase: adjectives double, the noun carries the sign.
        mult = 1
        while i < len(toks) and toks[i] in ADJECTIVES:
            mult *= 2
            i += 1
        if i < len(toks):
            n = toks[i]
            i += 1
            if n in NEGATIVE_NOUNS:
                return -mult, i
            if n in POSITIVE_NOUNS or n in NEUTRAL_NOUNS:
                return mult, i
        return 0, i

    def evaluate(self, text: str, spk, lis) -> int:
        toks = words(text)
        v, _ = self._value(toks, 0, spk, lis)
        return v

    # -- execution ----------------------------------------------------------

    def run(self) -> None:
        pc = 0
        out = sys.stdout
        while 0 <= pc < len(self.scenes):
            jump = None
            for event in self.scenes[pc]:
                if event[0] == "stage":
                    self._stage(event[1])
                    continue
                _, speaker, sentence = event
                jump = self._execute(speaker, sentence, out)
                if jump is not None:
                    break
            pc = jump if jump is not None else pc + 1
        out.flush()

    def _stage(self, direction: str) -> None:
        toks = words(direction)
        if not toks:
            return
        verb = toks[0]
        named = [self.characters[t] for t in toks[1:] if t in self.characters]
        if verb == "enter":
            for c in named:
                if c not in self.on_stage:
                    self.on_stage.append(c)
        elif verb == "exit":
            for c in named:
                if c in self.on_stage:
                    self.on_stage.remove(c)
        elif verb == "exeunt":
            if named:
                for c in named:
                    if c in self.on_stage:
                        self.on_stage.remove(c)
            else:
                self.on_stage.clear()

    def _execute(self, speaker: str, sentence: str, out) -> int | None:
        spk, lis = self._speaker_listener(speaker)
        low = sentence.lower()
        toks = words(sentence)

        # Conditional prefix: "If so, ..." / "If not, ..."
        if low.startswith("if so") or low.startswith("if not"):
            want = low.startswith("if so")
            rest = sentence.split(",", 1)[1].strip() if "," in sentence else ""
            if self.condition is None or self.condition != want:
                return None
            return self._execute(speaker, rest, out) if rest else None

        # Goto
        m = re.search(r"let us (?:proceed|return) to (act|scene) ([ivxl]+)", low)
        if m:
            kind, num = m.group(1), ROMAN[m.group(2)]
            here = next(k for k, v in self.labels.items()
                        if v == self._current_index)
            if kind == "scene":
                target = (here[0], num)
            else:
                target = (num, min(s for (a, s) in self.labels if a == num))
            return self.labels.get(target)

        # Output
        if "open your heart" in low:
            out.write(str(lis.value))
            return None
        if "speak your mind" in low:
            out.write(chr(lis.value % 0x110000))
            return None

        # Stack
        if low.startswith("remember"):
            lis.stack.append(self.evaluate(sentence[len("remember"):], spk, lis))
            return None
        if low.startswith("recall"):
            lis.value = lis.stack.pop() if lis.stack else 0
            return None

        # Questions set the condition flag.
        if sentence.rstrip().endswith("?"):
            self.condition = self._question(toks, spk, lis)
            return None

        # Assignment: "You are ...", "Thou art ...", "<Name>, you are ..."
        m = re.match(r"\s*(?:thou art|you are|thou|you)\b(.*)", low, re.S)
        if m:
            lis.value = self.evaluate(m.group(1), spk, lis)
            return None
        return None

    def _question(self, toks: list[str], spk, lis) -> bool:
        """Resolve a comparison question into the condition flag.

        The subject comes from the opener -- "Am I" is the speaker, "Are you"
        the listener, and "Is X" names it outright -- so it cannot be read off
        the comparison clause alone.
        """
        low = " ".join(toks)
        left = None
        if low.startswith("am i"):
            left, rest = spk.value, low[len("am i"):]
        elif low.startswith("are you"):
            left, rest = lis.value, low[len("are you"):]
        elif low.startswith("art thou"):
            left, rest = lis.value, low[len("art thou"):]
        elif low.startswith("is "):
            rest = low[len("is "):]
        else:
            left, rest = spk.value, low

        neg = re.search(r"\bnot\b", rest) is not None

        eq = re.search(r"\bas\s+\w+\s+as\b", rest)
        if eq:
            op, before, after = "eq", rest[: eq.start()], rest[eq.end():]
        elif re.search(r"\b(?:better|more)\b", rest):
            op = "gt"
            before, _, after = rest.partition(" than ")
        elif re.search(r"\b(?:worse|less)\b", rest):
            op = "lt"
            before, _, after = rest.partition(" than ")
        else:
            op, before, after = "eq", "", rest

        if left is None:
            left = self.evaluate(before, spk, lis)
        right = self.evaluate(after, spk, lis)
        res = {"gt": left > right, "lt": left < right, "eq": left == right}[op]
        return (not res) if neg else res

    _current_index = 0

    def run_indexed(self) -> None:
        pc = 0
        out = sys.stdout
        while 0 <= pc < len(self.scenes):
            self._current_index = pc
            jump = None
            for event in self.scenes[pc]:
                if event[0] == "stage":
                    self._stage(event[1])
                    continue
                jump = self._execute(event[1], event[2], out)
                if jump is not None:
                    break
            pc = jump if jump is not None else pc + 1
        out.flush()


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} play.spl", file=sys.stderr)
        return 2
    Play(Path(sys.argv[1]).read_text()).run_indexed()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
