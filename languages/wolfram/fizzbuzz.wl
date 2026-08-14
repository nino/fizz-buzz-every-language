Do[
  Print[
    Which[
      Mod[i, 15] == 0, "FizzBuzz",
      Mod[i, 3] == 0, "Fizz",
      Mod[i, 5] == 0, "Buzz",
      True, i
    ]
  ],
  {i, 1, 100}
]
