# https://adventofcode.com/2022/day/2

# input = readlines("2022/testdata/day_2.txt")
input = readlines("2022/data/day_2.txt")

function score(r)
    # Opponent 
    #   A is Rock
    #   B is Paper
    #   C is Scissors
    # Self (second column)
    #   X is Rock
    #   Y is Paper
    #   Z is Scissors
    outcome = 0
    mychoice = 0
    if r[3] == 'X'         # I play Rock
        mychoice = 1
        if r[1] == 'A'     # Opponent plays Rock
            outcome = 3 # Draw
        elseif r[1] == 'B' # Opponent plays Paper
            outcome = 0 # Lose
        else               # Oppenent plays Scissors
            outcome = 6 # Win
        end
    elseif r[3] == 'Y'         # I play Paper
        mychoice = 2
        if r[1] == 'A'     # Opponent plays Rock
            outcome = 6 # Win
        elseif r[1] == 'B' # Opponent plays Paper
            outcome = 3 # Draw
        else               # Oppenent plays Scissors
            outcome = 0 # Lose
        end
    elseif r[3] == 'Z'         # I play Scissors
        mychoice = 3
        if r[1] == 'A'     # Opponent plays Rock
            outcome = 0 # Lose
        elseif r[1] == 'B' # Opponent plays Paper
            outcome = 6 # Win
        else               # Oppenent plays Scissors
            outcome = 3 # Draw
    
        end
    end
    return mychoice + outcome
end

function part_1(input)
    return sum(score.(input))
end
@info part_1(input)

function corrected_score(r)
    # Opponent 
    #   A is Rock
    #   B is Paper
    #   C is Scissors
    # Self (second column)
    #   X is Lose
    #   Y is Draw
    #   Z is Win
    outcome = 0
    mychoice = 0
    if r[3] == 'X'         # I need to Lose
        outcome = 0
        if r[1] == 'A'     # Opponent plays Rock
            mychoice = 3 # Scissors
        elseif r[1] == 'B' # Opponent plays Paper
            mychoice = 1 # Rock
        else               # Oppenent plays Scissors
            mychoice = 2 # Paper
        end
    elseif r[3] == 'Y'         # I need to Draw
        outcome = 3
        if r[1] == 'A'     # Opponent plays Rock
            mychoice = 1 # Rock
        elseif r[1] == 'B' # Opponent plays Paper
            mychoice = 2 # Paper
        else               # Oppenent plays Scissors
            mychoice = 3 # Scissors
        end
    elseif r[3] == 'Z'         # I need to Win
        outcome = 6
        if r[1] == 'A'     # Opponent plays Rock
            mychoice = 2 # Paper
        elseif r[1] == 'B' # Opponent plays Paper
            mychoice = 3 # Scissors
        else               # Oppenent plays Scissors
            mychoice = 1 # Rock
        end
    end
    return mychoice + outcome
end

function part_2(input)
    return sum(corrected_score.(input))
end
@info part_2(input)
