#https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

#Any live cell with two or three live neighbours survives.
#Any dead cell with three live neighbours becomes a live cell.
#All other live cells die in the next generation. Similarly, all other dead cells stay dead.
=begin
O = alive
X = dead

Gen 0

O X X
X O O
O O X
=end

def make2DArray(cols,rows)
    grid = Array.new(cols) { Array.new(rows, 'O')}
    for x in 0...grid.length
        for y in 0...grid[0].length
            grid[x][y] = rand(2).floor()
        end
    end
    return grid
end

# Function to check if a cell
# (i, j) is valid or not
def valid(i, j, row,col)
    if (i >= 0 && j >= 0 && i < col && j < row)
        return true
    end
    return false
end
 
# Function to find sum of adjacent cells
# for cell (i, j)
def countNeighbors(i, j, v)
   # Store all 8 directions
    dir = [[1, 0], [-1, 0], [0, 1], [0, -1], [-1, -1], [-1, 1], [1, 1], [1, -1]]

    row = v.length
    col = v.length
    
    # Initialize sum
    s = 0
 
    # Visit all 8 directions
    for k in 0...8
 
        ni = i + dir[k][0];
        nj = j + dir[k][1];
 
        # Check if cell is valid
        if (valid(ni, nj, col, row))
            if v[ni][nj] == "O"
                s += 1
            end
        end
    end
    return s
end
 
# Function to print sum of adjacent elements
def gameOfLife(m)
   sum = 0
   
   nextGrid = Array.new(m.length) { Array.new(m[0].length, 0)}   
 
    # Iterate each elements of matrix
    for i in 0...m.length
        for j in 0...m[0].length
            state = m[i][j]
            # Find adjacent sum
            neighbors = countNeighbors(i, j, m)
            #puts "#{i} #{j} - #{neighbors}"
            #O = alive / X = dead
            if state == "X" && neighbors == 3
                nextGrid[i][j] = "O"          
            elsif state == "O" && (neighbors<2 || neighbors>3)
                nextGrid[i][j] = "X"
            else
                nextGrid[i][j]=state
            end
        end
    end    
    return nextGrid
end

def draw(grid)
    puts "\e[H\e[2J"
    puts "O = alive / X = dead"
    puts "----------------------------------------"
    grid.each do |g|
        puts g.inspect
    end
    puts "----------------------------------------"
end



# Given matrix

m = [["O", "X", "X"],
     ["X", "O", "O"],
     ["O", "O", "X"]
    ]
block = [   ["X", "X", "X","X"],
            ["X", "O", "O","X"],    
            ["X", "O", "O","X"],
            ["X", "X", "X","X"],
   ]
blinker = [   ["X", "X", "X","X","X"],
              ["X", "X", "O","X","X"],
              ["X", "X", "O","X","X"],
              ["X", "X", "O","X","X"],
              ["X", "X", "X","X","X"]
          ]   
toad = [["X", "X", "X","X", "X", "X"], 
        ["X", "X", "X", "X", "X", "X"], 
        ["X", "X", "O", "O", "O", "X"], 
        ["X", "O","O", "O", "X", "X"], 
        ["X", "X", "X", "X", "X", "X"], 
        ["X", "X", "X", "X", "X", "X"] 
       ]
m = blinker
draw(m)
10.times do
    m = gameOfLife(m)
    draw(m)
    sleep(0.3)
end