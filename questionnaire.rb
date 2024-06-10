require "pstore" # https://github.com/ruby/pstore
require 'active_support/all'
require_relative "report"

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

questions = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

report = Report.new(store, questions)
report.do_prompt
report.do_report



