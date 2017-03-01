## Gems ##
require 'console_splash'
require 'colorize'
#===========================================================#

## Puts the Splash Screen using console_splash ##
splash = ConsoleSplash.new()
splash.write_header("FloodIt", "Malvin Todorov", "1.0.0")
splash.write_horizontal_pattern("#")
splash.write_vertical_pattern("#")
splash.write_center(-3, "<Press Enter to Continue>")
splash.splash
gets 
#===========================================================#

## A Function that creates the Board ##
def get_board(width, height)
  colours = Array[:red, :blue, :green, :yellow, :cyan, :magenta]
  board = Array.new
  (0..height-1).each do |y|
    board_two = Array.new
    (0..width-1).each do |x|
      board_two.push colours.sample
    end
    board.push board_two
  end
  return board
end
#===========================================================#

## A Function that assigns colour to the colour keys ##
def get_colour(word)
  if word == 'r' 
    return :red
  elsif word == 'g' 
    return :green
  elsif word == 'b' 
    return :blue
  elsif word == 'y'  
    return :yellow
  elsif word == 'm' 
    return :magenta
  elsif word == 'c' 
    return :cyan
  else 
	return :cyan
  end
end
#===========================================================#

## A Function that checks the board completion ##
def get_completion(board,word)
  one_d = board.flatten
  length_one = one_d.length.round
  length_two = one_d.count(word).round
  one_percent = length_one/100.0
  percentage = (length_two/one_percent).round
end
#===========================================================#

## A Function that performs the actual gameplay ##
def get_gameplay(word,board,x,y,height,width)
  word_one = board[y][x]
  
  if word_one == word
    return
  end
  
  board[y][x] = word

  if x + 1< width
    if word_one == board[y+0][x+1] 
      get_gameplay(word, board, x + 1, y, height, width)
    end
  end
  
  if y + 1 < height
    if word_one == board[y+1][x+0] 
      get_gameplay(word, board, x, y + 1 ,height ,width)
    end
  end
  
  if x > 0  
    if word_one == board[y+0][x-1] 
      get_gameplay(word, board, x - 1, y, height, width)
    end
  end

  if y  > 0   
    if word_one == board[y-1][x+0] 
      get_gameplay(word, board, x, y - 1 ,height ,width)
    end
  end	
end
#===========================================================#

## The Implementation of the Menu ##
## Initial Variables ##
played_games = 0
best_score = 0
width = 14
height = 9
board = get_board(width, height)

while 1
  puts " "
  puts " Main Menu"
  puts " # s # Start New Game"
  puts " # c # Change Size of the Board"
  puts " # q # Quit"
  puts " "
  puts " Game Keys"
  puts " # r # Red"
  puts " # b # Blue"
  puts " # g # Green"
  puts " # y # Yellow"
  puts " # c # Cyan"
  puts " # m # Magenta"
  puts " "
## Displaying the best score if any games are played ##
  if played_games == 0 then
    puts " No games played."
  elsif played_games > 0 then
    puts " Best Game Score: #{best_score}."
  end
  
  print " Please enter your choise: "
  command = gets.chomp
  puts " "
  
## Start the game ## 
  if command == 's' then
    board = get_board(width, height)
    sample = board.flatten.first
    percentage = get_completion(board,sample)
    turns = 0

## Creating a new board with colourd boxes using colorize ##    
	while 1
      (board).each do |y|
        (y).each do |x|
          if x == :red
            print "  ".on_red
          elsif x == :blue 
            print "  ".on_blue
          elsif x == :green
            print "  ".on_green
          elsif x == :yellow
            print "  ".on_yellow
          elsif x == :cyan
            print "  ".on_cyan
          elsif x == :magenta
            print "  ".on_magenta
          end
        end
        puts " "
      end
	
      puts " Number of Turns: #{turns}"
      puts " Current Completion: #{percentage}%"

## Ending the game after is 100% completed ##
        if percentage == 100 then
          puts " You won after #{turns} turns."
          if played_games == 0 || turns < best_score then
            best_score = turns
          end
        break
        end	

## Enter the colour key ##		
      print " Choose a Colour: "
      word = gets.chomp
      puts " "
	  
## Quiting the game from the Menu ##	  
        if word == 'q' then
          played_games -= 1
        break
        end  

      colour = get_colour(word)
      get_gameplay(colour,board,0,0,height,width)	
      percentage = get_completion(board,colour)
      turns += 1
	end
    played_games += 1

## Changing the size of the Board ##
  elsif command == 'c' then
    played_games = 0
    print " Width is curently #{width}. Enter new: "
    width = gets.chomp.to_i
    print " Height is currently #{height}. Enter new: "
    height = gets.chomp.to_i 
  elsif command == 'q' then
    break 
  end
end
#===========================================================#