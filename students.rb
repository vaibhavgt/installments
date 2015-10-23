load 'student.rb'

class Students
	@@stud_list = {}
	@@num_of_studs = 0

	def initialize name, fee, no_of_ins
		@@stud_list[1] = Student.new(1, name, fee, no_of_ins)
		@@num_of_studs += 1
	end

	def self.add(name, fee, no_of_ins)
		if @@stud_list.empty?
			Students.new(name, fee, no_of_ins)
		else
			@@stud_list[@@num_of_studs + 1] = Student.new(@@num_of_studs + 1, name, fee, no_of_ins)
			@@num_of_studs += 1
		end
		@@stud_list
	end

	def self.display
		@@stud_list.each do |reg_id, student|
			puts "registration id: #{reg_id}"
			puts "Name: #{student.name}"
			puts "Installments: #{(student.ins_str).join("->")}"
			puts "--------------------------------------------"
		end
	end

	def self.find(reg_id)
		if @@stud_list.include?(reg_id)
			return @@stud_list[reg_id]
		else
			return false
		end
	end

	def self.num_of_students
		@@num_of_studs
	end

end

