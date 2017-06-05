class ManageDataController < ApplicationController

	def create
		@rooms = Array.new(100)
        
	 	File.foreach( params[:uploaded_data].path ).with_index do |line, index|  
	 		puts line
	 		lines_to_process = line.to_i+1 if index ==0
            next if index==0
	 		visitor_no, room_no, inout, time = line.split.map{|s| /^[0-9]+$/.match(s) ? s.to_i : s}
            @rooms[room_no] = [] if @rooms[room_no].blank?
            visited_list = @rooms[room_no].collect{|s| s.keys}.flatten.include?("#{visitor_no}")

            last_visit_data = @rooms[room_no].select{|s| s["#{visitor_no}"]}.first
            if visited_list
            	if inout =="I"
 					time_spent = last_visit_data["#{visitor_no}"] - time
 				else
 					time_spent = time - last_visit_data["#{visitor_no}"]
 				end 
 				last_visit_data["#{visitor_no}"]=time_spent
            else
            	@rooms[room_no] << {"#{visitor_no}" => time}

            end

	    end

	end

end