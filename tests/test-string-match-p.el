;;;; Describe the behaviour of the Emacs builtin `string-match-p`

(describe "partial matching"
  (it "matches the first character"
    (expect
      (string-match-p "x" "xyz")
      :to-equal 0))
  (it "matches a character in the middle"
    (expect
      (string-match-p "y" "xyz")
      :to-equal 1))
  (it "matches the last character"
    (expect
      (string-match-p "z" "xyz")
      :to-equal 2)))

(describe "anchored matching"
  (describe "when anchored to the start"
    (it "matches from the start"
      (expect
        (string-match-p "^xy" "xyz")
        :to-equal 
        0))
    (it "doesn't match a character in the middle"
      (expect
        (string-match-p "^y" "xyz")
        :to-equal nil)))
  (describe "when anchored to the end"
    (it "matches at the end"
      (expect
        (string-match-p "yz$" "xyz")
        :to-equal 1))
    (it "doesn't match a character in the middle"
      (expect
        (string-match-p "y$" "xyz")
        :to-equal nil))))

(describe "special characters"
  (describe "*"
    (it "matches anything"
      (expect
        (string-match-p "h*" "xyz")
        :not :to-be nil))
    (it "matches greedily"
      (expect
        (string-match-p "u*" "fuu")
        :to-equal 0)))
  (describe "+"
    (it "doesn't match zero occurences"
      (expect
        (string-match-p "q+" "xyz")
        :to-be nil))
    (it "matches one occurence"
      (expect
        (string-match-p "y+" "xyz")
        :to-equal 1))
    (it "matches many"
      (expect
        (string-match-p "u+" "fuuuu")
        :to-equal 1))))

(describe "quoting"
  (describe "\\*"
    (it "matches *"
      (expect
        (string-match-p "\\*" "i*i")
        :to-equal 1))
    (it "doesn't act as a special character"
      (expect
        (string-match-p "u\\*" "fuu")
        :to-equal nil))))
