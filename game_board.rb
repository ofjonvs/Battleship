class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column, :board

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @board = Array.new(max_row) { Array.new(max_column, "-"){Array.new(2, "-")}}
        @successful_attacks = 0
        @total_ship_spots = 0
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        if ship.start_position.row < 1 or ship.start_position.row > @max_row or 
            ship.start_position.column < 1 or ship.start_position.column > @max_column
            return false
        end
        if ship.orientation == "Up" then
            # check if off board
            if (ship.start_position.row - ship.size + 1) < 1 then
                return false
            end
            # check overlap
            for i in 0..ship.size
                if @board[ship.start_position.row - i - 1][ship.start_position.column - 1][0] == "B" then
                    return false
                end
            end
            # adding to board
            for i in 0..ship.size - 1
                @board[ship.start_position.row - 1 - i][ship.start_position.column - 1][0] = "B"
            end
        elsif ship.orientation == "Down" then
            # check if off board
            if ship.start_position.row + ship.size - 1 > @max_row then
                return false
            end
            # check overlap
            for i in 0..ship.size-1
                if @board[ship.start_position.row + i - 1][ship.start_position.column - 1][0] == "B" then
                    return false
                end
            end
            # adding to board
            for i in 0..ship.size - 1
                @board[ship.start_position.row - 1 + i][ship.start_position.column - 1][0] = "B"
            end
        elsif ship.orientation == "Left" then
            # check if off board
            if(ship.start_position.column - ship.size + 1) < 1 then
                return false
            end
            # check overlap
            for i in 0..ship.size
                if @board[ship.start_position.row - 1][ship.start_position.column - i - 1][0] == "B" then
                    return false
                end
            end
            # adding to board
            for i in 0..ship.size - 1
                @board[ship.start_position.row - 1][ship.start_position.column - 1 - i][0] = "B"
            end
        elsif ship.orientation == "Right" then
            # check if off board
            if ship.start_position.column + ship.size - 1 > @max_column then
                return false
            end
            # check overlap
            for i in 0..ship.size-1
                if @board[ship.start_position.row - 1][ship.start_position.column - 1 + i][0] == "B" then
                    return false
                end
            end
            # adding to board
            for i in 0..ship.size - 1
                @board[ship.start_position.row - 1][ship.start_position.column - 1 + i][0] = "B"
            end
        end
        @total_ship_spots += ship.size
        return true
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position
        if position.row > @max_row or position.column > @max_column or
            position.row < 1 or position.column < 1 then
            return nil
        end
        # if adding to already used position simply return without doing anything
        if @board[position.row - 1][position.column - 1][1] == "A" then
            return true
        end
        # if not then mark the spot attacked and add 1 to the total successful attacks
        @board[position.row - 1][position.column - 1][1] = "A"
        if @board[position.row - 1][position.column - 1][0] == "B" then
            @successful_attacks += 1
            return true
        end
        return false
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        return @successful_attacks
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        if @successful_attacks == @total_ship_spots then
            return true
        else
            return false
        end
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
        for i in 0..(@board.size - 1)
            print @board[i]
            print "\n"
        end
    end
end

# arr = Array.new(3) { Array.new(3, "-"){Array.new(2, "-")}}
# print arr[0][0]