
class Student
	attr_reader :reg_id, :name, :fee, :no_of_ins
	attr_reader :no_of_paid_ins, :ins_str, :total_paid_fee

	def initialize reg_id, name, fee, no_of_ins
		@reg_id = reg_id 
		@name = name
		@fee = fee
		@no_of_ins = no_of_ins
		@ins_str = []
		no_of_ins.times do |i|
			@ins_str << (fee/no_of_ins)
		end
		@no_of_paid_ins = 0
		@total_paid_fee = 0
	end

	def pay_installment(amount_paid)
		if (@fee == @total_paid_fee)
			puts "your installments are complete. Don't pay more"
			return
		end
		amount = validate_amount(amount_paid)
		p "from pay_installment #{amount}"

		if (amount == (@fee - @total_paid_fee))
			complete_process(amount)

		elsif(amount == current_installment)
			pay_amount(amount)

		elsif (amount < current_installment) && (@no_of_paid_ins == (@no_of_ins-1)) 
			p create_new_installment(amount) ? "created" : "error"
		
		elsif (amount < current_installment)
			puts "press 1 to create new installment or 0 to adjust in next installment"
			if((gets.chomp).to_i == 1)
				p create_new_installment(amount) ? "created" : "error"
			else
				p update_next_installment(amount) ? "updated" : "Error"
			end
		elsif amount > current_installment
			p update_next_installment(amount) ? "decremented" : "Error"
		end
	end

	def display_status
		puts "Name: #{name}"
		puts "Fees remaining: #{@fee - @total_paid_fee}"
		puts "total_installments: #{ins_str.join("->")}"
		 
		str = ""
		for i in @no_of_paid_ins..@no_of_ins-1
			str += @ins_str[i].to_s
			str += "->"
		end
		puts "remaining installments: #{str.chomp("->")}"
	end

	def is_fees_paid
		return true if (@fee == (@total_paid_fee))
	end

private

	#function in case the user pays the whole of remaining fees 
	def complete_process(amount)
		p "in complete_process"
		@total_paid_fee = @total_paid_fee + amount
		p "paid_install: #{@no_of_paid_ins}"
		p "no_of_ins #{@no_of_ins}"
		@ins_str[@no_of_paid_ins] = amount
		(@no_of_ins - (@no_of_paid_ins+1)).times do
		   p @ins_str.pop
		   p @ins_str
		end
		
		@no_of_ins = @no_of_ins+1-(@no_of_ins-no_of_paid_ins)
		@no_of_paid_ins += 1
	end


	#updates the next installment in case the paid amount is less or greater than the installment
	#also removes an installment if the total amount is greater than the current + next installments
	def update_next_installment amount_paid
		amount = amount_paid - next_installment
		while(((@no_of_ins - @no_of_paid_ins) > 0) && (amount.to_i >= next_installment.to_i))
			p amount
			p next_installment
			p (@no_of_ins - @no_of_paid_ins)
			p @no_of_paid_ins
			@ins_str.delete_at(@no_of_paid_ins+1)
			amount = amount - next_installment
			@no_of_ins -= 1
		end
			amount = amount + next_installment
			@ins_str[(@no_of_paid_ins+1)] = (next_installment + (current_installment - amount))
			@ins_str[@no_of_paid_ins] = amount_paid
			@total_paid_fee += amount_paid
			increment_paid_installments
			p "You have #{@no_of_ins - @no_of_paid_ins} installments to pay"
	end


	def create_new_installment amount_paid
			@ins_str << (@ins_str[@no_of_paid_ins].to_i - amount_paid)
			@ins_str[@no_of_paid_ins] = amount_paid
			@total_paid_fee += amount_paid
			@no_of_ins += 1
			increment_paid_installments
	end


	#if the paid amount equals the installment amount
	def pay_amount(amount)
		@ins_str[@no_of_paid_ins] = amount
		@total_paid_fee = @total_paid_fee + amount
		@no_of_paid_ins += 1

	end


	def validate_amount(amount)
		unless (amount.is_a? Numeric)
			puts "Please enter a number"
			amount = gets.chomp.to_i
			return validate_amount(amount)
		end

		if(amount > (@fee - total_paid_fee))
			puts "The amount is more than the payable fees: Please Enter Again"
			puts "remaining amount to be paid : #{@fee - total_paid_fee}"
			amount = gets.chomp.to_i
			return validate_amount(amount)
		end

		if(amount < 0)
			puts "Amount can not be less than 0: Please enter again"
			amount = gets.chomp.to_i
			return validate_amount(amount)
		end
		return amount
	end

	def increment_paid_installments
		@no_of_paid_ins += 1 
	end 

	def next_installment
		@ins_str[(@no_of_paid_ins + 1)]
	end

	def current_installment
		return @ins_str[@no_of_paid_ins]
	end

end