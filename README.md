# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise



## Approach

1. Traverse each answers and convert them into its equivalent downcase value.
2. Compare the given answer with the set expected answers.
3. If the given answer matches with our expected answers then proceed otherwise repeat the same step.
4. Once we got the the correct answer wether its YES or NO. 
    <!-- Create corresponding key-value pair in pstore -->
    1. If the answer is yes - Increment yes_count key value. Or create yes_count key and assign value 1 if doesn't exist.
    2. If the answer is no - Increment no_count key value. Or create no_count key and assign value 1 if doesn't exist.
    3. For each answer increment number_of_answers key value. Or create number_of_answers key and assign value 1 if doesn't exist.
    4. Create hash for each answer, add answer and rating keys with their values. Calculate rating as per the given logic.
    5. Add each hash created in previous step in the answers key. If it doesn't exist then create it and add.
    6. After each iteration calculate average rating and print the same.
5. Now, traverse the data stored in pstore, we will get the result like this -
 
<!-- 
Report - 
1. Yes answer count - 4
2. No answer count - 1
3. Total number of answers - 5
4. Answers and their ratings -
  1. Question key = q1, Answer = y, Rating = 100
  2. Question key = q2, Answer = y, Rating = 100
  3. Question key = q3, Answer = y, Rating = 100
  4. Question key = q4, Answer = n, Rating = 75
  5. Question key = q5, Answer = y, Rating = 80
-->

## How to execute this ?

1. Run ruby questionnaire.rb in current folder.
2. For each iteration - supply your anwer. 
    1. This will print your answer rating and their corresponding average rating
3. At the end of the process the final report wil be generated.

For Rspec unit test - 
1. Run rspec spec/report_spec.rb


