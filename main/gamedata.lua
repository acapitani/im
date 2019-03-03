-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions
local M = {}

M.rooms = {}
M.elevators = {}
M.keypuzzle = {}
M.paused = false
M.map = nil
M.map_visited = nil

M.current_elevator = nil			--indice del current elevator (1, 8)
M.current_floor = nil		--indice del piano corrente (1, 12) quello in alto e' 1
M.player_tunnel = nil	--tunnel del player (0 = tunnel sx, 1 = elevator (middle), 2 = tunnel dx)

M.current_room = nil				--indice della room corrente
M.player_roomentry = nil		-- {door_pos, door_dir}

M.in_game = false

function M.new()
	-- initialize the 32 rooms
	for i=1, 32 do
		M.rooms[i] = {objects = {}, visited = false, door_left = nil, door_right = nil}
	end
	-- initialize 8 elevators
	for i=1,8 do
		M.elevators[i] = {}
	end
	-- initialize the 16 puzzle keys
	for i=1, 16 do
		M.keypuzzle[i] = false
	end
	M.map = nil
	--blocchi visitati nella mappa della scena elevator
	M.map_visited = {}
	for y=1,6 do
		M.map_visited[y] = {}
		for x=1,19 do
			M.map_visited[y][x] = false
		end
	end
end

function M.get_object(room_id, object_id)
	return M.rooms[room_id][object_id]
end

function M.add_object(room_id, object_id, object_bag)
	M.rooms[room_id][object_id] = {timer = 10000, bag = object_bag}
end

function M.set_object_timer(room_id, object_id, timer)
	-- if timer == 0 the object is disabled
	M.rooms[room_id][object_id].timer = timer
end

function M.room_visited(room_id)
	M.current_room = room_id
	M.rooms[room_id].visited = true
end

function M.set_elevator_scene(elevator_id, floor_index, player_tunnel)
	--player_tunnel = 0 (sx) 1 (elevator) 2 (dx)
	M.current_elevator = elevator_id
	M.current_floor = floor_index
	M.player_tunnel = player_tunnel
	M.current_room = nil
end

function M.set_room_scene(room_id, door_pos, door_dir)
	--door_pos = 1 (top), 2 (bottom)
	--door_dir = false (left), true (right)
	
	M.current_room = room_id 
	M.current_elevator = nil
	M.player_roomentry = {door_pos = door_pos, door_dir = door_dir}
end
	
return M
