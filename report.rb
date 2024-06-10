class Report
    # Global variable for possible answers
    POSSIBLE_YES_ANSWERS = ["yes", "y"]
    POSSIBLE_NO_ANSWERS = ["no", "n"]
    HORIZONTAL_LINE_LENGTH = 40

    def initialize(store, questions)   
        @store = store
        @questions = questions 
        # question_counter will be used to print question numbers.
        @question_counter = 1
    end

    def do_prompt
        @questions.each_key do |question_key|
            print "#{@question_counter}. " +  @questions[question_key]
            # Convert input into downcase string for better string comparison
            ans = gets.chomp.downcase
            # If the given input lies within our possible answer set then proceed else repeat the same process
            if POSSIBLE_YES_ANSWERS.include?(ans) || POSSIBLE_NO_ANSWERS.include?(ans)
                print_horizontal_line
                @store.transaction do
                    # Check the presence of the corresponding values and proceed further
                    yes_count = @store.present? && @store[:yes_count].present? ? @store[:yes_count] : 0
                    @store[:yes_count] = (POSSIBLE_YES_ANSWERS.include?(ans)) ? yes_count.to_i + 1 : yes_count
                    
                    no_count = @store.present? && @store[:no_count].present? ? @store[:no_count] : 0
                    @store[:no_count] = (POSSIBLE_NO_ANSWERS.include?(ans)) ? no_count.to_i + 1 : no_count
                    
                    number_of_questions = @store[:number_of_questions].present? ? @store[:number_of_questions] : 0
                    @store[:number_of_questions] = number_of_questions.to_i + 1
            
                    # Createed hash data for answer and rating per question
                    data = {
                        "answer": ans,
                        "rating": (100 * @store[:yes_count]) / @store[:number_of_questions]
                    }

                    @store[:answers] ||= {}
                    @store[:answers][question_key] ||= {}
                    @store[:answers][question_key] = data
            
                    # After first iteration - print rating and average rating the corresponding input
                    print_rating_and_average_rating(@store[:yes_count], @store[:number_of_questions], @store[:answers])
                    print_horizontal_line
                    @question_counter = @question_counter + 1
                end
            else
                print_horizontal_line
                puts "Invalid input. Please try again."
                print_horizontal_line
                redo
            end
      
        end
    end
      
      
    # Print final report once the questionnaire session ends
    def do_report
        puts "Report - "
        count = 1
        @store.transaction do
            puts "#{count}. Yes answer count - #{@store[:yes_count]}" if @store[:yes_count].present?
            count = count + 1
            puts "#{count}. No answer count - #{@store[:no_count]}" if @store[:no_count].present?
            count = count + 1
            puts "#{count}. Total number of answers - #{@store[:number_of_questions]}" if @store[:number_of_questions].present?
            count = count + 1
            puts "#{count}. Answers and their ratings -" if @store[:answers].present?
            count = 1
            @store[:answers].each_key do |ans|
                puts "  #{count}. Question key = #{ans}, Answer = #{@store[:answers][ans][:answer]}, Rating = #{@store[:answers][ans][:rating]}"
                count = count + 1
            end
            print_horizontal_line
        end
    end

    private
    # Calculate and print rating and average rating per answer
    def print_rating_and_average_rating(yes_count, number_of_questions, params)
        total_rating = 0
        params.each_key do |param|
          total_rating = total_rating + params[param][:rating]
        end 
        puts "Rating = #{(yes_count * 100) / number_of_questions}, Average Rating = #{total_rating / params.keys.count}"
    end
      
    # Print horizontal line
    def print_horizontal_line
        puts "-" * HORIZONTAL_LINE_LENGTH
    end
end