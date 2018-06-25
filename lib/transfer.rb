class Transfer
  # code here

attr_reader :sender, :receiver, :amount
attr_accessor :status

def initialize(sender,receiver,amount)
  @sender = sender
  @receiver = receiver
  @amount = amount
  @status = "pending"
end

def valid?
  if sender.valid? && receiver.valid?
    true
  else
    false
  end
end

def execute_transaction
  #will not run if transaction has been completed or rejected already
  if @status == "pending"
    
    @sender.balance = @sender.balance - @amount
    @receiver.balance = @receiver.balance + @amount
    
    if !@sender.valid?
      @status = "rejected"
      @sender.balance = @sender.balance + @amount
      @receiver.balance = @receiver.balance - @amount
      "Transaction rejected. Please check your account balance."
    else
      @status = "complete"
    end
  end
end

def reverse_transfer
  if @status == "complete"
    @sender.balance = @sender.balance + @amount
    @receiver.balance = @receiver.balance - @amount
    @status = "reversed"
  end
end

end
