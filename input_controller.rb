require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    gameboard = GameBoard.new 10, 10
    total_ships = 0
    ships = Array.new()
    read_file_lines(path){|line|
        if line =~ /\(([1-9]|10),([1-9]|10)\), (Left|Right|Up|Down), ([1-5])/ then
            # return nil if illegal addition occurs
            if  not gameboard.add_ship(Ship.new(Position.new($1.to_i, $2.to_i), $3, $4.to_i)) then
                return nil
            else
                # if add ship returns true then add 1 to total ships added
                total_ships += 1
            end
        end
    }
    # return the gameboard if 5 ships were added
    if total_ships == 5 then
        return gameboard   
    else
        return nil
    end
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    positions = Array.new
    # append proper numbers 1-10 to positions array to row and column respectively
    file_error = read_file_lines(path){|line|
        if line =~ /\(([1-9]|10),([1-9]|10)\)/ then
            positions.append(Position.new($1.to_i, $2.to_i))
        end
    }
    # if returned true, then file was able to be read
    if file_error then
       return positions   
    else
        return nil
    end
end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end
