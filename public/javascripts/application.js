function punctuationlessCaseAgnosticWordCompare(word1, word2) {
  removePunctuationAndApostrophe = function(word) {
    return word.toLowerCase().replace(/'/g, "");
  }
  return removePunctuationAndApostrophe(word1) ==
         removePunctuationAndApostrophe(word2);
}