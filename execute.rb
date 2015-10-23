load 'students.rb'

Students.add("Vaibhav", 13000, 4)
Students.add("Amit" , 12000, 2)
Students.add("Shiv", 13500, 5)
Students.add("Mahesh", 10000, 4)
Students.display

# s = Students.find(1)
# p s
# s.pay_installment(12000)
# s.display_status
# s.pay_installment(3000)
# s.display_status
# p s



p "Number of Students: " + "#{Students.num_of_students}"
p "Want to pay installment for a student : y / n"
flag = gets.chomp.to_s
while(flag == "y")
	puts "Please Enter the Id of the Student to pay the installment"
	id = gets.chomp.to_i
	 if Students.find(id)
	 	 s = Students.find(id)
	 else
	 	puts "Please enter correct id"
	 	break
	 end
	s.display_status

	puts "Want to pay installment: y / n"
	ins_flag = gets.chomp.to_s
	while(ins_flag == "y")
		if (s.is_fees_paid)
			puts "===Fees completely paid for #{s.name}==="
			ins_flag = "n"
			s.display_status
			puts "===Fees completely paid for #{s.name}==="
			break
		end
		puts "Please Enter Amount"
		s.pay_installment(gets.chomp.to_i)
		s.display_status
		if (s.is_fees_paid)
			puts "===Fees completely paid for #{s.name}==="
			ins_flag = "n"
			s.display_status
			puts "===Fees completely paid for #{s.name}==="

			break
		end
		puts "Want to pay another installment: y / n"
		ins_flag = gets.chomp.to_s

	end
	puts "pay installment for another student: y / n"
	flag = gets.chomp.to_s
end
